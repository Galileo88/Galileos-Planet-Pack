using UnityEngine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;

namespace Nereid
{
   namespace FinalFrontier
   {
      public class SaveGameConverter : MonoBehaviour
      {
         private enum STATUS { IDLE, CONVERTED, CONVERTING, SKIPPED, DONE };
         private STATUS status = STATUS.IDLE;

         // bounds for convert dialog
         private Rect bounds = new Rect(0, 0, 0, 0);
         private Vector2 gameListscrollPosition = Vector2.zero;

         private readonly HashSet<String> gamesWithLegacyData = new HashSet<String>();
         private readonly HashSet<String> gamesToConvert = new HashSet<String>();

         public SaveGameConverter()
         {
            Log.Info("save game converted created");
            RibbonPool pool = RibbonPool.Instance();

            ScanSaveGames();
         }


         public bool ScanSaveGames()
         {
            if (!FinalFrontier.configuration.convertGames) return false;
            Log.Info("scanning save games for legacy data");
            foreach(String folder in Persistence.GetSaveGameFolders())
            {
               bool containsLegacyData = SaveGameFolderContainsLegacyData(folder);
               if (containsLegacyData)
               {
                  Log.Detail("save game folder '" + folder + "' contains legacy data");
                  gamesWithLegacyData.Add(folder);
               }
               else
               {
                  Log.Detail("save game folder '" + folder + "' contains no legacy data");
               }
            }
            Log.Info(gamesWithLegacyData.Count+" games with legacy data found");
            // no more scans needed?
            if (gamesWithLegacyData.Count==0)
            {
               Log.Info("scan of save games for legacy data disabled");
               FinalFrontier.configuration.convertGames = false;
               FinalFrontier.configuration.Save();
            }
            return true;
         }


         public static ConfigNode GetLegacyData(ConfigNode node)
         {
            return node.GetNode(Constants.OLD_NODE_ROOT_NAME);
         }


         public static bool SaveGameFolderContainsLegacyData(String path)
         {
            Log.Detail("scanning save folder '" + path + "'");
            foreach (String file in Directory.GetFiles(path))
            {
               if(file.EndsWith(".sfs"))
               {
                  Log.Detail("scanning save file '"+file+"'");
                  if (SaveGameContainsLegacyData(file))
                  {
                     Log.Detail("save file '" + file + "' contains legacy data");
                     return true;
                  }
                  Log.Detail("save file '" + file + "' contains no legacy data");
               }
            }
            Log.Detail("no legacy data in save folder '" + path + "' found");
            return false;
         }

         public static void ConvertSaveGameFolder(String path)
         {
            foreach (String file in Directory.GetFiles(path))
            {
               if (file.EndsWith(".sfs"))
               {
                  ConvertSaveGame(file);
               }
            }
         }

         public static bool SaveGameContainsLegacyData(String path)
         {
            ConfigNode root = ConfigNode.Load(path);
            ConfigNode game = root.GetNode("GAME");
            if (game == null) return false;
            ConfigNode legacyData = GetLegacyData(game);
            return legacyData != null;
         }

         private static ConfigNode CreateHallOfFameScenarioNode()
         {
            ConfigNode node = new ConfigNode("SCENARIO");
            node.AddValue("name", "HallOfFameScenarioModule");
            node.AddValue("scene", "7, 8, 5");
            return node;
         }


         public static void ConvertSaveGame(String path)
         {
            Log.Info("converting save game '" + path + "'");
            Log.Detail("checking save game for legacy data...");
            ConfigNode root = ConfigNode.Load(path);
            ConfigNode game = root.GetNode("GAME");
            ConfigNode legacyData = GetLegacyData(game);
            if (legacyData != null)
            {
               Log.Info("save game " + path + " contains legacy data; converting...");
               List<LogbookEntry> logbook = Persistence.LoadHallOfFame(legacyData);
               ConfigNode scenario = CreateHallOfFameScenarioNode();
               game.AddNode(scenario);
               game.RemoveNode(legacyData);
               Persistence.SaveHallOfFame(logbook, scenario);
               root.Save(path);
               Log.Info("save game " + path + " successfully converted");
            }
            else
            {
               Log.Info("no legacy data in save game " + path);
            }
         }

         private void Convert()
         {
            status = STATUS.CONVERTING;
            // just create a game, to fire a OnGameStateCreated event, so the RibbonPool instance gets populated
            new Game();
            if(!RibbonPool.Instance().IsReady())
            {
               Log.Warning("ribbon pool not ready for converting games!");
            }
            //
            foreach(String folder in gamesToConvert)
            {
               ConvertSaveGameFolder(folder);
            }
            status = STATUS.DONE;
            // test if all saves are converted
            if(gamesToConvert.Count == gamesWithLegacyData.Count)
            {
               Log.Info("all games converted, disabling game converter");
               FinalFrontier.configuration.convertGames = false;
            }
         }

