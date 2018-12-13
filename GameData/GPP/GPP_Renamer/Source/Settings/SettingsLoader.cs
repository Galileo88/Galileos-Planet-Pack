using UnityEngine;


namespace KerbalRenamer
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    internal class SettingsLoader : MonoBehaviour
    {
        void OnDestroy()
        {
            Debug.Log("SettingsLoader");

            // User Settings
            ConfigNode data = UserSettings.ConfigNode;

            // Debug Spam
            Debug.debug = Debug.debug.SetFromString(data.GetValue("debug"));

            // Names
            Debug.Log("SigmaLog", "value usegameseed = " + data.GetValue("useGameSeed"));
            Debug.Log("SigmaLog", "Settings.useGameSeed 1 = " + Settings.useGameSeed);
            Settings.useGameSeed = Settings.useGameSeed.SetFromString(data.GetValue("useGameSeed"));
            Debug.Log("SigmaLog", "Settings.useGameSeed 2 = " + Settings.useGameSeed);
            Settings.useGameMode = Settings.useGameMode.SetFromString(data.GetValue("useGameMode"));
            Settings.useSuffixes = Settings.useSuffixes.SetFromString(data.GetValue("useSuffixes"));
            Settings.suffixes = Settings.suffixes.SetFromString(data.GetNode("Suffixes"));

            // Names
            Settings.preserveOriginals = Settings.preserveOriginals.SetFromString(data.GetValue("preserveOriginals"));
            Settings.generateFirstNames = Settings.generateFirstNames.SetFromString(data.GetValue("generateFirstNames"));
            Settings.generateLastNames = Settings.generateLastNames.SetFromString(data.GetValue("generateLastNames"));

            // Culture
            ConfigNode[] cultureclub = data?.GetNodes("Culture");
            int n = cultureclub?.Length ?? 0;
            Settings.cultures = new Culture[n];

            for (int i = 0; i < n; i++)
            {
                Settings.cultures[i] = new Culture(cultureclub[i]);
            }

            // Stats
            Settings.generateStats = Settings.generateStats.SetFromString(data.GetValue("generateStats"));
            Settings.useBellCurveMethod = Settings.useBellCurveMethod.SetFromString(data.GetValue("useBellCurveMethod"));
            Settings.dontInsultMe = Settings.dontInsultMe.SetFromString(data.GetValue("dontInsultMe"));
            Settings.femalePercent = Settings.femalePercent.SetFromString(data.GetValue("femalePercent"));
            Settings.badassPercent = Settings.badassPercent.SetFromString(data.GetValue("badassPercent"));
        }
    }
}
