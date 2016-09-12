using System;
using System.Collections.Generic;
using UnityEngine;
using System.Diagnostics;
using Contracts;


namespace Nereid
{

   namespace FinalFrontier
   {

      class EventObserver
      {
         private readonly AchievementRecorder recorder;

         private static VesselObserver vesselObserver = VesselObserver.Instance();

         // previous active vessel State
         private volatile VesselState previousVesselState;

         // custom events
         private bool orbitClosed = false;
         private bool deepAthmosphere = false;
         private long updateCycle = 0;
         private CelestialBody currentSphereOfInfluence = null;
         //
         private Vector3d lastVesselSurfacePosition;
         private bool landedVesselHasMoved = false;
         //
         private readonly GeeForceInspector geeForceInspector = new GeeForceInspector();
         private readonly MachNumberInspector machInspector = new MachNumberInspector();
         private readonly AltitudeInspector altitudeInspector = new AltitudeInspector();
         private readonly AtmosphereInspector atmosphereInspector = new AtmosphereInspector();
         private readonly OrbitInspector orbitInspector = new OrbitInspector();


         public EventObserver()
         {
            Log.Info("EventObserver:: registering events");
            //
            // recorder for recording in hall of fame
            this.recorder = new AchievementRecorder();
            //
            // Game
            GameEvents.onGamePause.Add(this.OnGamePause);
            GameEvents.onGameSceneLoadRequested.Add(this.OnGameSceneLoadRequested);
            GameEvents.onGameStateCreated.Add(this.OnGameStateCreated);
            //
            // Docking
            GameEvents.onPartCouple.Add(this.OnPartCouple);
            GameEvents.onPartAttach.Add(this.OnPartAttach);
            // EVA
            GameEvents.onCrewOnEva.Add(this.OnCrewOnEva);
            GameEvents.onCrewBoardVessel.Add(this.OnCrewBoardVessel);
            // Vessel
            GameEvents.onCollision.Add(this.OnCollision);
            GameEvents.onVesselWasModified.Add(this.OnVesselWasModified);
            GameEvents.onStageActivate.Add(this.OnStageActivate);
            GameEvents.onJointBreak.Add(this.OnJointBreak);
            GameEvents.onLaunch.Add(this.OnLaunch);
            GameEvents.onVesselGoOnRails.Add(this.OnVesselGoOnRails);
            GameEvents.onVesselSOIChanged.Add(this.OnVesselSOIChanged);
            GameEvents.onVesselSituationChange.Add(this.OnVesselSituationChange);
            GameEvents.onVesselChange.Add(this.OnVesselChange);
            GameEvents.onVesselRecovered.Add(this.OnVesselRecovered);
            GameEvents.onVesselOrbitClosed.Add(this.OnVesselOrbitClosed); // wont work in 0.23
            GameEvents.VesselSituation.onFlyBy.Add(this.OnFlyBy);
            GameEvents.VesselSituation.onReachSpace.Add(this.OnReachSpace);
            GameEvents.Contract.onCompleted.Add(this.OnContractCompleted);
            GameEvents.Contract.onFailed.Add(this.OnContractFailed);
            GameEvents.VesselSituation.onOrbit.Add(this.OnOrbit);
            GameEvents.OnScienceRecieved.Add(this.OnScienceReceived);
            GameEvents.onFlightReady.Add(this.OnFlightReady);
            // Kerbals
            GameEvents.onKerbalAdded.Add(this.OnKerbalAdded);
            GameEvents.onKerbalRemoved.Add(this.OnKerbalRemoved);
            GameEvents.onKerbalStatusChange.Add(this.OnKerbalStatusChange);
            GameEvents.OnCrewmemberHired.Add(this.OnCrewmemberHired);
            //
            // Other
            GameEvents.OnProgressAchieved.Add(this.OnProgressAchieved);
            //
         }


