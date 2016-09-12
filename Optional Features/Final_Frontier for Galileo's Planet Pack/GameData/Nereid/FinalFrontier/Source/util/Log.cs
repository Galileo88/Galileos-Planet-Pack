using System;
using UnityEngine;

namespace Nereid
{
   namespace FinalFrontier
   {
      public static class Log
      {
         public enum LEVEL { OFF=0, ERROR=1, WARNING=2, INFO=3, DETAIL=4, TRACE=5 };

         public static LEVEL level = LEVEL.INFO ;

         private static readonly String PREFIX = "FF: ";

         public static LEVEL GetLevel()
         {
            return level;
         }

         public static void SetLevel(LEVEL level)
         {
            Debug.Log("log level "+level);
            Log.level = level;
         }


         private static bool IsLevel(LEVEL level)
         {
            return level == Log.level;
         }

         public static bool IsLogable(LEVEL level)
         {
            return level <= Log.level;
         }

         public static void Trace(String msg)
         {
            if (IsLogable(LEVEL.TRACE))
            {
               Debug.Log(PREFIX + msg);
            }
         }

         public static void Detail(String msg)
         {
            if (IsLogable(LEVEL.DETAIL))
            {
               Debug.Log(PREFIX + msg);
            }
         }


         public static void Info(String msg)
         {
            if (IsLogable(LEVEL.INFO))
            {
               Debug.Log(PREFIX + msg);
            }
         }

         // for Debbung only; calls should be removed for release
         public static void Test(String msg)
         {
            if (IsLogable(LEVEL.INFO))
            {
               Debug.LogWarning(PREFIX+"TEST:" + msg);
            }
         }

         public static void Warning(String msg)
         {
            if (IsLogable(LEVEL.WARNING))
            {
               Debug.LogWarning(PREFIX + msg);
            }
         }

         public static void Error(String msg)
         {
            if (IsLogable(LEVEL.ERROR))
            {
               Debug.LogError(PREFIX + msg);
            }
         }

         private static void LogAchievement(Achievement achievement)
         {
            Debug.Log("+ name: " + achievement.GetName());
            Debug.Log("+ code: " + achievement.GetCode());
         }

         private static void LogVessel(Vessel vessel)
         {
            if (vessel != null)
            {
               Debug.Log("    - Vessel name:        " + vessel.name);
               Debug.Log("    - Vessel type:        " + vessel.vesselType);
               Debug.Log("    - Situation:          " + vessel.situation);
               Debug.Log("    - altitude:           " + vessel.altitude);
               Debug.Log("    - speed:              " + vessel.speed);
               Debug.Log("    - geeForce:           " + vessel.geeForce);
               Debug.Log("    - geeForce_immediate: " + vessel.geeForce_immediate);
               Debug.Log("    - GetTotalMass:       " + vessel.GetTotalMass());
               Debug.Log("    - MachNumber:         " + vessel.MachNumber());
            }
            else
            {
               Debug.Log("    - Vessel is <null>");
            }
         }

         private static void LogVesselState(VesselState state)
         {
            if(state!=null)
            {
               Debug.Log("  - Timestamp:          " + state.Timestamp);
               Debug.Log("  - Origin:             ");
               LogVessel(state.Origin);
               Debug.Log("  - MainBody:           " + (state.MainBody != null ? state.MainBody.name : "<null>"));
               Debug.Log("  - IsLanded:           " + state.IsLanded);
               Debug.Log("  - IsSplashed:         " + state.IsSplashed);
               Debug.Log("  - IsLandedOrSplashed: " + state.IsLandedOrSplashed);
               Debug.Log("  - IsEVA:              " + state.IsEVA);
               Debug.Log("  - IsLaunch:           " + state.IsLaunch);
               Debug.Log("  - IsPrelaunch:        " + state.IsPrelaunch);
               Debug.Log("  - OnSurface:          " + state.OnSurface);
               Debug.Log("  - IsInAtmosphere:     " + state.IsInAtmosphere);
               Debug.Log("  - HasFlagPlanted:     " + state.HasFlagPlanted);
               Debug.Log("  - InOrbit:            " + state.InOrbit);
               Debug.Log("  - Situation:          " + state.Situation);
               Debug.Log("  - HasMovedOnSurface:  " + state.HasMovedOnSurface);
            }
            else
            {
               Debug.Log("  - vessel state is <null>");
            }
         }

         public static void LogAchievement(Achievement achievement, VesselState previous, VesselState current)
         {
            Debug.Log("FF: ribbon achievement (vessel state):");
            LogAchievement(achievement);
            Debug.Log("+ previous vessel state:");
            LogVesselState(previous);
            Debug.Log("+ current vessel state:");
            LogVesselState(current);
            Debug.Log("+ - end -");
         }

