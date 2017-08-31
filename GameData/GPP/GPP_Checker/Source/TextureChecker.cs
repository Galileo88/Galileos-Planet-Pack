using System.IO;
using UnityEngine;

namespace GPPTextureChecker
{
	[KSPAddon(KSPAddon.Startup.Instantly, false)]
	public class TextureChecker : MonoBehaviour
	{
        bool installed = true;
        bool installedCorrectly = true;
        ConfigNode data;
        string settingsPath = KSPUtil.ApplicationRootPath + "GameData/GPP/GPP_Textures/checker.cfg";
        string errorTitle;
        string errorMessage;

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
                errorTitle = "No GPP_Texture Folder Detected";
                errorMessage = "The GPP_Textures folder is missing. GPP will not load without it. Go to https://github.com/Galileo88/Galileos-Planet-Pack/releases and download the latest texture release.";
            }
            if (installed && !installedCorrectly)
            {
				errorTitle = "GPP_Texture Folder Not Installed Correctly";
				errorMessage = "The GPP_Textures folder should be installed to ~/GameData/GPP/GPP_Textures. GPP will not work until the texture folder is installed properly";
            }

            if (errorTitle != null)
            {
                PopupDialog.SpawnPopupDialog(new Vector2(0.5f, 0.5f), new Vector2(0.5f, 0.5f), "GPP Texture Checker", errorTitle, errorMessage, "I Understand", true, UISkinManager.defaultSkin);
                Debug.LogError(errorTitle);
                Debug.LogError(errorMessage);
            }
        }
    }
}