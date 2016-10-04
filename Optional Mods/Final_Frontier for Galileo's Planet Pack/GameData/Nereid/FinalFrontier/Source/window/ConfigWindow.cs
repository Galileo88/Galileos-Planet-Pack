using System;
using UnityEngine;
//using Toolbar;
using FinalFrontierAdapter;


namespace Nereid
{
   namespace FinalFrontier
   {
      class ConfigWindow : PositionableWindow
      {
         private readonly CodeBrowser codeBrowser = new CodeBrowser();

         private GUIStyle STYLE_TEXTFIELD_WIDOWTITLE = new GUIStyle(HighLogic.Skin.textField);

         private bool hotkeyInput = false;

         public ConfigWindow()
            : base(Constants.WINDOW_ID_CONFIG, "Final Frontier Configuration")
         {
            STYLE_TEXTFIELD_WIDOWTITLE.stretchWidth = false;
            STYLE_TEXTFIELD_WIDOWTITLE.fixedWidth = 190;
         }

         public override void SetVisible(bool visible)
         {
            if (!IsVisible() && visible) hotkeyInput = false;
            base.SetVisible(visible);
         }

         protected override void OnWindow(int id)
         {
            Configuration config = FinalFrontier.configuration;

            GUILayout.BeginVertical();
            GUILayout.BeginHorizontal();
            if (GUILayout.Button("Browse Ribbon Codes", FFStyles.STYLE_BUTTON))
            {
               if (!codeBrowser.IsVisible()) MoveWindowAside(codeBrowser);
               codeBrowser.SetVisible(!codeBrowser.IsVisible());
            }

            GUILayout.FlexibleSpace();
            if (GUILayout.Button("Close", FFStyles.STYLE_BUTTON))
            {
               SetVisible(false);
               config.Save();
            }
            GUILayout.EndHorizontal();
            GUILayout.Label("Log Level:",FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.BeginHorizontal();
            LogLevelButton(Log.LEVEL.OFF, "OFF");
            LogLevelButton(Log.LEVEL.ERROR, "ERROR");
            LogLevelButton(Log.LEVEL.WARNING, "WARNING");
            LogLevelButton(Log.LEVEL.INFO, "INFO");
            LogLevelButton(Log.LEVEL.DETAIL, "DETAIL");
            LogLevelButton(Log.LEVEL.TRACE, "TRACE");
            GUILayout.EndHorizontal();
            // Reset Window Postions
            if (GUILayout.Button("Reset Window Positions", FFStyles.STYLE_BUTTON))
            {
               PositionableWindow.ResetAllWindowPositions();
            }
            // Window Titles
            GUILayout.BeginHorizontal();
            GUILayout.Label("Hall Of Fame window title:",FFStyles.STYLE_STRETCHEDLABEL);
            String hallOfFameWindowTitle = FinalFrontier.configuration.GetHallOfFameWindowTitle();
            hallOfFameWindowTitle = GUILayout.TextField(hallOfFameWindowTitle, STYLE_TEXTFIELD_WIDOWTITLE);
            FinalFrontier.configuration.SetHallOfFameWindowTitle(hallOfFameWindowTitle);
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Decoration Board window title:", FFStyles.STYLE_STRETCHEDLABEL);
            String decorationBoardWindowTitle = FinalFrontier.configuration.GetDecorationBoardWindowTitle();
            decorationBoardWindowTitle = GUILayout.TextField(decorationBoardWindowTitle, STYLE_TEXTFIELD_WIDOWTITLE);
            FinalFrontier.configuration.SetDecorationBoardWindowTitle(decorationBoardWindowTitle);
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Mission Summary window title:", FFStyles.STYLE_STRETCHEDLABEL);
            String missionSummaryWindowTitle = FinalFrontier.configuration.GetMissionSummaryWindowTitle();
            missionSummaryWindowTitle = GUILayout.TextField(missionSummaryWindowTitle, STYLE_TEXTFIELD_WIDOWTITLE);
            FinalFrontier.configuration.SetMissionSummaryWindowTitle(missionSummaryWindowTitle);
            GUILayout.EndHorizontal();
            GUILayout.Label("(window titles needs a restart to take effect)", FFStyles.STYLE_RLABEL);
            //
            //
            GUILayout.Label("Settings:", FFStyles.STYLE_STRETCHEDLABEL);
            // CUSTOM RIBBONS AT SPACE CENTER
            config.SetCustomRibbonAtSpaceCenterEnabled( GUILayout.Toggle(config.IsCustomRibbonAtSpaceCenterEnabled(), "Custom ribbons at space center", FFStyles.STYLE_TOGGLE) );
            // REVOCATION OF RIBBONS
            config.SetRevocationOfRibbonsEnabled (GUILayout.Toggle(config.IsRevocationOfRibbonsEnabled(), "Revocation of ribbons enabled", FFStyles.STYLE_TOGGLE) );
            // AUTO EXPAND RIBBONS
            config.SetAutoExpandEnabled( GUILayout.Toggle(config.IsAutoExpandEnabled(), "Expand ribbons in hall of fame", FFStyles.STYLE_TOGGLE) );
            // PERMADEATH
            GameUtils.SetPermadeathEnabled( GUILayout.Toggle(GameUtils.IsPermadeathEnabled(), "Permadeath enabled", FFStyles.STYLE_TOGGLE) );
            // HOTKEY
            GUILayout.BeginHorizontal();
            config.SetHotkeyEnabled( GUILayout.Toggle(config.IsHotkeyEnabled(), "Hotkey enabled", FFStyles.STYLE_TOGGLE) );
            GUILayout.FlexibleSpace();
            DrawHotKeyField();
            //GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();
            // KERBIN TIME
            GameUtils.SetKerbinTimeEnabled( GUILayout.Toggle(GameUtils.IsKerbinTimeEnabled(), "Use kerbin time", FFStyles.STYLE_TOGGLE) );
            // MISSION SUMMARY POPUP WINDOW
            config.SetMissionSummaryEnabled(GUILayout.Toggle(config.IsMissionSummaryEnabled(), "Show summary when vessel is recovered", FFStyles.STYLE_TOGGLE));
            // Stock Toolbar
            if(ToolbarManager.ToolbarAvailable)
            {
               config.SetUseStockToolbar(GUILayout.Toggle(config.UseStockToolbar(), "Use Stock Toolbar (needs a restart to take effect)", FFStyles.STYLE_TOGGLE));
            }
            // FAR Calculations
            if(FinalFrontier.farAdapter.IsInstalled())
            {
               config.UseFARCalculations = GUILayout.Toggle(config.UseFARCalculations, "Use FAR calculations", FFStyles.STYLE_TOGGLE);
            }
            // Convert Games
            config.convertGames = GUILayout.Toggle(config.convertGames, "Convert save games", FFStyles.STYLE_TOGGLE);
            // Log Ribbon Aawrds
            config.logRibbonAwards = GUILayout.Toggle(config.logRibbonAwards, "Log ribbon awards", FFStyles.STYLE_TOGGLE);

            GUILayout.EndVertical();
            DragWindow();
         }

         private void DrawHotKeyField()
         {
            String text = hotkeyInput?"press key":FinalFrontier.configuration.hotkey.ToString();
            GUILayout.Label("Hotkey: LEFT-ALT + ");
            if (GUILayout.Button(" "+text+" ",FFStyles.STYLE_BUTTON_HOTYKEY))
            {
               hotkeyInput = true;
            }
            if(hotkeyInput)
            {
               if (Input.anyKeyDown)
               {
                  hotkeyInput = false;
                  KeyCode[] keys = Utils.GetPressedKeys();
                  if (keys != null && keys.Length > 0)
                  {
                     FinalFrontier.configuration.hotkey = keys[0];
                  }
               }
            }
         }

         private void LogLevelButton(Log.LEVEL level, String text)
         {
            if (GUILayout.Toggle(Log.GetLevel() == level, text, FFStyles.STYLE_BUTTON) && Log.GetLevel() != level)
            {
               FinalFrontier.configuration.SetLogLevel(level);
               Log.SetLevel(level);
            }
         }
      }
   }
}
