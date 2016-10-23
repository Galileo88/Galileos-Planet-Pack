using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{

   namespace FinalFrontier
   {
      public class VesselState
      {
         public double Timestamp { get; private set; }
         public Vessel Origin { get; private set; }
         public CelestialBody MainBody { get; private set; }
         public bool IsLanded { get; private set; }
         public bool IsSplashed { get; private set; }
         public bool IsLandedOrSplashed { get; private set; }
         public bool IsEVA { get; private set; }
         public bool IsLaunch { get; private set; }
         public bool IsPrelaunch { get; private set; }
         public bool OnSurface { get; private set; }
         public bool IsInAtmosphere { get; private set; }
         public bool HasFlagPlanted { get; private set; }
         public bool InOrbit { get; private set; }
         public Vessel.Situations Situation { get; private set; }
         public bool HasMovedOnSurface { get; private set; }

         public double ApA { get; private set; }
         public double ApR { get; private set; }
         public double PeA { get; private set; }
         public double PeR { get; private set; }
         public double altitude { get; private set; }

         public double atmDensity { get; private set; }

         public double MissionTime { get; private set; }
         public double LaunchTime { get; private set; }

         private VesselScan scan;

         public VesselState(Vessel vessel)
         {
            this.Timestamp = Planetarium.GetUniversalTime();
            this.Origin = vessel;
            this.MainBody = vessel.mainBody;
            this.IsLaunch = false;
            this.IsLanded = vessel.Landed;
            this.IsPrelaunch = (vessel.situation == Vessel.Situations.PRELAUNCH);
            this.IsSplashed = (vessel.situation == Vessel.Situations.SPLASHED);
            this.IsLandedOrSplashed = (IsSplashed || IsLanded);
            this.OnSurface = (IsSplashed || IsLanded || IsPrelaunch);
            this.IsEVA = vessel.isEVA;
            this.HasFlagPlanted = false;
            this.Situation = vessel.situation;
            this.InOrbit = vessel.isInStableOrbit();
            this.ApA = vessel.orbit.ApA;
            this.ApR = vessel.orbit.ApR;
            this.PeA = vessel.orbit.PeA;
            this.PeR = vessel.orbit.PeR;
            this.atmDensity = vessel.atmDensity;
            this.MissionTime = vessel.missionTime;
            this.LaunchTime = vessel.launchTime;
            this.HasMovedOnSurface = false;
            this.altitude = vessel.altitude;
            this.IsInAtmosphere = vessel.IsInAtmosphere();
         }

         public VesselState(VesselState state)
         {
            this.Origin = state.Origin;
            this.MainBody = state.MainBody;
            this.IsLanded = state.IsLanded;
            this.IsLaunch = state.IsLaunch;
            this.IsEVA = state.IsEVA;
            this.HasFlagPlanted = state.HasFlagPlanted;
            this.Situation = state.Situation;
            this.InOrbit = state.InOrbit;
            this.ApA = state.ApA;
            this.ApR = state.ApR;
            this.PeA = state.PeA;
            this.PeR = state.PeR;
            this.atmDensity = state.atmDensity;
            this.MissionTime = state.MissionTime;
            this.MissionTime = state.LaunchTime;
            this.HasMovedOnSurface = state.HasMovedOnSurface;
            this.altitude = state.altitude;
            this.IsInAtmosphere = state.IsInAtmosphere;
         }

         public VesselScan ScanVessel()
         {
            if (scan == null)
            {
               scan = new VesselScan(Origin);
            }
            return scan;
         }

         public VesselState NonEva()
         {
            VesselState state = new VesselState(this);
            state.IsEVA = false;
            return state;
         }

         public VesselState Docked()
         {
            VesselState state = new VesselState(this);
            state.Situation = Vessel.Situations.DOCKED;
            return state;
         }

         public VesselState FlagPlanted()
         {
            VesselState state = new VesselState(this);
            state.HasFlagPlanted = true;
            return state;
         }

         public VesselState MovedOnSurface()
         {
            VesselState state = new VesselState(this);
            state.HasMovedOnSurface = true;
            return state;
         }


         public static VesselState CreateFlagPlantedFromVessel(Vessel vessel)
         {
            VesselState state = new VesselState(vessel);
            state.HasFlagPlanted = true;
            return state;
         }


         public static VesselState CreateLaunchFromVessel(Vessel vessel)
         {
            VesselState state = new VesselState(vessel);
            state.IsLaunch = true;
            return state;
         }

         public override string ToString()
         {
            return Origin.name + " is " + Situation + " orbit=" + InOrbit;
         }
      }
   }
}
