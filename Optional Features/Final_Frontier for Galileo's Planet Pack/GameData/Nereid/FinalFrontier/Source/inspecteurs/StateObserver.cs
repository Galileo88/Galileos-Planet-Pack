using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      /**
       * class for inspecting simple states, such as change in vessel altitute, mach number or change in Gee-Force
       */
      public abstract class StateObserver<T>
      {
         private volatile bool changed = false;

         public abstract void Inspect(T x);

         public void Clear()
         {
            this.changed = false;
         }

         public void Reset()
         {
            ResetState();
            Clear();
         }

         protected abstract void ResetState();

         public void Change()
         {
            this.changed = true;
         }

         public bool StateHasChanged()
         {
            return this.changed;
         }
      }

      public class MachNumberObserver : StateObserver<Vessel>
      {
         private int lastMachNumber = 0;

         public override void Inspect(Vessel vessel)
         {
            if (vessel == null) return;
            if(vessel.situation != Vessel.Situations.FLYING) return;

            double mach = vessel.MachNumber();
            int machWholeNumber = (int)Math.Truncate(mach);
            if (machWholeNumber > lastMachNumber)
            {
               Log.Detail("mach number increasing to " + machWholeNumber);
               this.lastMachNumber = machWholeNumber;
               Change();
            }
            else if (machWholeNumber < lastMachNumber)
            {
               Log.Detail("mach number decreasing to " + machWholeNumber);
               this.lastMachNumber = machWholeNumber;
               Change();
            }
         }

         protected override void ResetState()
         {
            Log.Detail("mach number reset");
            this.lastMachNumber = 0;
         }
      }

      public class AltitudeObserver : StateObserver<Vessel>
      {
         private long lastAltitudeAsMultipleOf1k = 0;

         public override void Inspect(Vessel vessel)
         {
            if (vessel == null) return;
            if (vessel.situation != Vessel.Situations.FLYING) return;

            double altitide = vessel.altitude;
            int alt1000k = 1000*(int)Math.Truncate(altitide/1000);
            if (alt1000k > lastAltitudeAsMultipleOf1k)
            {
               if(Log.IsLogable(Log.LEVEL.DETAIL))  Log.Detail("altitude increasing to " + alt1000k);
               this.lastAltitudeAsMultipleOf1k = alt1000k;
               Change();
            }
            else if (alt1000k < lastAltitudeAsMultipleOf1k)
            {
               if(Log.IsLogable(Log.LEVEL.DETAIL))  Log.Detail("altitude decreasing to " + alt1000k);
               this.lastAltitudeAsMultipleOf1k = alt1000k;
               Change();
            }
         }

         protected override void ResetState()
         {

         }
      }

      public class OrbitObserver : StateObserver<Vessel>
      {
         const double MIN_CHANGE_ABS = 1000.0;
         const double MIN_CHANGE_REL = 0.01;
         private double lastPeA = 0;
         private double lastApA = 0;

         public override void Inspect(Vessel vessel)
         {
            if (vessel == null) return;
            if (vessel.situation != Vessel.Situations.ORBITING) return;
            Orbit orbit = vessel.orbit;
            if (orbit == null) return;

            double apa = orbit.ApA;
            double pea = orbit.PeA;
            double dapa = Math.Abs(lastApA - apa);
            double dpea = Math.Abs(lastPeA - pea);
            if (dpea >= MIN_CHANGE_ABS && dpea >= pea * MIN_CHANGE_REL)
            {
               lastPeA = pea;
               Change();
            }
            if (dapa >= MIN_CHANGE_ABS && dapa >= apa * MIN_CHANGE_REL)
            {
               lastApA =  apa;
               Change();
            }
         }

         protected override void ResetState()
         {

         }
      }


      public class GeeForceObserver : StateObserver<Vessel>
      {
         public const double DURATION = 3.0;
         private const int MAX_GEE = 15;
         private double maxGeeForce = 1.0;
         private int gSustained = 1;
         private double[] gTimeOf = new double[MAX_GEE];

         public GeeForceObserver()
         {
            ResetState();
         }


         public override void Inspect(Vessel vessel)
         {
            double gForce = vessel.geeForce;
            if (gForce > maxGeeForce)
            {
               if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("max gee force increased to " + gForce);
               this.maxGeeForce = gForce;
               int g = (int)gForce;
               double now = Planetarium.GetUniversalTime();
               if (g < MAX_GEE)
               {
                  if(gTimeOf[g] <= 0)
                  {
                     if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("gee force " + g + " reached at " + now);
                     for (int i = 0; i < g; i++ )
                     {
                        if (gTimeOf[i] <= 0) gTimeOf[i] = now;
                     }
                     gTimeOf[g] = now;
                  }
               }


               for(int i=2; i<g && i<MAX_GEE; i++)
               {
                  if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("check g " + i + " since " + gTimeOf[i] + " at " + now);
                  if (gTimeOf[i] <= 0) break;
                  if (gTimeOf[i] + DURATION > now)
                  {
                     if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("g " + i + " not reached");
                     return;
                  }
                  else
                  {
                     if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("g " + i + " sustained for " + (now - gTimeOf[i]) + " seconds");
                     gSustained = i;
                     Change();
                  }
               }
            }
         }

         public int GetGeeNumber()
         {
            return gSustained;
         }


         protected override void ResetState()
         {
            Log.Detail("reset of gee inspector state");
            this.maxGeeForce = 1.0;
            this.gSustained = 1;
            for(int i=0; i<MAX_GEE; i++)
            {
               gTimeOf[i] = 0.0;
            }
         }
      }

      public class AtmosphereObserver : StateObserver<Vessel>
      {
         private bool inAtmosphere = true;

         public override void Inspect(Vessel vessel)
         {
            bool inAtmosphere = vessel.IsInAtmosphere();
            if (this.inAtmosphere != inAtmosphere)
            {
               this.inAtmosphere = inAtmosphere;
               Change();
            }
         }

         protected override void ResetState()
         {
            Vessel vessel = FlightGlobals.ActiveVessel;
            if(vessel!=null)
            {
               inAtmosphere = vessel.IsInAtmosphere();
            }
            else
            {
               inAtmosphere = false;
            }
         }
      }

   } // end of FinalFrontier namespace */
}
