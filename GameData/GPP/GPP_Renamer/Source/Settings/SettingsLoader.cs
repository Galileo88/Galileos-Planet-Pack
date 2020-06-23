using UnityEngine;
using System.Collections.Generic;


namespace KerbalRenamer
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    internal class SettingsLoader : MonoBehaviour
    {
        void OnDestroy()
        {
            // User Settings
            ConfigNode data = UserSettings.ConfigNode;

            // Debug Spam
            Debug.debug = Debug.debug.SetFromString(data.GetValue("debug"));

            Debug.Log("SettingsLoader", "Start");

            // Settings
            Settings.useGameSeed = Settings.useGameSeed.SetFromString(data.GetValue("useGameSeed"));
            Settings.useGameMode = Settings.useGameMode.SetFromString(data.GetValue("useGameMode"));
            Settings.useSuffixes = Settings.useSuffixes.SetFromString(data.GetValue("useSuffixes"));
            Settings.suffixes = new[] { " Jr", " III", " IV", " V" };
            Settings.suffixes = Settings.suffixes.SetFromString(data.GetNode("Suffixes"));

            Debug.Log("SettingsLoader", "Names");

            // Names
            Settings.preserveOriginals = Settings.preserveOriginals.SetFromString(data.GetValue("preserveOriginals"));
            Settings.generateFirstNames = Settings.generateFirstNames.SetFromString(data.GetValue("generateFirstNames"));
            Settings.generateLastNames = Settings.generateLastNames.SetFromString(data.GetValue("generateLastNames"));

            Debug.Log("SettingsLoader", "Culture");

            // Culture
            ConfigNode[] cultureclub = data?.GetNodes("Culture");
            int n = cultureclub?.Length ?? 0;
            Settings.cultures = new Culture[n];

            for (int i = 0; i < n; i++)
            {
                Settings.cultures[i] = new Culture(cultureclub[i]);
            }

            Debug.Log("SettingsLoader", "Stats");

            // Stats
            Settings.generateStats = Settings.generateStats.SetFromString(data.GetValue("generateStats"));
            Settings.useBellCurveMethod = Settings.useBellCurveMethod.SetFromString(data.GetValue("useBellCurveMethod"));
            Settings.dontInsultMe = Settings.dontInsultMe.SetFromString(data.GetValue("dontInsultMe"));
            Settings.femalePercent = Settings.femalePercent.SetFromString(data.GetValue("femalePercent"));
            Settings.badassPercent = Settings.badassPercent.SetFromString(data.GetValue("badassPercent"));

            Debug.Log("SettingsLoader", "CustomVeterans");

            // CustomVeterans
            Settings.CustomVeterans = new List<ProtoCustomVeteran>();
            ConfigNode[] customVetNodes = data.GetNodes("CustomVeteran");
            for (int i = 0; i < customVetNodes.Length; i++)
            {
                Settings.CustomVeterans.Add(new ProtoCustomVeteran(customVetNodes[i]));
            }

            Debug.Log("SettingsLoader", "End");
        }
    }
}