         private void OnFlyBy(Vessel vessel,CelestialBody body)
         {
            // for later usage
            //Log.Test("OnFlyBy "+vessel.name+" on "+body.name);
         }

         private void OnFlightReady()
         {
            // for later usage
         }

         private void OnOrbit(Vessel vessel, CelestialBody body)
         {
            if (vessel == null) return;
            Log.Info("vessel " + vessel.name + " has reached orbit around "+body.name);
            if (vessel.isActiveVessel)
            {
               CheckAchievementsForVessel(vessel);
            }
         }

         // wont detect zero atmosphere, because state SUB_ORBITAL begins above atmosphere height
         private void OnReachSpace(Vessel vessel)
         {
            if (vessel == null) return;
            Log.Info("vessel "+vessel.name+" has reached space");
            if (vessel.isActiveVessel)
            {
               CheckAchievementsForVessel(vessel);
            }
         }

         // KSP 1.0 (wont work anymore)
         private void OnScienceReceived(float science, ScienceSubject subject, ProtoVessel vessel)
         {
            OnScienceReceived(science, subject, vessel, true);
         }


         private void OnScienceReceived(float science, ScienceSubject subject, ProtoVessel vessel, bool flag)
         {
            Log.Detail("EventObserver::OnScienceReceived: " + science + ", flag=" + flag);
            if (vessel == null) return;
            HallOfFame halloffame = HallOfFame.Instance();
            //
            halloffame.BeginArwardOfRibbons();
            try
            {
               foreach (ProtoCrewMember kerbal in vessel.GetVesselCrew())
               {
                  // we want to check crew member only
                  if (kerbal.IsCrew())
                  {
                     halloffame.RecordScience(kerbal, science);
                     CheckAchievementsForCrew(kerbal, false);
                  }
               }
            }
            finally
            {
               // commit ribbons
               halloffame.EndArwardOfRibbons();
            }
         }

         private void OnContractFailed(Contract contract)
         {
            //Log.Test("contract failed " + contract.Title);
         }

         private void OnContractCompleted(Contract contract)
         {
            Vessel vessel = FlightGlobals.ActiveVessel;
            if(vessel==null) return;
            HallOfFame halloffame = HallOfFame.Instance();
            //
            halloffame.BeginArwardOfRibbons();
            try
            {
               foreach(ProtoCrewMember kerbal in vessel.GetVesselCrew() )
               {
                  // we want to check crew member only
                  if(kerbal.IsCrew())
                  {
                     halloffame.RecordContract(kerbal);
                     CheckAchievementsForCrew(kerbal, false);
                     CheckAchievementsForContracts(kerbal, contract);
                  }
               }
            }
            finally
            {
               halloffame.EndArwardOfRibbons();
            }
         }

         private void OnKerbalAdded(ProtoCrewMember kerbal)
         {
            Log.Info("kerbal added: " + kerbal.name);
            // just make sure this kerbal is in the hall of fame
            HallOfFame.Instance().GetEntry(kerbal);
            // and refresh
            HallOfFame.Instance().Refresh();
         }

         private void OnCrewmemberHired(ProtoCrewMember kerbal, int n)
         {
            Log.Info("crew member hired: " + kerbal.name+" ("+n+")");
            // just make sure this kerbal is in the hall of fame
            HallOfFame.Instance().GetEntry(kerbal);
            // and refresh
            HallOfFame.Instance().Refresh();
         }

         private void OnKerbalRemoved(ProtoCrewMember kerbal)
         {
            Log.Info("kerbal removed: "+kerbal.name);
            HallOfFame.Instance().Remove(kerbal);
         }

