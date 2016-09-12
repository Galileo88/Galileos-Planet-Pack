using System;
using System.Collections.Generic;
using UnityEngine;
using KSP.IO;
using System.Threading;

namespace Nereid
{
   namespace FinalFrontier
   {

      public class HallOfFame :  IEnumerable<HallOfFameEntry>
      {
         private static volatile HallOfFame instance;
         // locking instance creation, just to be sure...
         private static readonly object instanceLock = new object();
         //
         public static HallOfFame Instance()
         {
            // thread safe singleton (just to be sure)
            lock (instanceLock)
            {
               if (instance == null)
               {
                  instance = new HallOfFame();
                  Log.Info("new hall of fame instance created");
               }
               return instance;
            }
         }

         class DefaultSorter : Sorter<HallOfFameEntry>
         {
            public void Sort(List<HallOfFameEntry> list)
            {
                list.Sort(delegate(HallOfFameEntry left, HallOfFameEntry right)
                {
                   return left.GetName().CompareTo(right.GetName());
                });
            }
         }

         private static readonly DefaultSorter DEFAULT_SORTER = new DefaultSorter();


         private Sorter<HallOfFameEntry> sorter = DEFAULT_SORTER; 

         // all accomplished achiements so far 
         private readonly HashSet<Achievement> accomplished;
         // current achievements given to crew in a single transaction
         private readonly HashSet<Achievement> currentTransaction;
         // all events
         private readonly List<LogbookEntry> logbook;

         private double currentTransactionTime=0;

         // the hall of fame of all kerbals
         private readonly List<HallOfFameEntry> entries;
         // map of known kerbals by name
         private readonly Dictionary<String, HallOfFameEntry> mapOfEntries;

         // marker if HallOfFame was stored in KSP persistence file
         public bool loaded { get; private set; }

         private HallOfFame()
         {
            Log.Info("creating hall of fame");
            if (instance != null)
            {
               Log.Error("hall of fame already created");
               throw new InvalidOperationException("hall of fame created twice");
            }
            this.entries = new List<HallOfFameEntry>();
            this.currentTransaction = new HashSet<Achievement>();
            this.accomplished = new HashSet<Achievement>();
            this.logbook = new List<LogbookEntry>();
            this.mapOfEntries = new Dictionary<String, HallOfFameEntry>();
            this.loaded = false;
         }

         /**
          * check kerbal type
          */
         private bool CheckKerbalType(ProtoCrewMember kerbal)
         {
            if(kerbal==null) return false;
            if (!kerbal.IsCrew() && !kerbal.IsApplicant())
            {
               if (Log.IsLogable(Log.LEVEL.DETAIL))
               {
                  Log.Detail("record for kerbal " + kerbal.name + " of type " + kerbal.type + " ignored");
               }
               return false;
            }
            return true;
         }

         /**
          * Persistence: Load HallOfFame
          */
         public void Load(ConfigNode node)
         {
            List<LogbookEntry> loaded = Persistence.LoadHallOfFame(node);

            if ( loaded != null )
            {
               Log.Info("hall of fame loaded (" + logbook.Count + " logbook entries)");

               Log.Detail("data for logbook loaded");
               //
               this.loaded = true;
               CreateFromLogbook(loaded);
            }
            else
            {
               Log.Warning("hall of fame not found in persistence file");
               this.loaded = false;
            }

            // for debugging the lost ribbons issue
            DumpStatistics();
         }

         /**
          * Persistence: Save HallOfFame
          */
         public void Save(ConfigNode node)
         {
            // for debugging the lost ribbons issue
            DumpStatistics();

            lock(this)
            {
               Persistence.SaveHallOfFame(logbook, node);
            }
         }

         /**
          * Just for debug: dump hall of fame to log.
          */
         public void DumpStatistics()
         {
            if(Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("Hall of Fame Statistics: ");
               foreach (HallOfFameEntry entry in entries)
               {
                  String name = entry.GetName();
                  Log.Detail(name + " has " + entry.GetRibbons().Count + " ribbons, " + entry.MissionsFlown + " missions flown in " + entry.TotalMissionTime + " seconds time");
                  if(!mapOfEntries.ContainsKey(name))
                  {
                     Log.Detail("kerbal " + name + " is not mapped in hall of fame!");
                  }
               }
            }
            Log.Detail("- End of Statistics -");
         }

