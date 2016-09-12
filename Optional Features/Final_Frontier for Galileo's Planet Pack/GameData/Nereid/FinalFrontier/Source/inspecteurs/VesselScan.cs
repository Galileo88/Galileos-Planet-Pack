using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace Nereid
{
   namespace FinalFrontier
   {
      public class VesselScan
      {
         public Vessel vessel { get; private set; }
         public int parachutes { get; private set; }
         public int stowedParachutes { get; private set; }
         public int deployedParachutes { get; private set; }
         public int semiDeployedParachutes { get; private set; }
         public int activeParachutes { get; private set; }
         public int cutParachutes { get; private set; }

         private readonly Dictionary<String, double> resourceLevel = new Dictionary<String, double>();
         private readonly Dictionary<String, double> resourceCapacity = new Dictionary<String, double>();

         public VesselScan(Vessel vessel)
         {
            this.vessel = vessel;
            //
            Stopwatch sw = new Stopwatch();
            sw.Start();
            //
            Scan(vessel);
            //
            sw.Stop();
            if (Log.IsLogable(Log.LEVEL.INFO)) Log.Info("vessel scanned in "+sw.ElapsedMilliseconds+"ms");
         }

         public double GetResourceLevel(String resourceName)
         {
            try
            {
               return resourceLevel[resourceName];
            }
            catch
            {
               return 0.0;
            }
         }

         public double GetResourceCapacity(String resourceName)
         {
            try
            {
               return resourceCapacity[resourceName];
            }
            catch
            {
               return 0.0;
            }
         }

         public double GetResourcePercentage(String resourceName)
         {
            double level = GetResourceLevel(resourceName);
            double capacity = GetResourceCapacity(resourceName);
            if (capacity <= 0) return double.NaN;
            return level / capacity;
         }

         private void Scan(Vessel vessel)
         {
            if (vessel == null) return;
            foreach (Part part in vessel.Parts)
            {
               try
               {
                  foreach (PartResource r in part.Resources)
                  {
                     String resourceName = r.info.name;
                     double level = GetResourceLevel(resourceName);
                     resourceLevel[resourceName] = level + r.amount;
                     double capacity = GetResourceCapacity(resourceName);
                     resourceCapacity[resourceName] = capacity + r.maxAmount;
                  }
                  //
                  // Parachutes
                  foreach (ModuleParachute parachute in part.Modules.OfType<ModuleParachute>())
                  {
                     parachutes++;
                     switch(parachute.deploymentState)
                     {
                        case ModuleParachute.deploymentStates.ACTIVE:
                           activeParachutes++;
                           break;
                        case ModuleParachute.deploymentStates.DEPLOYED:
                           deployedParachutes++;
                           break;
                        case ModuleParachute.deploymentStates.STOWED:
                           stowedParachutes++;
                           break;
                        case ModuleParachute.deploymentStates.SEMIDEPLOYED:
                           semiDeployedParachutes++;
                           break;
                        case ModuleParachute.deploymentStates.CUT:
                           cutParachutes++;
                           break;
                           
                     }
                     if (parachute.deploymentState == ModuleParachute.deploymentStates.STOWED) stowedParachutes++;
                  }
               }
               catch(Exception e)
               {
                  Log.Warning("failed to scan part "+part.name+" in vessel "+vessel.name+": "+e.GetType());
               }
            }
         }
      }
   }
}