         private void OnKerbalStatusChange(ProtoCrewMember kerbal, ProtoCrewMember.RosterStatus oldState, ProtoCrewMember.RosterStatus newState)
         {
            if (kerbal == null) return;
            Log.Info("kerbal status change: " + kerbal.name + " from " + oldState + " to " + newState+" at time "+Planetarium.GetUniversalTime());
            HallOfFame.Instance().Refresh();
            //
            // check for achievements caused by status changes
            // (crew member only)
            /* not working because of the way KSP handles cre respawning
            if (kerbal.IsCrew())
            {
               Log.Detail("kerbal with status change is crew member");
               CheckAchievementsForRosterStatus(kerbal, oldState, newState);
            }*/
         }

         private void OnProgressAchieved(ProgressNode node)
         {
            Vessel vessel = FlightGlobals.ActiveVessel;
            // records achieved while not in a vessel won't count
            if (vessel == null) return;
            // records achieved while on a launch pad won't count
            if (vessel.situation == Vessel.Situations.PRELAUNCH) return;
            // ok, now check the record
            CheckAchievementsForProgress(node);
         }

         private void OnVesselWasModified(Vessel vessel)
         {
            // not used
         }

         private void OnGamePause()
         {
            // not used
         }         

         private void OnPartActionUICreate(Part part)
         {
            // not used
         }

         private void OnSceneChange()
         {
            // not used
         } 

         private void OnPartAttach(GameEvents.HostTargetAction<Part,Part> action)
         {
            // not used
         }

         private void OnPartCouple(GameEvents.FromToAction<Part, Part> action)
         {
            // checko for docking manouvers
            //
            // we are just checking flights
            if (!HighLogic.LoadedSceneIsFlight) return;
            Part from = action.from;
            Part to = action.to;
            Log.Detail("part couple event");
            // eva wont count as docking
            if (from == null || from.vessel == null || from.vessel.isEVA) return;
            Log.Detail("from vessel " + from.vessel);
            if (to == null || to.vessel == null || to.vessel.isEVA) return;
            Log.Detail("to vessel " + to.vessel);
            Vessel vessel = action.from.vessel.isActiveVessel?action.from.vessel:action.to.vessel;
            if (vessel != null && vessel.isActiveVessel)
            {
               Log.Info("docking vessel "+vessel.name);
               VesselState vesselState = new VesselState(vessel);
               // check achievements, but mark vessel as docked
               CheckAchievementsForVessel(vesselState.Docked());
               // record docking maneuver
               recorder.RecordDocking(vessel);
            }
         }

         private void OnVesselOrbitClosed(Vessel vessel)
         {
            orbitClosed = true;
            Log.Detail("EventObserver:: OnVesselOrbitClosed " + vessel.GetName());
            if(vessel.isActiveVessel)
            {
               CheckAchievementsForVessel(vessel);
            }
         }

         private void OnEnteringDeepAthmosphere(Vessel vessel)
         {
            Log.Detail("EventObserver:: OnEnteringDeepAthmosphere " + vessel.GetName() );
            if (vessel.isActiveVessel)
            {
               CheckAchievementsForVessel(vessel);
            }
         }

         private void OnLandedVesselMove(Vessel vessel)
         {
            Log.Detail("EventObserver:: OnLandedVesselMove " + vessel.GetName());
            if (vessel.isActiveVessel)
            {
               VesselState vesselState = new VesselState(vessel);
               CheckAchievementsForVessel(vesselState.MovedOnSurface());
            }
         }     
         
         private void OnCollision(EventReport report)
         {
            // just for safety
            if (report.origin != null && report.origin.vessel!=null)
            {
               Vessel vessel = report.origin.vessel;
               if (vessel.isActiveVessel)
               {
                  Log.Info("EventObserver:: collision detected for active vessel " + vessel.GetName());
                  CheckAchievementsForVessel(vessel, report);
               }
            }
         }

         private void OnGameSceneLoadRequested(GameScenes scene)
         {
            Log.Info("EventObserver:: OnGameSceneLoadRequested: "+scene+" current="+HighLogic.LoadedScene);
            this.previousVesselState = null;
         }

         private void OnJointBreak(EventReport report)
         {
            // not used
         }

