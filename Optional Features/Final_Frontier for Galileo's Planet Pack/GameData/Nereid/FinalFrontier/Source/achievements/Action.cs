using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Nereid
{
   namespace FinalFrontier
   {
      public abstract class Action : Activity
      {
         public Action(String code, String name)
            : base (code, name)
         {
         }

         public abstract bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "");

         public static EvaAction GetEvaAction(ProtoCrewMember kerbal, Vessel fromVessel)
         {
            if (fromVessel != null)
            {
               bool atmosphere = fromVessel.IsInAtmosphere();
               bool oxygen = fromVessel.IsInAtmosphereWithOxygen();
               if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("creating EVA action for kerbal " + kerbal.name + " in atmosphere:" + atmosphere + ", oxygen:" + oxygen);
               if (atmosphere && oxygen)
               {
                  return ActionPool.ACTION_EVA_OXYGEN;                     
               }
               else if (atmosphere && ! oxygen)
               {
                  return ActionPool.ACTION_EVA_INATM;                     
               }
               else if (!atmosphere)
               {
                  return ActionPool.ACTION_EVA_NOATM;                     
               }
               else
               {
                  Log.Warning("unexpected EVA situation");
                  return ActionPool.ACTION_EVA_NOATM;
               }
            }
            else
            {
               Log.Warning("no vessel for kerbal "+kerbal.name+" on EVA");
               return ActionPool.ACTION_EVA_NOATM;
            }
         }
      }

      public class BoardingAction : Action
      {
         public BoardingAction() : base("B+", "Kerbal Boarding Vessel") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            if (entry == null)
            {
               Log.Error("boarding: no hall of fame entry");
               return false;
            }
            ProtoCrewMember kerbal = entry.GetKerbal();
            if(kerbal==null)
            {
               Log.Error("boarding: no kerbal in hall of fame entry");
               return false;
            }
            try
            {
               if (entry.TimeOfLastEva >= 0)
               {
                  if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("end of EVA for kerbal " + kerbal.name + ": " + entry.TotalEvaTime + " eva time");
                  if (entry.TotalEvaTime >= 0)
                  {
                     entry.LastEvaDuration = timeOfAction - entry.TimeOfLastEva;
                     entry.TotalEvaTime += entry.LastEvaDuration;
                     // specific EVA actions
                     if(entry.evaAction!=null)
                     {
                        entry.evaAction.OnBoardingVessel(timeOfAction, entry);
                     }
                     else
                     {
                        if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("boarding vessel ingored: no EVA action defined for " + kerbal.name + " at " + timeOfAction);
                     }
                  }
                  return true;
               }
               else
               {
                  Log.Warning("return from EVA ignored for "+kerbal.name+" at "+timeOfAction);
                  return false;
               }
            }
            finally
            {
               if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("EVA for kerbal " + kerbal.name + " has ended");
               entry.IsOnEva = false;
               entry.evaAction = null;
            }
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " returns from EVA";
         }  
      }

      public class DockingAction : Action
      {
         public DockingAction() : base("D+", "Vessel docked") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            entry.Dockings++;
            return true;
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " has docked on another spacecraft";
         }   
      }

      public class LaunchAction : Action
      {
         public LaunchAction() : base("L+", "Launching Vessel") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            entry.TimeOfLastLaunch = timeOfAction;
            return true;
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " launched a mission";
         }
      }

      public class RecoverAction : Action
      {
         public RecoverAction() : base("M+", "Vessel recovered") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            ProtoCrewMember kerbal = entry.GetKerbal();
            try
            {
               // no ongoing mission mission, no mission at all
               if (entry.TimeOfLastLaunch >= 0)
               {
                  entry.MissionsFlown++;
                  if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("mission recover recorded for kerbal " + kerbal.name + ": " + entry.MissionsFlown + " missions flown");

                  entry.TotalMissionTime += (timeOfAction - entry.TimeOfLastLaunch);
                  return true;
               }
               else
               {
                  Log.Warning("recover of kerbal " + kerbal.name + " without ongoing mission");
                  return false;
               }
            }
            finally
            {
               if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("kerbal " + kerbal.name + " no longer on mission");
               entry.TimeOfLastLaunch = -1;
               entry.IsOnEva = false;
            }
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " has returned from a mission";
         }
      }

      public abstract class EvaAction : Action
      {
         public EvaAction(String code, String name) : base(code, name) { }

         public abstract void OnBoardingVessel(double timeOfAction, HallOfFameEntry entry);
      }

      public class EvaNoAtmosphereAction : EvaAction
      {
         public EvaNoAtmosphereAction() : base("E+", "Kerbal on Eva in zero atmosphere") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            entry.TimeOfLastEva = timeOfAction;
            return true;
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " begins EVA in zero atmosphere";
         }

         public override void OnBoardingVessel(double timeOfAction, HallOfFameEntry entry)
         {
            if (entry.TimeOfLastEva <= 0) return;
            entry.TotalTimeInEvaWithoutOxygen += timeOfAction - entry.TimeOfLastEva;
         }
      }




      public class EvaWithOxygen : EvaAction
      {
         public EvaWithOxygen() : base("EX+", "Kerbal on Eva in atmosphere with oxygen") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            entry.TimeOfLastEva = timeOfAction;
            return true;
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " begins EVA in atmosphere";
         }

         public override void OnBoardingVessel(double timeOfAction, HallOfFameEntry entry)
         {
            if (entry.TimeOfLastEva <= 0) return;
            entry.TotalTimeInEvaWithOxygen += timeOfAction - entry.TimeOfLastEva;
         }
      }

      public class EvaInAtmosphereAction : EvaAction
      {
         public EvaInAtmosphereAction() : base("EA+", "Kerbal on Eva in toxic atmosphere without oxygen") { }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            entry.TimeOfLastEva = timeOfAction;
            return true;
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " begins EVA in toxic atmosphere";
         }

         public override void OnBoardingVessel(double timeOfAction, HallOfFameEntry entry)
         {
            if (entry.TimeOfLastEva <= 0) return;
            entry.TotalTimeInEvaWithoutOxygen += timeOfAction - entry.TimeOfLastEva;
         }
      }

      public class ContractAction : Action
      {
         public ContractAction() : base("C+", "Contract completed") { }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            return entry.Name + " has completed a contract";
         }

         public override bool DoAction(double timeOfAction, HallOfFameEntry entry, String data = "")
         {
            entry.ContractsCompleted++;
            return true;
         }
      }

      public class ScienceAction : Action
      {
         public ScienceAction()
            : base("S+", "Science")
         {
         }

         public override bool DoAction(double timeOfService, HallOfFameEntry entry, String data = "")
         {
            try
            {
              entry.Research += Double.Parse(data);
              return true;
            }
            catch
            {
               Log.Error("invalid data for science in entry for kerbal "+entry.GetName()+": "+data);
               return false;
            }
         }

         public override string CreateLogBookEntry(LogbookEntry entry)
         {
            try
            {
               double science = Double.Parse(entry.Data);
               return entry.Name + " has researched " + science.ToString("0.0") + " science points";
            }
            catch
            {
               return entry.Name + " has researched an unknown amount of science points";
            }
         }
      }
   }
}