         private HallOfFameEntry CreateEntry(String name, bool sort = true)
         {
            if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("creating entry " + name);
            lock (this)
            {
               if (mapOfEntries.ContainsKey(name))
               {
                  if(Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("hall of fame entry for kerbal " + name + " already existing");
                  HallOfFameEntry entry = mapOfEntries[name];
                  return entry;
               }
               else
               {
                  if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("new kerbal hall of fame entry for " + name);
                  HallOfFameEntry entry = new HallOfFameEntry(name);
                  entries.Add(entry);
                  mapOfEntries.Add(name, entry);
                  // sort entries again
                  if(sort) Sort();
                  return entry;
               }
            }
         }

         public HallOfFameEntry GetEntry(ProtoCrewMember kerbal)
         {
            lock (this)
            {
               HallOfFameEntry entry = GetEntry(kerbal.name);
               if (entry == null)
               {
                  // no entry found, create a new one
                  Log.Warning("no Hall of Fame entry found for kerbal " + kerbal.name);
                  entry = CreateEntry(kerbal.name);
               }
               // kerbal instances change during runtime
               if (entry.GetKerbal()!=null && !entry.GetKerbal().Equals(kerbal))
               {
                  Log.Warning("different kerbals with same name for " + kerbal.name+" (its safe to ignore this warning)");
                  // set the new kerbal
                  entry.SetKerbal(kerbal);
               }
               return entry;
            }
         }

         public HallOfFameEntry GetEntry(String name)
         {
            lock (this)
            {
               try
               {
                  return mapOfEntries[name];
               }
               catch
               {
                  if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("entry for kerbal " + name + " doesn't exists");
                  return null;
               }
            }
         }

         private LogbookEntry TakeLog(double time, String code, String name, String text = "")
         {
            lock (this)
            {
               if (time == 0.0) time = Planetarium.GetUniversalTime();
               LogbookEntry lbentry = new LogbookEntry(time, code, name, text);
               logbook.Add(lbentry);
               return lbentry;
            }
         }


         private void TakeLog(double time, String code, HallOfFameEntry entry, String text = "")
         {
            LogbookEntry lbentry = TakeLog(time, code, entry.GetName(), text);
            entry.AddLogRef(lbentry);
         }

         private void TakeLog(String code, HallOfFameEntry entry)
         {
            double time = Planetarium.GetUniversalTime();
            TakeLog(time, code, entry);
         }

         public void RecordMissionFinished(ProtoCrewMember kerbal)
         {
            if (!CheckKerbalType(kerbal)) return;
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("mission end recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + Utils.ConvertToKerbinTime(now));
            }
            Action action = ActionPool.ACTION_RECOVER;
            if (ActionPool.ACTION_RECOVER.DoAction(now, entry))
            {
               TakeLog(now, action.GetCode(), entry);
            }
         }

         public void RecordLaunch(ProtoCrewMember kerbal)
         {
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("launch recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + Utils.ConvertToKerbinTime(now));
            }
            Action action = ActionPool.ACTION_LAUNCH;
            if (action.DoAction(now, entry))
            {
               TakeLog(now, action.GetCode(), entry);
            }
         }

         public void RecordEva(ProtoCrewMember kerbal, Vessel fromVessel)
         {
            if (!CheckKerbalType(kerbal)) return;
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("EVA recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + Utils.ConvertToKerbinTime(now));
            }
            EvaAction action = Action.GetEvaAction(kerbal, fromVessel);
            if (action.DoAction(now, entry))
            {
               entry.evaAction = action;
               TakeLog(now, action.GetCode(), entry);
            }
         }

         public void RecordBoarding(ProtoCrewMember kerbal)
         {
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("vessel boarding recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + now + ", eva time was " + Utils.ConvertToKerbinTime(now - entry.TimeOfLastEva));
            }
            Action action = ActionPool.ACTION_BOARDING;
            if (action.DoAction(now, entry))
            {
               entry.evaAction = null;
               TakeLog(now, action.GetCode(), entry);
            }
         }

         public void RecordDocking(ProtoCrewMember kerbal)
         {
            if (!CheckKerbalType(kerbal)) return;
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("docking recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + Utils.ConvertToKerbinTime(now));
            }
            Action action = ActionPool.ACTION_DOCKING;
            if (action.DoAction(now, entry))
            {
               TakeLog(now, action.GetCode(), entry);
            }
         }

         public void RecordContract(ProtoCrewMember kerbal)
         {
            if (!CheckKerbalType(kerbal)) return;
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("completed contract recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + Utils.ConvertToKerbinTime(now));
            }
            Action action = ActionPool.ACTION_CONTRACT;
            if (action.DoAction(now, entry))
            {
               TakeLog(now, action.GetCode(), entry);
            }
         }

         public void RecordScience(ProtoCrewMember kerbal, double science)
         {
            HallOfFameEntry entry = GetEntry(kerbal);
            double now = Planetarium.GetUniversalTime();
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail(science.ToString("00")+" science recorded for kerbal " + kerbal.name + ": " + entry.GetName() + " at " + Utils.ConvertToKerbinTime(now));
            }

            Action action = ActionPool.ACTION_SCIENCE;
            String data = science.ToString();
            if (action.DoAction(now, entry, data))
            {
               TakeLog(now, action.GetCode(), entry, data);
            }
         }