         private void OnStageActivate(int stage)
         {
            Vessel vessel = FlightGlobals.ActiveVessel;
            if (vessel == null) return;
            Log.Detail("stage " +  stage +" activated for vessel "+vessel.name+" current mission time is "+vessel.missionTime);
         }

         private void SetSphereOfInfluence()
         {
            Vessel vessel = FlightGlobals.ActiveVessel;
            if(vessel!=null)
            {
               currentSphereOfInfluence = vessel.mainBody;
            }
            else
            {
               currentSphereOfInfluence = null;
            }
         }

         private void  OnCrewBoardVessel(GameEvents.FromToAction<Part, Part> action)
         {
            Log.Detail("EventObserver:: crew board vessel "+action.from.GetType());
            if (action.from == null || action.from.vessel == null) return;
            Part from = action.from;
            if (action.to == null || action.to.vessel == null) return;
            // boarding crew is still the active vessel
            Vessel eva = action.from.vessel;
            Vessel vessel = action.to.vessel;
            String nameOfKerbalOnEva = eva.vesselName;
            // find kerbal that return from eva in new crew
            ProtoCrewMember member = vessel.GetCrewMember(nameOfKerbalOnEva);
            if (member!=null && member.IsCrew())
            {
               Log.Detail(member.name + " returns from EVA to " + vessel.name);
               recorder.RecordBoarding(member);
               CheckAchievementsForCrew(member);
            }
            else
            {
               Log.Warning("boarding crew member " + nameOfKerbalOnEva+" not found in vesssel "+vessel.name);
            }
         }

         private void OnCrewOnEva(GameEvents.FromToAction<Part, Part> action)
         {
            Log.Detail("EventObserver:: crew on EVA");
            if (action.from == null || action.from.vessel == null) return;
            if (action.to == null || action.to.vessel == null) return;
            Vessel vessel = action.from.vessel;
            Vessel crew = action.to.vessel;
            // record EVA
            foreach(ProtoCrewMember member in crew.GetVesselCrew())
            {
               // record crew member only
               if (member.IsCrew())
               {
                  recorder.RecordEva(member, vessel);
               }
            }
            // the previous vessel shoud be previous
            this.previousVesselState = new VesselState(vessel);
            // current vessel is crew
            CheckAchievementsForVessel(crew);
         }

         private void OnGameStateCreated(Game game)
         {
            Log.Detail("OnGameStateCreated ");
            // do not load a game while in MAIN-MENU or SETTINGS
            // TODO: check if STILL NECESSARY????
            if (HighLogic.LoadedScene == GameScenes.MAINMENU || HighLogic.LoadedScene==GameScenes.SETTINGS)
            {
               // clear the hall of fame to avoid new games with ribbons from previos loads...
               HallOfFame.Instance().Clear();
               return;
            }

            // no game, no fun
            if (game == null)
            {
               Log.Warning("no game");
               return;
            }

            Log.Info("EventObserver:: OnGameStateCreated " + game.UniversalTime + ", game status: " + game.Status + ", scene " + HighLogic.LoadedScene);

            // we have to detect a closed orbit again...
            this.orbitClosed = false;

            ResetInspectors();

            vesselObserver.Revert(game.UniversalTime);
         }


         private void OnVesselRecovered(ProtoVessel vessel, bool flag)
         {
            // TODO: check what synopsis of "flag"
            if (vessel == null)
            {
               Log.Warning("vessel recover without a valid vessel detected");
               return;
            }

            Log.Info("EventObserver:: OnVesselRecovered " + vessel.vesselName);
            // record recover of vessel
            recorder.RecordVesselRecovered(vessel);
            // check for kerbal specific achiements
            HallOfFame.Instance().BeginArwardOfRibbons();
            foreach (ProtoCrewMember member in vessel.GetVesselCrew())
            {
               CheckAchievementsForCrew(member);
            }
            HallOfFame.Instance().EndArwardOfRibbons();
            //
            // ------ MissionSummary ------
            if(HighLogic.LoadedScene == GameScenes.SPACECENTER)
            {
               if (FinalFrontier.configuration.IsMissionSummaryEnabled())
               {
                  double technicalMissionEndTime = Planetarium.GetUniversalTime();
                  MissionSummaryWindow missionSummaryWindow = new MissionSummaryWindow();
                  missionSummaryWindow.SetSummaryForVessel(vessel, technicalMissionEndTime);
                  missionSummaryWindow.SetVisible(true);
               }
            }
            // 
            // refresh roster status
            HallOfFame.Instance().Refresh();
         }


