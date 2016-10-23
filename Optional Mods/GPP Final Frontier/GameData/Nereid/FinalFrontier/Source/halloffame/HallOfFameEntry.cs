using System;
using System.Text;
using UnityEngine;
using System.Collections.Generic;


namespace Nereid
{
   namespace FinalFrontier
   {

      public class HallOfFameEntry : IComparable<HallOfFameEntry>
      {
         // name of kerbal
         private readonly String name;
         private volatile WeakReference kerbalRef = null;
         // currently awarded ribbons
         private List<Ribbon> ribbons = new List<Ribbon>();
         // previously awarded ribbons , superseded by other ribbons
         private HashSet<Ribbon> supersededRibbons = new HashSet<Ribbon>();
         // the logbook entries of this kerbal
         private List<LogbookEntry> logbook = new List<LogbookEntry>();
         // the logbook as text
         private StringBuilder logtext = new StringBuilder("");

         public int MissionsFlown { get; set; }
         public int Dockings { get; set; }
         public double TimeOfLastLaunch { get; set; }
         public double TimeOfLastEva { get; set; }
         public double TotalMissionTime { get; set; }
         public double TotalEvaTime { get; set; }
         public double LastEvaDuration { get; set; }
         // Contracts
         public int ContractsCompleted { get; set; }
         // Science
         public double Research { get; set; }
         // Kerbal currently on Eva
         public bool IsOnEva { get; set; }
         // Action for specific ongoing EVA
         public EvaAction evaAction { get; set; }
         // special EVA times
         public double TotalTimeInEvaWithoutAtmosphere { get; set; }
         public double TotalTimeInEvaWithoutOxygen { get; set; }
         public double TotalTimeInEvaWithOxygen { get; set; }
         // celestial bodies visited
         public readonly HashSet<CelestialBody> visitedCelestialBodies = new HashSet<CelestialBody>();
         // grand tour fullfilled?
         public bool grandTour = false;
         // Jool tour fullfilled?
         public bool joolTour = false;


         public HallOfFameEntry(String name)
         {
            Log.Info("creating new hall of fame entry for kerbal "+name);
            this.name = name;
            this.kerbalRef = null;
            this.IsOnEva = false;
            this.TimeOfLastLaunch = -1;
            this.TimeOfLastEva = -1;
            this.TotalEvaTime = 0;
            this.LastEvaDuration = 0;
            this.evaAction = null;
            this.MissionsFlown = 0;
            //
            TotalTimeInEvaWithoutAtmosphere = 0;
            TotalTimeInEvaWithoutOxygen = 0;
            TotalTimeInEvaWithOxygen = 0;
         }

         public HallOfFameEntry(ProtoCrewMember kerbal)
            : this(kerbal.name)
         {
            this.kerbalRef = new WeakReference(kerbal);
         }

         int System.IComparable<HallOfFameEntry>.CompareTo(HallOfFameEntry right)
         {
            return name.CompareTo(right.name);
         }

         public override bool Equals(System.Object right)
         {
            if (right == null) return false;
            HallOfFameEntry cmp = right as HallOfFameEntry;
            if (cmp == null) return false;
            return name.Equals(cmp.name);
         }

         public override int GetHashCode()
         {
            return name.GetHashCode();
         }

         public bool HasRibbon(Ribbon ribbon)
         {
            return ribbons.Contains(ribbon);
         }

         /**
          * Add a reference to the corresponding logbook entry. This creates a personal logbook for this kerbal.
          * */
         public void AddLogRef(LogbookEntry lbentry)
         {
            logbook.Add(lbentry);
            if(logtext.Length>0) logtext.Append("\n");
            logtext.Append(lbentry.ToString());
         }

         /**
           * Returns the personal logbook for this kerbal.
           * */
         public List<LogbookEntry> GetLogRefs()
         {
            return logbook; //.AsReadOnly();
         }

         /**
          * Returns logbook in textform
          * */
         public String GetLogText()
         {
            return logtext.ToString();
         }