         public void Record(ProtoCrewMember kerbal, Ribbon ribbon)
         {
            if (!CheckKerbalType(kerbal)) return;
            if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("Record ribbon " + ribbon.GetName());
            HallOfFameEntry entry = GetEntry(kerbal);
            // entry==null should never happen, but to analyze a bug in conjunction with other mods, we do a check
            if(entry==null)
            {
               Log.Error("failed to record ribbon " + ribbon.GetName() + " for kerbal " + kerbal.name + "(type=" + kerbal.type + "), because there is no entry in the hall of fame");
               Log.Error("please report the previous error in the forum");
               return;
            }
            Achievement achievement = ribbon.GetAchievement();
            double time = currentTransactionTime > 0 ? currentTransactionTime : Planetarium.GetUniversalTime();
            if (!achievement.HasToBeFirst() || !accomplished.Contains(achievement))
            {
               if (entry.Award(ribbon))
               {
                  if (Log.IsLogable(Log.LEVEL.INFO) || FinalFrontier.configuration.logRibbonAwards)
                  {
                     // log directly to make log outputs independent from log level if FinalFrontier.configuration.logRibbonAwards is set to true
                     Debug.Log("FF: ribbon " + ribbon.GetName() + " awarded to " + kerbal.name + " at " + time+" ("+Utils.ConvertToKerbinTime(time)+")");
                  }
                  TakeLog(time, ribbon.GetCode(), entry);
                  // no transaktion?
                  if(currentTransactionTime==0)
                  {
                     accomplished.Add(achievement);
                  }
               }
               else
               {
                  if(Log.IsLogable(Log.LEVEL.DETAIL))
                  {
                     Log.Detail("award of ribbon "+ribbon+" to kerbal "+kerbal.name+" failed");
                  }
               }
            }
            currentTransaction.Add(achievement);
         }

         public void RecordCustomRibbon(Ribbon ribbon)
         {
            CustomAchievement achievement = ribbon.GetAchievement() as CustomAchievement;
            if(achievement!=null)
            {
               int nr = achievement.GetIndex();
               double now = HighLogic.CurrentGame.UniversalTime;
               if (Log.IsLogable(Log.LEVEL.DETAIL))
               {
                  Log.Detail("new or changed custom ribbon " + ribbon.GetName() + " recorded  at " + Utils.ConvertToKerbinTime(now));
               }
               String code = DataChange.DATACHANGE_CUSTOMRIBBON.GetCode() + nr;
               TakeLog(now, code, achievement.GetName(), achievement.GetDescription());
            }
            else
            {
               Log.Error("invalid custom ribbon achievement");
            }
         }

         public void BeginArwardOfRibbons()
         {
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("begin award of ribbon transaction");
            }
            // just in case the last award wasn't finished...
            currentTransaction.Clear();
            currentTransactionTime = Planetarium.GetUniversalTime();
         }

         public void BeginArwardOfRibbons(double time)
         {
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("begin award of ribbon transaction at time " + time);
            }
            // just in case the last award wasn't finished...
            currentTransaction.Clear();
            currentTransactionTime = time;
         }