         private void OnLaunch(EventReport report)
         {
            Log.Detail("vessel launched");
            Vessel vessel = FlightGlobals.ActiveVessel;
            if (vessel == null) return;
            ResetInspectors();
         }

         private void OnVesselGoOnRails(Vessel vessel)
         {
            // not used
         }

         private void CheckForLaunch(Vessel vessel, Vessel.Situations from, Vessel.Situations to)
         {
            if (from == Vessel.Situations.PRELAUNCH && to != Vessel.Situations.PRELAUNCH)
            {
               ResetInspectors();
               //
               Log.Detail("vessel mission time at launch: " + vessel.missionTime);
               //
               if (!vessel.isActiveVessel) return;
               //
               // check for Kerbin launch
               if (vessel.mainBody != null && vessel.mainBody.IsKerbin())
               {
                  Log.Info("launch of vessel " + vessel.name + " at kerbin detected at " + Utils.ConvertToKerbinTime(vessel.launchTime));
                  vesselObserver.SetKerbinLaunchTime(vessel, vessel.launchTime);
               }
               //
               ResetLandedVesselHasMovedFlag();
               recorder.RecordLaunch(vessel);
               //
               VesselState vesselState = VesselState.CreateLaunchFromVessel(vessel);
               CheckAchievementsForVessel(vesselState);
            }
         }

         private void OnVesselSituationChange(GameEvents.HostedFromToAction<Vessel, Vessel.Situations> e)
         {
            Vessel vessel = e.host;
            //
            if (vessel == null)
            {
               Log.Warning("vessel situation change without a valid vessel detected");
               return;
            }
            //
            // check for a (first) launch
            CheckForLaunch(vessel,e.from,e.to);

            if (vessel.isActiveVessel)
            {
               if (vessel.situation != Vessel.Situations.LANDED) ResetLandedVesselHasMovedFlag();
               //
               Log.Info("situation change for active vessel from " + e.from + " to " + e.to);
               CheckAchievementsForVessel(vessel);
            }
            else
            {
               if (vessel != null && vessel.IsFlag() && vessel.situation==Vessel.Situations.LANDED)
               {
                  Log.Info("situation change for flag");
                  Vessel active = FlightGlobals.ActiveVessel;
                  if (active != null && active.isEVA)
                  {
                     VesselState vesselState = VesselState.CreateFlagPlantedFromVessel(active);
                     CheckAchievementsForVessel(vesselState);
                     return;
                  }
               }
            }
         }

         private void OnVesselChange(Vessel vessel)
         {
            if(vessel==null)
            {
               Log.Warning("vessel change without a valid vessel detected");
               return;
            }

            // we have to detect a closed orbit again...
            this.orbitClosed = false;

            ResetInspectors();

            ResetLandedVesselHasMovedFlag();
            //
            Log.Info("EventObserver:: OnVesselChange " + vessel.GetName());
            if (!vessel.isActiveVessel) return;
            //
            this.previousVesselState = null;
            CheckAchievementsForVessel(vessel);
            //
            Log.Detail("vessel change finished");
         }

         private void OnVesselSOIChanged(GameEvents.HostedFromToAction<Vessel, CelestialBody> e)
         {
            this.orbitClosed = false;
            currentSphereOfInfluence = e.to;
            Vessel vessel = e.host;
            Log.Detail("sphere of influence changed to "+currentSphereOfInfluence+" for vessel "+vessel);
            if (vessel != null)
            {
               CheckAchievementsForVessel(vessel);
            }
         }

