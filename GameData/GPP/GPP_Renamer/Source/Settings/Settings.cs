namespace KerbalRenamer
{
    internal static class Settings
    {
        // General
        internal static bool useGameSeed = true;
        internal static bool useGameMode = true;

        // Names
        internal static bool preserveOriginals = false;
        internal static bool generateFirstNames = true;
        internal static bool generateLastNames = true;
        internal static bool useSuffixes = true;
        internal static string[] suffixes = new[] { " Jr", " III", " IV", " V" };
        
        // Culture
        internal static string cultureDescriptor = "";
        internal static Culture[] cultures = new Culture[] { };

        // Stats
        internal static bool generateStats = true;
        internal static bool useBellCurveMethod = true;
        internal static bool dontInsultMe = true;
        internal static float femalePercent = 0.5f;
        internal static float badassPercent = 0.05f;
    }
}
