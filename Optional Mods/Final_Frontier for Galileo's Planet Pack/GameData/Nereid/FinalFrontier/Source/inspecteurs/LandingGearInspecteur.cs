using System;
using UnityEngine;
using System.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;


namespace Nereid
{
   namespace FinalFrontier
   {
      public class LandingGearInspecteur : Inspecteur
      {
         private static readonly double MIN_INTERVAL = 0.20;


         private readonly List<ModuleLandingGear> modulesLandingGear = new List<ModuleLandingGear>();
         private readonly List<ModuleLandingGearFixed> modulesLandingGearFixed = new List<ModuleLandingGearFixed>();

         private int gearsOnGround;
         private bool allGearsOnGround;

         public LandingGearInspecteur()
            : base(10, MIN_INTERVAL)
         {
            Reset();
            GameEvents.onVesselSituationChange.Add(this.OnVesselSituationChange);
         }

         private void OnVesselSituationChange(GameEvents.HostedFromToAction<Vessel, Vessel.Situations> e)
         {
            Inspect(e.host);
         }

         public override void Reset()
         {
            this.gearsOnGround = 0;
            this.allGearsOnGround = true;
         }

         public int GetTotalLandingGears()
         {
            return modulesLandingGearFixed.Count + modulesLandingGear.Count;
         }

         public int GetLandingGearsOnGround()
         {
            return gearsOnGround;
         }

         public bool AllLandingsGearsOnGround()
         {
            return allGearsOnGround;
         }

         protected void ScanVesselParts(Vessel vessel)
         {
            if (vessel.Parts == null) return;
            foreach (Part part in vessel.Parts)
            {
               if (part.packed) part.Unpack();
               // test if part is landing gear
               foreach (PartModule module in part.Modules)
               {
                  ModuleLandingGear landingGear = module as ModuleLandingGear;
                  if (landingGear != null)
                  {
                     modulesLandingGear.Add(landingGear);
                     continue;
                  }
                  ModuleLandingGearFixed landingGearFixed = module as ModuleLandingGearFixed;
                  if (landingGearFixed != null)
                  {
                     modulesLandingGearFixed.Add(landingGearFixed);
                     continue;
                  }
               }
            }
         }

         protected override void ScanVessel(Vessel vessel)
         {
            modulesLandingGear.Clear();
            modulesLandingGearFixed.Clear();
            if (vessel != null)
            {
              ScanVesselParts(vessel);
            }
         }


         protected override void Inspect(Vessel vessel)
         {
            gearsOnGround = 0;
            allGearsOnGround = true;
            if (vessel != null)
            {
               foreach (ModuleLandingGear gear in modulesLandingGear)
               {
                  if (gear.wheelCollider.isGrounded)
                  {
                     gearsOnGround++;
                  }
                  else
                  {
                     allGearsOnGround = false;
                  }
               }
               foreach (ModuleLandingGearFixed gear in modulesLandingGearFixed)
               {
                  if (gear.wheelCollider.isGrounded)
                  {
                     gearsOnGround++;
                  }
                  else
                  {
                     allGearsOnGround = false;
                  }
               }
            }
         }
      }
   }
}
