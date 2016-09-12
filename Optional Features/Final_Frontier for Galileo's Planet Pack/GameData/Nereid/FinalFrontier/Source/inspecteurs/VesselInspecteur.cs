using System;
using UnityEngine;
using System.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;


namespace Nereid
{
   namespace FinalFrontier
   {
      public class VesselInspecteur : Inspecteur
      {
         private static readonly double MIN_INTERVAL = 0.20;


         private readonly List<Part> wheelParts = new List<Part>();

         public VesselInspecteur()
            : base(10, MIN_INTERVAL)
         {
            Reset();
         }


         public override void Reset()
         {
            this.wheelParts.Clear();
         }


         protected void InspectVesselParts(Vessel vessel)
         {
            foreach (Part part in vessel.Parts)
            {
               if (part.packed) part.Unpack();
               Log.Test(Utils.dump(part));
               foreach (PartResource r in part.Resources)
               {
               }
            }
         }

         protected override void ScanVessel(Vessel vessel)
         {
            wheelParts.Clear();
            if (vessel == null)
            {
            }
            else
            {
               // inspect parts if present
               if (vessel != null && vessel.Parts != null)
               {
                  InspectVesselParts(vessel);
               }
            }
         }


         protected override void Inspect(Vessel vessel)
         {
            if(vessel==null)
            {
            }
            else
            {
               /*foreach (Part p in drillParts)
               {
                  if (p.temperature > drillTemp)
                  {
                     drillTemp = p.temperature;
                  }
               }*/
            }
         }
      }
   }
}