         private void CheckAchievementsForVessel(VesselState previous, VesselState current, EventReport report, bool hasToBeFirst)
         {
            if (current != null)
            {
               foreach (Ribbon ribbon in RibbonPool.Instance())
               {
                  Achievement achievement = ribbon.GetAchievement();
                  if (achievement.HasToBeFirst() == hasToBeFirst)
                  {
                     Vessel vessel = current.Origin;
                     // check situationchanges
                     if (achievement.Check(previous,current))
                     {
                        recorder.Record(ribbon, vessel);
                     }
                     // check events
                     if (report != null && achievement.Check(report))
                     {
                        recorder.Record(ribbon, vessel);
                     }
                  }
               }
            }
            else
            {
               Log.Warning("no current vessel state; achievemnts not checked");
            }
         }

         private void CheckAchievementsForVessel(VesselState previous, VesselState current, EventReport report)
         {
            // first check all first achievements
            CheckAchievementsForVessel(previous, current, report, true);
            // now check the rest
            CheckAchievementsForVessel(previous, current, report, false);
         }


         private void CheckAchievementsForVessel(VesselState currentVesselState, EventReport report = null)
         {
            Log.Detail("EventObserver:: checkArchivements for vessel state");
            Stopwatch sw = new Stopwatch();
            sw.Start();
            //
            CheckAchievementsForVessel(previousVesselState, currentVesselState, report);
            //
            sw.Stop();
            this.previousVesselState = currentVesselState;
            Log.Detail("EventObserver:: checkArchivements done in "+sw.ElapsedMilliseconds+" ms");
         }

         private void CheckAchievementsForVessel(Vessel vessel, EventReport report=null)
         {
            // just delegate
            CheckAchievementsForVessel(new VesselState(vessel), report);
         }

         private void CheckAchievementsForCrew(ProtoCrewMember kerbal, bool hasToBeFirst)
         {
            if (kerbal == null) return;
            // we want to check crew member only
            if (!kerbal.IsCrew()) return;
            // ok, lets check this kerbal
            HallOfFameEntry entry = HallOfFame.Instance().GetEntry(kerbal);
            if (entry != null)
            {
               foreach (Ribbon ribbon in RibbonPool.Instance())
               {
                  Achievement achievement = ribbon.GetAchievement();
                  if (achievement.HasToBeFirst() == hasToBeFirst)
                  {
                     if (achievement.Check(entry))
                     {
                        recorder.Record(ribbon, kerbal);
                     }
                  }
               }
            }
            else
            {
               Log.Warning("no entry for kerbal " + kerbal.name + " in hall of fame");
            }
         }

         private void CheckAchievementsForContracts(ProtoCrewMember kerbal, Contract contract)
         {
            Log.Detail("EventObserver:: checkArchivements for contract");
            Stopwatch sw = new Stopwatch();
            sw.Start();

            CheckAchievementsForContracts(kerbal, contract, true);
            CheckAchievementsForContracts(kerbal, contract, false);

            Log.Detail("EventObserver:: checkArchivements done in " + sw.ElapsedMilliseconds + " ms");
         }

         private void CheckAchievementsForContracts(ProtoCrewMember kerbal, Contract contract, bool hasToBeFirst)
         {

            if (kerbal == null) return;
            // we want to check crew member only
            if (!kerbal.IsCrew()) return;
            // ok, lets check the kerbal
            foreach (Ribbon ribbon in RibbonPool.Instance())
            {
               Achievement achievement = ribbon.GetAchievement();
               if (achievement.HasToBeFirst() == hasToBeFirst)
               {
                  if (achievement.Check(contract))
                  {
                     recorder.Record(ribbon, kerbal);
                  }
               }
            }
         }

