using System.Linq;
using UnityEngine;


namespace KerbalRenamer
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    internal class UserSettings : MonoBehaviour
    {
        internal static ConfigNode ConfigNode
        {
            get
            {
                return GameDatabase.Instance?.GetConfigs(nodeName)?.FirstOrDefault()?.config;
            }
        }

        static string nodeName = "KERBALRENAMER";
    }
}