         public bool IsConverting()
         {
            return status == STATUS.CONVERTING;
         }

         protected void OnGUI()
         {
            if(HighLogic.LoadedScene==GameScenes.MAINMENU)
            {
               if(status== STATUS.IDLE)
               {
                  if (gamesWithLegacyData.Count>0 && FinalFrontier.configuration.convertGames)
                  {
                     // center
                     this.bounds.x = (Screen.width - (int)bounds.width) / 2;
                     this.bounds.y = (Screen.height - (int)bounds.height) / 2;
                     this.bounds = GUILayout.Window(this.GetInstanceID(), this.bounds, this.ConverterDialog, "Final Frontier - Save Game Converter", HighLogic.Skin.window);
                  }
               }
            }
         }

         private void ConverterDialog(int id)
         {
            GUIStyle STLYE_LABEL = new GUIStyle(HighLogic.Skin.label);
            STLYE_LABEL.fontStyle = FontStyle.Bold;
            STLYE_LABEL.stretchWidth = true;
            STLYE_LABEL.alignment = TextAnchor.MiddleLeft;
            STLYE_LABEL.wordWrap = false;
            GUIStyle STLYE_BUTTON = new GUIStyle(HighLogic.Skin.button);
            GUILayout.BeginVertical();
            STLYE_LABEL.normal.textColor = Color.magenta;
            GUILayout.Label("Old Final Frontier save games found!", STLYE_LABEL);
            STLYE_LABEL.normal.textColor = Color.white;
            GUILayout.Label("The following save games have to be converted before you can load them:", STLYE_LABEL);
            gameListscrollPosition = GUILayout.BeginScrollView(gameListscrollPosition, GUI.skin.box, GUILayout.Height(150));
            bool allSelected = true;
            foreach (String folder in gamesWithLegacyData)
            {
               GUILayout.BeginHorizontal();
               String name = Path.GetFileName(folder);
               bool convertGame = gamesToConvert.Contains(folder);
               allSelected = allSelected && convertGame;
               if (GUILayout.Toggle(convertGame, ""))
               {
                  if (!convertGame)
                  {
                     gamesToConvert.Add(folder);
                  }
               }
               else
               {
                  if (convertGame)
                  {
                     gamesToConvert.Remove(folder);
                  }
               }
               GUILayout.Label(name);
               GUILayout.FlexibleSpace();
               GUILayout.EndHorizontal();
            }
            GUILayout.EndScrollView();
            GUILayout.BeginHorizontal();
            if (!allSelected)
            {
               if (GUILayout.Button("Select All", STLYE_BUTTON))
               {
                  foreach(String folder in gamesWithLegacyData)
                  {
                     if (!gamesToConvert.Contains(folder)) gamesToConvert.Add(folder);
                  }
               }
            }
            else
            {
               if (GUILayout.Button("Deselect All",STLYE_BUTTON))
               {
                  gamesToConvert.Clear();
               }
            }
            GUILayout.FlexibleSpace();
            FinalFrontier.configuration.convertGames = GUILayout.Toggle(FinalFrontier.configuration.convertGames, "show this message again");
            GUILayout.EndHorizontal();
            //GUILayout.BeginHorizontal();
            STLYE_LABEL.normal.textColor = Color.red;
            STLYE_LABEL.stretchWidth = true;
            GUILayout.Label("Important:", STLYE_LABEL);
            STLYE_LABEL.normal.textColor = Color.white;
            STLYE_LABEL.stretchWidth = true;
            GUILayout.Label("Make backups of all of your saves games!", STLYE_LABEL);
            //GUILayout.EndHorizontal();
            STLYE_LABEL.normal.textColor = Color.yellow;
            GUILayout.Label("If you do not convert a game you will lose all achieved ribbons!", STLYE_LABEL);
            GUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            STLYE_BUTTON.normal.textColor = Color.green;
            GUI.enabled = gamesToConvert.Count > 0;
            if (GUILayout.Button("CONVERT", STLYE_BUTTON))
            {
               Convert();
            }
            GUI.enabled = true;
            STLYE_BUTTON.normal.textColor = Color.red;
            if (GUILayout.Button("SKIP", STLYE_BUTTON))
            {
               status = STATUS.SKIPPED;
            }
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
         }
      }
   }
}
