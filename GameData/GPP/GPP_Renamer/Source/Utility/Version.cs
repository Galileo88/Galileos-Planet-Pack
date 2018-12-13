using UnityEngine;


namespace KerbalRenamer
{
    [KSPAddon(KSPAddon.Startup.Instantly, true)]
    public class Version : MonoBehaviour
    {
        public static readonly System.Version number = new System.Version("0.1.0");

        void Awake()
        {
            UnityEngine.Debug.Log("[KerbalRenamer] Version " + number);
        }
    }
}
