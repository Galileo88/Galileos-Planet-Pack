using System;
using System.Collections.Generic;
using UnityEngine;
using KSP.IO;

namespace Nereid
{
    namespace FinalFrontier
    {
        class AchievementRecorder
        {
            private readonly HallOfFame hallOfFame;

            public AchievementRecorder()
            {
                hallOfFame = HallOfFame.Instance();
            }

            public void RecordVesselRecovered(ProtoVessel vessel)
            {
                List<ProtoCrewMember> crew = vessel.GetVesselCrew();
                foreach (ProtoCrewMember member in crew)
                {
                   if (member.IsCrew())
                   {
                      Log.Info("kerbal " + member.name + " ended a mission ");
                      hallOfFame.RecordMissionFinished(member);
                   }
                }
            }

            public void RecordLaunch(Vessel vessel)
            {
               List<ProtoCrewMember> crew = vessel.GetVesselCrew();
               foreach (ProtoCrewMember member in crew)
               {
                  if (member.IsCrew())
                  {
                     Log.Info("kerbal " + member.name + " launched");
                     hallOfFame.RecordLaunch(member);
                  }
               }
            }

            public void RecordEva(ProtoCrewMember crew, Vessel fromVessel)
            {
               Log.Detail("kerbal " + crew + " on EVA");
               hallOfFame.RecordEva(crew, fromVessel);
            }

            public void RecordBoarding(ProtoCrewMember crew)
            {
               Log.Detail("kerbal " + crew + " returns from EVA");
               hallOfFame.RecordBoarding(crew);
            }

            public void RecordDocking(Vessel vessel)
            {
               List<ProtoCrewMember> crew = vessel.GetVesselCrew();
               foreach (ProtoCrewMember member in crew)
               {
                  // record crew member only
                  if (member.IsCrew())
                  {
                     Log.Info("kerbal " + member.name + " docked");
                     hallOfFame.RecordDocking(member);
                  }
               }
            }

            public void Record(Ribbon ribbon, ProtoCrewMember kerbal)
            {
               Achievement achievement = ribbon.GetAchievement();
               hallOfFame.Record(kerbal, ribbon);
            }


            public void Record(Ribbon ribbon, Vessel vessel)
            {
                List<ProtoCrewMember> crew = vessel.GetVesselCrew();
                CelestialBody body = vessel.mainBody;
                if (body != null)
                {
                    hallOfFame.BeginArwardOfRibbons();
                    foreach (ProtoCrewMember member in crew)
                    {
                       // record crew member only
                       if(member.IsCrew())
                       {
                          Record(ribbon, member);
                       }
                    }
                    hallOfFame.EndArwardOfRibbons();
                }
            }
        }

    }
}