         private void CheckAchievementsForRosterStatus(ProtoCrewMember kerbal , ProtoCrewMember.RosterStatus oldState, ProtoCrewMember.RosterStatus newState)
         {
            Log.Detail("EventObserver:: checkArchivements for roster status");
            Stopwatch sw = new Stopwatch();
            sw.Start();

            CheckAchievementsForRosterStatus(kerbal, oldState, newState, true);
            CheckAchievementsForRosterStatus(kerbal, oldState, newState, false);

            Log.Detail("EventObserver:: checkArchivements done in " + sw.ElapsedMilliseconds + " ms");
         }

         private void CheckAchievementsForRosterStatus(ProtoCrewMember kerbal , ProtoCrewMember.RosterStatus oldState, ProtoCrewMember.RosterStatus newState, bool hasToBeFirst)
         {
            foreach (Ribbon ribbon in RibbonPool.Instance())
            {
               Achievement achievement = ribbon.GetAchievement();
               if (achievement.Check(kerbal,oldState,newState))
               {
                  // record crew member only
                  if (kerbal.IsCrew())
                  {
                     recorder.Record(ribbon, kerbal);
                  }
               }
            }
         }


         private void CheckAchievementsForProgress(ProgressNode node)
         {
            Vessel vessel = FlightGlobals.ActiveVessel;
            HallOfFame halloffame = HallOfFame.Instance();
            if(vessel != null)
            {
               foreach (Ribbon ribbon in RibbonPool.Instance())
               {
                  Achievement achievement = ribbon.GetAchievement();
                  if(achievement.Check(node))
                  {
                     halloffame.BeginArwardOfRibbons();
                     try
                     {
                        foreach(ProtoCrewMember member in vessel.GetVesselCrew())
                        {
                           // record crew member only
                           if (member.IsCrew())
                           {
                              recorder.Record(ribbon, member);
                           }
                        }
                     }
                     finally
                     {
                        halloffame.EndArwardOfRibbons();
                     }
                  }
               }
            }

         }

         private void CheckAchievementsForCrew(ProtoCrewMember kerbal)
         {
            // just for safety
            if (kerbal == null) return;
            // we want to check crew member only
            if (!kerbal.IsCrew()) return;
            // ok, lets check the kerbal
            Log.Detail("EventObserver:: checkArchivements for kerbal " + kerbal.name);
            Stopwatch sw = new Stopwatch();
            sw.Start();
            //
            // first check all first achievements
            CheckAchievementsForCrew(kerbal, true);
            // now check the rest
            CheckAchievementsForCrew(kerbal, false);
            //
            sw.Stop();
            Log.Detail("EventObserver:: checkArchivements done in "+sw.ElapsedMilliseconds+" ms");
         }

         // TODO: move to EventObserver
         private void FireCustomEvents()
         {
            // detect events only in flight
            if (HighLogic.LoadedScene != GameScenes.FLIGHT) return;
            //
            Vessel vessel = FlightGlobals.ActiveVessel;
            if (vessel != null)
            {
               // undetected SOI change (caused by hyperedit or other mods)
               if(currentSphereOfInfluence==null || !currentSphereOfInfluence.Equals(vessel.mainBody))
               {
                  OnVesselSOIChanged(new GameEvents.HostedFromToAction<Vessel, CelestialBody>(vessel, currentSphereOfInfluence, vessel.mainBody));
               }
               // Orbit closed
               bool inOrbit = vessel.isInStableOrbit();
               if (inOrbit && !orbitClosed)
               {
                  Log.Info("orbit closed detected for vessel " + vessel.name);
                  OnVesselOrbitClosed(vessel);
               }
               orbitClosed = inOrbit;
               //
               // deep atmosphere
               double atmDensity = vessel.atmDensity;
               if (!deepAthmosphere && atmDensity >= 10.0)
               {
                  Log.Trace("vessel entering deep athmosphere");
                  deepAthmosphere = true;
                  OnEnteringDeepAthmosphere(vessel);
               }
               else if (deepAthmosphere && atmDensity < 10.0)
               {
                  deepAthmosphere = false;
               }
            }
            else
            {
               orbitClosed = false;
               deepAthmosphere = false;
            }
            //
            // G-force increased
            bool geeForceStateChanged = geeForceInspector.StateHasChanged();
            if (geeForceStateChanged)
            {
               VesselObserver.Instance().SetGeeForceSustained(vessel, geeForceInspector.GetGeeNumber());
            }
            // Mach increased
            // AtmosphereChanged
            // Orbit changed
            // gee force changed
            if (machInspector.StateHasChanged() || atmosphereInspector.StateHasChanged() || orbitInspector.StateHasChanged() || geeForceStateChanged)
            {
               CheckAchievementsForVessel(vessel);
            }

         }

