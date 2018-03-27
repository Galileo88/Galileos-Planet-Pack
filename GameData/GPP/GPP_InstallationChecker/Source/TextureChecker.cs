using System.IO;
using UnityEngine;


namespace GPPTextureChecker
{
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class TextureChecker : MonoBehaviour
    {
        bool installed = true;
        bool installedCorrectly = true;
        ConfigNode data;
        string settingsPath = KSPUtil.ApplicationRootPath + "GameData/GPP/GPP_Textures/checker.cfg";

        public void Awake()
        {
            foreach (ConfigNode node in GameDatabase.Instance.GetConfigNodes("GPPTEXTURES"))
            {
                data = node;
            }

            if (data == null)
            {
                installed = false;
            }

            if (!File.Exists(settingsPath))
            {
                installedCorrectly = false;
            }

            if (!installed)
            {
                PopupDialog popup =
                PopupDialog.SpawnPopupDialog
                (
                    new Vector2(0.5f, 0.5f),
                    new Vector2(0.5f, 0.5f),
                    "GPP Texture Checker",
                    "No GPP_Textures Folder Detected",
                    "\n<color=#FF9231><b>The GPP_Textures folder is missing.\n" +
                    "GPP will not load without it.</b>\n\n" +
                    "Go to GitHub and download the latest texture release.</color>",
                    "Open in browser",
                    false,
                    UISkinManager.GetSkin("MainMenuSkin")
                );

                popup.gameObject.AddComponent<Downloader>();

                Debug.LogError("No GPP_Textures Folder Detected");
            }

            if (installed && !installedCorrectly)
            {
                PopupDialog.SpawnPopupDialog
                (
                    new Vector2(0.5f, 0.5f),
                    new Vector2(0.5f, 0.5f),
                    "GPP Texture Checker",
                    "GPP_Textures Folder Installed Incorrectly",
                    "\n<color=#FF9231><b>The GPP_Textures folder should be installed to " +
                    "<color=#FFFFFF>~/GameData/GPP/GPP_Textures.</color>\n\n" +
                    "GPP will not work until the texture folder is installed properly.</color>",
                    "I Understand",
                    false,
                    UISkinManager.GetSkin("MainMenuSkin")
                );

                Debug.LogError("GPP_Textures Folder Installed Incorrectly");
            }
        }
    }

    public class Downloader : MonoBehaviour
    {
        void OnDestroy()
        {
            OPENURL.open = true;
        }
    }

    [KSPAddon(KSPAddon.Startup.MainMenu, true)]
    class OPENURL : MonoBehaviour
    {
        internal static bool open = false;

        void Update()
        {
            if (open)
            {
                open = false;
                if (HighLogic.LoadedScene == GameScenes.MAINMENU)
                    Application.OpenURL("https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/4.1.1");
            }
        }
    }
}