         /**
          * Returns the Kerbal for this entry.
          */
         public ProtoCrewMember GetKerbal()
         {
            if (this.kerbalRef == null || !this.kerbalRef.IsAlive) 
            {
               ProtoCrewMember kerbal = GameUtils.GetKerbalForName(name);
               if(kerbal != null)
               {
                  this.kerbalRef = new WeakReference(kerbal);
                  return kerbal;
               }
               else
               {
                  this.kerbalRef = null;
                  return null;
               }
            }
            return (ProtoCrewMember)this.kerbalRef.Target;
         }

         /**
          * Set the Kerbal for this entry.
          */
         public void SetKerbal(ProtoCrewMember kerbal)
         {
            if(kerbal==null)
            {
               Log.Error("can't change hall of fame entry to no kerbal (from=" + name+")");
            }
            if(name.Equals(kerbal.name))
            {
               this.kerbalRef = new WeakReference(kerbal);
            }
            else
            {
               Log.Error("can't change hall of fame entry to different kerbal (from="+name+",to="+kerbal.name+")");
            }
         }

         /**
          * Returns the name of the Kerbal for this entry.
          */
         public String GetName()
         {
            return name;
         }

         /**
          * Returns all ribbons for this entry.
          */
         public List<Ribbon> GetRibbons()
         {
            return ribbons;
         }

         /**
          * Remova a ribbon
          */
         public bool Revocation(Ribbon ribbon)
         {
            bool result = ribbons.Remove(ribbon);
            Ribbon superseded = ribbon.SupersedeRibbon();
            if(supersededRibbons.Contains(superseded))
            {
               supersededRibbons.Remove(superseded);
               ribbons.Add(superseded);
            }
            return result;
         }


         /**
          * Tries to award a ribbon. Returns true if successful, false otherwise.
          */
         public bool Award(Ribbon ribbon)
         {
            Log.Detail("awarding ribbon " + ribbon.GetCode()+" to "+name);
            // not currently awarded and not superseded by another ribbon
            if (!ribbons.Contains(ribbon) && !supersededRibbons.Contains(ribbon))
            {
               Log.Detail("new ribbon for kerbal " + name + ": " + ribbon.GetName());
               ribbons.Add(ribbon);
               Achievement achievement = ribbon.GetAchievement();
               achievement.ChangeEntryOnAward(this);
               // if this ribbon supersedes another, then remove the other ribbon
               Ribbon supersede = ribbon.SupersedeRibbon();
               while (supersede != null)
               {
                  Log.Detail("implicitely arwaded " + supersede.GetName());
                  supersededRibbons.Add(supersede);
                  if (ribbons.Remove(supersede))
                  {
                     Log.Detail("ribbon supersedes " + supersede.GetName());
                  }
                  supersede = supersede.SupersedeRibbon();
               }
               // sort ribbons by prestige
               ribbons.Sort();
               return true;
            }
            else if(Log.GetLevel()>=Log.LEVEL.DETAIL)
            {
               Log.Detail("ribbon not awarded because...");
               if (ribbons.Contains(ribbon)) Log.Detail("ribbon was already awarded");
               if (supersededRibbons.Contains(ribbon))
               {
                  Log.Detail("ribbon superseded by another ribbon");
                  foreach(Ribbon s in supersededRibbons)
                  {
                     Log.Detail("already superseded: " + ribbon.GetCode());                     
                  }
               }
            }
            return false;
         }

         public override string ToString()
         {
            StringBuilder sb = new StringBuilder();

            sb.Append("Hall Of Fame Entry for " + name + "\n");
            sb.Append("Time Of Last Launch: " + TimeOfLastLaunch + "\n");
            sb.Append("Missions: " + MissionsFlown + "\n");
            sb.Append("Dockings: " + Dockings + "\n");
            sb.Append("Log:\n");
            foreach (LogbookEntry entry in logbook)
            {
               sb.Append("  " + entry.ToString()+"\n");
            }
            return sb.ToString();
         }

      }
   }
}