         public void EndArwardOfRibbons()
         {
            foreach (Achievement achievement in currentTransaction)
            {
               if (!accomplished.Contains(achievement))
               {
                  accomplished.Add(achievement);
               }
            }
            currentTransaction.Clear();
            currentTransactionTime = 0.0;
            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               Log.Detail("end award of ribbon transaction");
            }
         }


         /**
          * Remova a ribbon
          */
         public void Revocation(ProtoCrewMember kerbal, Ribbon ribbon, bool removeSuperseded = false)
         {
            Log.Detail("revocation of ribbon " + ribbon.GetName() + " for kerbal " + kerbal.name);
            HallOfFameEntry entry = GetEntry(kerbal);
            if(entry!=null)
            {
               bool successs = entry.Revocation(ribbon);
               if (!successs) return;
               //
               LogbookEntry logEntry;
               while ( (logEntry=logbook.Find(x => x.Name.Equals(kerbal.name) && x.Code.Equals(ribbon.GetCode())))!=null)
               {
                  logbook.Remove(logEntry);
               }
               // remove superseeded ribbons?
               if(removeSuperseded)
               {
                  Ribbon superseded = ribbon.SupersedeRibbon();
                  while(superseded !=null)
                  {
                     Revocation(kerbal, superseded, true);
                     superseded = superseded.SupersedeRibbon();
                  }
               }
            }
            else
            {
               Log.Warning("no entry for revocation from kerbal "+kerbal.name);
            }

         }

         public void Sort()
         {
            Log.Detail("sorting hall of fame");
            if(sorter!=null)
            {
               sorter.Sort(entries);
            }
            else
            {
               DEFAULT_SORTER.Sort(entries);
            }
         }

         public void SetSorter(Sorter<HallOfFameEntry> sorter)
         {
            this.sorter = sorter;
            Sort();
         }

         public void Refresh()
         {
            Log.Detail("refreshing hall of fame");
            Game game = HighLogic.CurrentGame;
            if (game == null || game.CrewRoster == null)
            {
               Log.Detail("no ongoing game: no refresh");
               return;
            }
            foreach (ProtoCrewMember kerbal in game.CrewRoster.Crew)
            {
               if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("refreshing kerbal "+kerbal.name+" in hall of fame");
               CreateEntry(kerbal.name,false);
            }
            Sort();
            Log.Info("hall of fame refreshed");
         }

         public void Clear()
         {
            lock (this)
            {
               Log.Info("clearing Final Frontier hall of fame");
               entries.Clear();
               logbook.Clear();
               mapOfEntries.Clear();
               accomplished.Clear();
               currentTransaction.Clear();
            }
         }

         public bool Contains(ProtoCrewMember kerbal)
         {
            lock (this)
            {
               foreach (HallOfFameEntry entry in entries)
               {
                  if (kerbal.name.Equals(entry.GetName())) return true;
               }
               return false;
            }
         }

         public void Remove(ProtoCrewMember kerbal)
         {
            lock(this)
            {
               HallOfFameEntry entry = GetEntry(kerbal);
               entries.Remove(entry);
            }
            Log.Detail("hall of fame entry for kerbal "+kerbal.name+" removed");
         }


         public System.Collections.IEnumerator GetEnumerator()
         {
            return entries.GetEnumerator();
         }

         IEnumerator<HallOfFameEntry> IEnumerable<HallOfFameEntry>.GetEnumerator()
         {
            return entries.GetEnumerator();
         }


         private void addLogbookEntry(LogbookEntry log, HallOfFameEntry entry)
         {
            lock (this)
            {
               logbook.Add(log);
               entry.AddLogRef(log);
            }
         }

         private void changeCustomRibbon(LogbookEntry log)
         {
            String code = "X" + log.Code.Substring(2);
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("changing custom ribbon for code " + code);

            Ribbon ribbon = RibbonPool.Instance().GetRibbonForCode(code);
            if(ribbon==null)
            {
               Log.Error("invalid custom ribbon code: " + code);
               return;
            }
            //
            CustomAchievement achievement = ribbon.GetAchievement() as CustomAchievement;
            if(achievement==null)
            {
               Log.Error("invalid custom ribbon achievement");
               return;
            }
            achievement.SetName(log.Name);
            achievement.SetDescription(log.Data);
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("custom ribbonchanged");
         }

         public void CreateFromLogbook(List<LogbookEntry> book)
         {
            Log.Detail("creating hall of fame from logbook");
            Clear();

            lock (this)
            {
               if (book.Count == 0)
               {
                  Log.Detail("no logbook entries");
                  return;
               }

               Log.Detail("resolving logbook");

               LogbookEntry lastEntry = null;

               foreach (LogbookEntry log in book)
               {
                  if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("processing logbook entry " + log.UniversalTime + ": " + log.Code + " " + log.Name);
                  try
                  {
                     // this is a custom ribbon entry
                     if (log.Code.StartsWith(DataChange.DATACHANGE_CUSTOMRIBBON.GetCode()))
                     {
                        changeCustomRibbon(log);
                        //
                        if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("adding custom ribbon " + log.Code + ": " + log.Name);
                        logbook.Add(log);
                        //
                        continue;
                     }
                     HallOfFameEntry entry = GetEntry(log.Name);
                     if (entry == null)
                     {
                        entry = CreateEntry(log.Name);
                     }
                     Action action = ActionPool.Instance().GetActionForCode(log.Code);
                     if (action != null)
                     {
                        action.DoAction(log.UniversalTime, entry, log.Data);
                        addLogbookEntry(log, entry);
                     }
                     else
                     {
                        // those codes have change
                        switch (log.Code)
                        {
                           case "CO": log.Code = "CO:Sun"; break;
                           case "CO1": log.Code = "CO1:Sun"; break;
                        }
                        //
                        Ribbon ribbon = RibbonPool.Instance().GetRibbonForCode(log.Code);
                        if (ribbon != null)
                        {
                           Achievement achievement = ribbon.GetAchievement();
                           bool sameTransaction = InSameTransaction(log, lastEntry);
                           if (!achievement.HasToBeFirst() || !accomplished.Contains(achievement) || sameTransaction)
                           {
                              // make sure old transactions have same timestamps in each entry
                              if (sameTransaction) log.UniversalTime = lastEntry.UniversalTime;
                              //
                              entry.Award(ribbon);
                              addLogbookEntry(log, entry);
                              // to prevent multiple first ribbon awards
                              accomplished.Add(ribbon.GetAchievement());
                           }
                        }
                        else
                        {
                           Log.Warning("no ribbon for code " + log.Code + " found");
                        }
                     }
                  }
                  catch (KeyNotFoundException)
                  {
                     Log.Error("kerbal " + log.Name + " not found");
                  }
                  catch (Exception e)
                  {
                     Log.Error("failed to create data in hall of fame for " + log.Name);
                     Log.Error(e.GetType()+": "+e.Message);
                  }
                  lastEntry = log;

               } // end for
            }
            Log.Detail("new hall of fame created");
         }

         private bool InSameTransaction(LogbookEntry a, LogbookEntry b)
         {
            // maximal diffence of timestamps in seconds
            double MAX_TIME_DIFF = 1.0; 
            if (a == null || b == null) return false;
            if (!a.Code.Equals(b.Code)) return false;
            if (a.UniversalTime > b.UniversalTime + MAX_TIME_DIFF || a.UniversalTime < b.UniversalTime - MAX_TIME_DIFF) return false;
            if (b.UniversalTime > a.UniversalTime + MAX_TIME_DIFF || b.UniversalTime < a.UniversalTime - MAX_TIME_DIFF) return false;
            return true;
         }


         public override string ToString()
         {
            String result = "HALL OF FAME ("+entries.Count+" entries):\n";
            foreach(HallOfFameEntry entry in entries)
            {
               String name =  entry.GetName();
               ProtoCrewMember kerbal = entry.GetKerbal();
               if(kerbal!=null)
               {
                  ProtoCrewMember currentkerbal = GameUtils.GetKerbalForName(name);
                  result = name+" - "+kerbal.Equals(currentkerbal)+" ("+(kerbal==currentkerbal)+")\n";
               }
               else
               {
                  result = name+" - null\n"; 
               }
            }
            return result;
         }

         public List<Ribbon> GetRibbonsOfLatestMission(ProtoCrewMember kerbal, double missionEndTime=0)
         {
            List<Ribbon> result = new List<Ribbon>();
            HallOfFameEntry entry = GetEntry(kerbal);
            //
            HashSet<Ribbon> ignored = new HashSet<Ribbon>();
            List<LogbookEntry> log = new List<LogbookEntry>(entry.GetLogRefs());
            log.Reverse();
            bool start = false;
            String codeLaunch=ActionPool.ACTION_LAUNCH.GetCode();
            String codeRecover=ActionPool.ACTION_RECOVER.GetCode();
            foreach(LogbookEntry logentry in log)
            {
               String code = logentry.Code;
               if (code.Equals(codeRecover) && !start)
               {
                  start = true;
               }
               // last launch or previous recover ends search
               // last launch: mission start detected
               // previous recover: there was no real launch
               else if (code.Equals(codeLaunch) || code.Equals(codeRecover))
               {
                  break;
               }
               else if (start || logentry.UniversalTime <= missionEndTime)
               {
                  Ribbon ribbon = RibbonPool.Instance().GetRibbonForCode(code);
                  if(ribbon!=null)
                  {
                     // add this ribbon if not already taken or superseded
                     if (!ignored.Contains(ribbon))
                     {
                        result.Add(ribbon);                       
                        // add the new ribbon and all superseded ribbons to the ignore set
                        while(ribbon!=null)
                        {
                           ignored.Add(ribbon);
                           ribbon = ribbon.SupersedeRibbon();
                        }
                     }
                  }
               }

            }
            return result;
         }
      }


   }
}