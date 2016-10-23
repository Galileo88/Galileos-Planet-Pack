using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using System.IO;
using System.Diagnostics;

namespace Nereid
{
   namespace FinalFrontier
   {
      static class Persistence
      {
         private static readonly String ROOT_PATH = Utils.GetRootPath();
         private static readonly String SAVE_BASE_FOLDER = ROOT_PATH + "/saves/"; // suggestion/hint from Cydonian Monk
         private const String FILE_NAME = "halloffame.ksp";

         private const String PERSISTENCE_NODE_ENTRY_NAME = "ENTRY";

         /***************************************************************************************************************
          * new persistence model
          ***************************************************************************************************************/

         public static void SaveHallOfFame(List<LogbookEntry> logbook, ConfigNode node)
         {
            Log.Info("saving hall of fame (" + logbook.Count + " logbook entries)");

            List<LogbookEntry> logbookCopy = new List<LogbookEntry>(logbook);

            Stopwatch sw = new Stopwatch();
            sw.Start();

            try
            {
               foreach (LogbookEntry entry in logbookCopy)
               {
                  ConfigNode entryNode = new ConfigNode(PERSISTENCE_NODE_ENTRY_NAME);
                  if (Log.IsLogable(Log.LEVEL.DETAIL)) Log.Detail("saving logbook entry " + entry);
                  entryNode.AddValue(Constants.CONFIGNODE_KEY_TIME, entry.UniversalTime.ToString());
                  entryNode.AddValue(Constants.CONFIGNODE_KEY_NAME, entry.Name);
                  entryNode.AddValue(Constants.CONFIGNODE_KEY_CODE, entry.Code);
                  entryNode.AddValue(Constants.CONFIGNODE_KEY_DATA, entry.Data);
                  node.AddNode(entryNode);
               }
            }
            catch
            {
               Log.Error("exception while saving hall of fame detected; hall of fame may be corrupt");
            }
            finally
            {
               sw.Stop();
               Log.Info("hall of fame saved in " + sw.ElapsedMilliseconds + "ms");
            }
         }


         public static List<LogbookEntry> LoadHallOfFame(ConfigNode node)
         {
            Log.Info("loading hall of fame");

            // create a temporary logbook
            // unnecessary in the current concept, but kept to keep changes at a minimum
            List<LogbookEntry> logbook = new List<LogbookEntry>();

            if(node==null)
            {
               Log.Warning("no config node found. hall of fame will not load");
               return logbook;
            }

            Stopwatch sw = new Stopwatch();
            sw.Start();

            try
            {
               foreach (ConfigNode childNode in node.GetNodes())
               {
                  if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("child node found: " + childNode.name);
                  String sTime = childNode.GetValue(Constants.CONFIGNODE_KEY_TIME);
                  String code = childNode.GetValue(Constants.CONFIGNODE_KEY_CODE);
                  String name = childNode.GetValue(Constants.CONFIGNODE_KEY_NAME);
                  String data = childNode.GetValue(Constants.CONFIGNODE_KEY_DATA);
                  try
                  {
                     double time = Double.Parse(sTime);
                     logbook.Add(new LogbookEntry(time, code, name, data));
                  }
                  catch
                  {
                     Log.Error("corrupt data in child node");
                  }
               }
               return logbook;
            }
            catch
            {
               Log.Error("exception while loading hall of fame detected; hall of fame may be corrupt");
               return logbook;
            }
            finally
            {
               sw.Stop();
               Log.Info("hall of fame loaded in " + sw.ElapsedMilliseconds + "ms");
            }

         }

         public static String[] GetSaveGameFolders()
         {
            return Directory.GetDirectories(SAVE_BASE_FOLDER);
         }

         /***************************************************************************************************************
          * debugging
          ***************************************************************************************************************/

         /*
          * This method is called for testign purposes only. It should never be called in a public release
          */
         public static void WriteSupersedeChain(Pool<Ribbon> ribbons)
         {
            StreamWriter file = File.CreateText(ROOT_PATH+"/GameData/Nereid/FinalFrontier/supersede.txt");
            List<Ribbon> sorted = new List<Ribbon>(ribbons);
            sorted.Sort(delegate(Ribbon left, Ribbon right)
            {
               return left.GetCode().CompareTo(right.GetCode());
            });
            try
            {
               foreach (Ribbon ribbon in sorted)
               {
                  String code = ribbon.GetCode().PadRight(20);
                  Ribbon supersede = ribbon.SupersedeRibbon();
                  file.WriteLine(code+(supersede!=null?supersede.GetCode():""));
               }
            }
            finally
            {
               file.Close();
            }
         }
      }
   }
}