         private void ResetLandedVesselHasMovedFlag()
         {
            Log.Detail("reset of LandedVesselHasMovedFlag");
            landedVesselHasMoved = false;
            lastVesselSurfacePosition = Vector3d.zero;
         }

         private bool checkIfLandedVesselHasMoved(Vessel vessel)
         {
            if(vessel != null)
            {
               // no rover, no driving vehilce, sorry
               if (vessel.vesselType != VesselType.Rover) return false;
               //
               if (vessel.situation == Vessel.Situations.LANDED)
               {
                  Vector3d currentVesselPosition = vessel.GetWorldPos3D();
                  double distance = Vector3d.Distance(currentVesselPosition, this.lastVesselSurfacePosition);
                  if(distance > Constants.MIN_DISTANCE_FOR_MOVING_VEHICLE_ON_SURFACE)
                  {
                     if (this.lastVesselSurfacePosition != Vector3d.zero )
                     {
                        return true;
                     }
                     this.lastVesselSurfacePosition = currentVesselPosition;
                  }
               }
               else
               {
                  // not landed, so ignore this position
                  this.lastVesselSurfacePosition = Vector3d.zero;
               }
            }
            else
            {
               // no vessel, so ignore this position
               this.lastVesselSurfacePosition = Vector3d.zero;
            }
            return false;
         }


         private void ResetInspectors()
         {
            if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("reset inspectors");
            machInspector.Reset();
            altitudeInspector.Reset();
            geeForceInspector.Reset();
            atmosphereInspector.Reset();
            orbitInspector.Reset();
         }


         private void ClearInspectors()
         {
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("clearing inspectors");
            machInspector.Clear();
            altitudeInspector.Clear();
            geeForceInspector.Clear();
            atmosphereInspector.Clear();
            orbitInspector.Clear();
         }

         public void Update()
         {
            // game eventy occur in FLIGHT only
            if ( !HighLogic.LoadedScene.Equals(GameScenes.FLIGHT) ) return;

            updateCycle++;
            // test custom events every fifth update
            if (updateCycle % 5 == 0)
            {

               Vessel vessel = FlightGlobals.ActiveVessel;
               if (vessel != null)
               {
                  if (!landedVesselHasMoved && checkIfLandedVesselHasMoved(vessel))
                  {
                     landedVesselHasMoved = true;
                     OnLandedVesselMove(vessel);
                  }

                  geeForceInspector.Inspect(vessel);

                  altitudeInspector.Inspect(vessel);
                  if(altitudeInspector.StateHasChanged())
                  {
                     if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("reset of mach and altitude inspecteurs because of change in altitude");
                     machInspector.Reset();
                     altitudeInspector.Reset();
                  }

                  machInspector.Inspect(vessel);

                  atmosphereInspector.Inspect(vessel);

                  orbitInspector.Inspect(vessel);
               }
            }

            // test for custom events each second
            if (updateCycle % 60 == 0)
            {
               FireCustomEvents();
               ClearInspectors();
            }
         }

      }
   }
}