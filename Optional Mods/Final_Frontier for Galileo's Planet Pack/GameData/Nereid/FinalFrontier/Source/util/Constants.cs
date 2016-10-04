using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      static class Constants
      {
         public const int WINDOW_ID_HALLOFFAMEBROWSER = 18142;
         public const int WINDOW_ID_RIBBONBROWSER = 18143;
         public const int WINDOW_ID_DISPLAY = 18144;
         public const int WINDOW_ID_CONFIG = 18145;
         public const int WINDOW_ID_ABOUT = 18146;
         public const int WINDOW_ID_CODEBROWSER = 18147;
         public const int WINDOW_ID_MISSION_SUMMARY = 18148;
         public const int WINDOW_ID_MESSAGE = 18149;
         public const int WINDOW_ID_CONVERT_DIALOG = 18150;

         public const int MISSIONCOUNT_FOR_BADASS = 2;

         public const int MAX_RIBBONS_PER_AREA = 12;
         public const int MAX_RIBBONS_PER_EXPANDED_AREA = 60;

         public const double MIN_DISTANCE_FOR_MOVING_VEHICLE_ON_SURFACE = 0.3;
         public const double MIN_HEIGT_FOR_MOVING_VEHICLE_ON_SURFACE = 0.1;

         public const int SECONDS_PER_MINUTE = 60;
         public const int SECONDS_PER_HOUR = 60 * SECONDS_PER_MINUTE;
         public const int HOURS_PER_EARTH_DAY = 24;
         public const int HOURS_PER_KERBIN_DAY = 6;
         public const int SECONDS_PER_EARTH_DAY = HOURS_PER_EARTH_DAY * SECONDS_PER_HOUR;
         public const int SECONDS_PER_KERBIN_DAY = HOURS_PER_KERBIN_DAY * SECONDS_PER_HOUR;

         public const String CONFIGNODE_KEY_VERSION = "version";
         public const String CONFIGNODE_KEY_TIME = "time";
         public const String CONFIGNODE_KEY_NAME = "name";
         public const String CONFIGNODE_KEY_CODE = "code";
         public const String CONFIGNODE_KEY_DATA = "data";

         public const String OLD_NODE_ROOT_NAME = "FinalFrontierHallOfFameRoot";

         public static readonly String ROOT_PATH = Utils.GetRootPath();
         public static readonly String GAMEDATA_PATH = ROOT_PATH + "/GameData";

         public const String RESOURCE_NAME_LIQUID_FUEL = "LiquidFuel";

      }
   }
}
