using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      public class CelestialBodyMapper
      {
         private const String PLUGIN = "FinalFrontier";

         private CelestialBodyInfo info = new CelestialBodyInfo();

         public CelestialBodyMapper()
         {
            info.ScanGameData();
         }

         public bool IsLegacyBody(CelestialBody body)
         {
            if (info.Contains(body)) return false;
            return true;
         }

         public bool IsGasGiant(CelestialBody body)
         {
            if(IsLegacyBody(body))
            {
               if (body.name.Equals("Jool")) return true;
               return false;
            }
            return info.GetBool(body, "", "gas giant", false);
         }

         public String GetRibbonPath(CelestialBody body, String defaultpath)
         {
            String path = info.GetString(body, PLUGIN, "ribbon path", defaultpath);
            if (!path.EndsWith("/") && !path.EndsWith("\\")) path = path + "/";
            return path;
         }

         public int GetBasePrestige(CelestialBody body)
         {
            const int NO_BASE_PRESTIGE = -1;
            int basePrestige = info.GetInt(body, PLUGIN, "base prestige", NO_BASE_PRESTIGE);
            if (basePrestige == NO_BASE_PRESTIGE)
            {
               return  body.BasePrestige();
            }
            return basePrestige;
         }

      }
   }
}