         public static void LogAchievement(Achievement achievement, HallOfFameEntry entry)
         {
            Debug.Log("FF: ribbon achievement (hall of fame entry):");
            LogAchievement(achievement);
            Debug.Log("+ hall of fame entry:");
            ProtoCrewMember kerbal = entry.GetKerbal();
            if(kerbal!=null)
            {
               Debug.Log("  - Kerbal:                " + kerbal.name);
               Debug.Log("  - status:                " + kerbal.rosterStatus);
               Debug.Log("  - type:                  " + kerbal.type);
               Debug.Log("  - experience:            " + kerbal.experience);
            }
            else
            {
               Debug.Log("  - Kerbal:              NONE" );
            }
            Debug.Log("  - MissionsFlown:          " + entry.MissionsFlown);
            Debug.Log("  - Dockings:               " + entry.Dockings);
            Debug.Log("  - Research:               " + entry.Research);
            Debug.Log("  - joolTour:               " + entry.joolTour);
            Debug.Log("  - IsOnEva:                " + entry.IsOnEva);
            Debug.Log("  - TimeOfLastEva:          " + entry.TimeOfLastEva);
            Debug.Log("  - TimeOfLastLaunch:       " + entry.TimeOfLastLaunch);
            Debug.Log("  - TotalEvaTime:           " + entry.TotalEvaTime);
            Debug.Log("  - TotalMissionTime:       " + entry.TotalMissionTime);
            String visitedCelestialBodies = "";
            foreach (CelestialBody body in entry.visitedCelestialBodies)
            {
               visitedCelestialBodies = visitedCelestialBodies+body.name+" ";
            }
            Debug.Log("  - visitedCelestialBodies: " + visitedCelestialBodies);
            Debug.Log("+ - end -");
         }

         public static void LogAchievement(Achievement achievement, Contracts.Contract contract)
         {
            Debug.Log("FF: ribbon achievement (contract):");
            LogAchievement(achievement);
            if(contract!=null)
            {
               Debug.Log("  - Contract:              " + contract.Title);
               Debug.Log("  - Prestige:              " + contract.Prestige);
               Debug.Log("  - ContractState:         " + contract.ContractState);
               Debug.Log("  - ScienceCompletion:     " + contract.ScienceCompletion);
               Debug.Log("  - FundsCompletion:       " + contract.FundsCompletion);
               Debug.Log("  - DateAccepted:          " + contract.DateAccepted);
               Debug.Log("  - DateDeadline:          " + contract.DateDeadline);
               Debug.Log("  - Agent:                 " + contract.Agent);
            }
            else
            {
               Debug.Log("  - contract is <null>");
            }
            Debug.Log("+ - end -");
         }

         public static void LogAchievement(Achievement achievement, EventReport report)
         {
            Debug.Log("FF: ribbon achievement (report)");
            LogAchievement(achievement);
            if(report!=null)
            {
               Debug.Log("  - eventType:    " + report.eventType);
               Debug.Log("  - msg:          " + report.msg);
               Debug.Log("  - other:        " + report.other);
               if(report.origin!=null)
               {
                  Debug.Log("  - origin:        " + report.origin.name);
                  LogVessel(report.origin.vessel);
               }
               else
               {
                  Debug.Log("  -origin is <null>");
               }
            }
            else
            {
               Debug.Log("  - reoprt is <null>");
            }
            Debug.Log("+ - end -");
         }

         public static void LogAchievement(Achievement achievement, ProgressNode node)
         {
            Debug.Log("FF: ribbon achievement (progress node)");
            LogAchievement(achievement);
            if (node != null)
            {
               Debug.Log("  - Type:               " + node.GetType());
               Debug.Log("  - IsComplete:         " + node.IsComplete);
               Debug.Log("  - IsReached:          " + node.IsReached);
               Debug.Log("  - IsCompleteManned:   " + node.IsCompleteManned);
               Debug.Log("  - IsCompleteUnmanned: " + node.IsCompleteUnmanned);
            }
            else
            {
               Debug.Log("  - node is <null>");
            }
            Debug.Log("+ - end -");
         }

         public static void LogAchievement(Achievement achievement, ProtoCrewMember kerbal, ProtoCrewMember.RosterStatus oldState, ProtoCrewMember.RosterStatus newState)
         {
            Debug.Log("FF: ribbon achievement (roster status)");
            LogAchievement(achievement);
            Debug.Log("  - old state: " + oldState);
            Debug.Log("  - new state: " + newState);
            Debug.Log("+ - end -");
         }
      }
   }
}
