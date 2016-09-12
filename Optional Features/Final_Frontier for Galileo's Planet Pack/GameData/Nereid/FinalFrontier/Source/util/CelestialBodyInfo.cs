using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace Nereid
{
   namespace FinalFrontier
   {
      /**
       * This class scans all subfolders of GameData for files with the name "CelestialBodies.info" and reads them to provide external ribbon information.
       */
      public class CelestialBodyInfo
      {

         private static readonly String INFO_FILE = "CelestialBodies.info";

         private readonly String plugin;

         private readonly Dictionary<CelestialBody, Info> infos = new Dictionary<CelestialBody,Info>();

         private class CelestialBodyInfoSyntaxException : Exception
         {
            public CelestialBodyInfoSyntaxException(String msg)
               : base(msg)
            {

            }
         }

         private class Info : Dictionary<String,String>
         {

            private String AsPrefix(String s)
            {
               if ( s == null || s.Length == 0 ) return "";
               return s + ".";
            }

            public String GetString(String plugin, String key, String defaultValue = "")
            {
               key = AsPrefix(plugin) + key;
               if(ContainsKey(key))
               {
                  return this[key];
               }
               return defaultValue;
            }

            public int GetInt(String plugin, String key, int defaultValue = 0)
            {
               key = AsPrefix(plugin) + key;
               if (ContainsKey(key))
               {
                  try
                  {
                     return Int16.Parse(this[key]);
                  }
                  catch(FormatException)
                  {
                     Log.Warning("invalid value for key "+key+": integer required");
                     return 0;
                  }
               }
               return defaultValue;
            }

            public bool GetBool(String plugin, String key, bool defaultValue = false)
            {
               key = AsPrefix(plugin) + key;
               if (ContainsKey(key))
               {
                  try
                  {
                     return bool.Parse(this[key]);
                  }
                  catch (FormatException)
                  {
                     Log.Warning("invalid value for key " + key + ": bool required");
                     return false;
                  }
               }
               return defaultValue;
            }

            private void ReadAttribute(String plugin, String line)
            {
               int p = line.IndexOf('=');
               if (p > 0)
               {
                  String key = AsPrefix(plugin) + line.Substring(0, p - 1).Compress();
                  String value = line.Substring(p + 1).Trim();
                  Log.Info("celestial body attribute "+key+" is "+value);
                  if(ContainsKey(key))
                  {
                     // TODO: Exception
                     Log.Warning("key "+key+" found twice in "+plugin);
                     Remove(key);
                  }
                  Add(key, value);
               }
               else
               {
                  throw new CelestialBodyInfoSyntaxException("syntax error while reading attribute");
               }
            }

            public void ReadSection(StreamReader file, String plugin = "")
            {
               Log.Info("reading section for plugin '"+plugin+"'");
               bool openingBraceFound = false;
               String line;
               while ((line = file.ReadLine()) != null)
               {
                  line = line.Trim();
                  if (!line.StartsWith("#"))
                  {
                     if (openingBraceFound)
                     {
                        if (line.StartsWith("}"))
                        {
                           return;
                        }
                        if (line.Contains("="))
                        {
                           ReadAttribute(plugin, line);
                        }
                        else
                        {
                           ReadSection(file, line);
                        }
                     }
                     if (line.StartsWith("{")) openingBraceFound = true;
                  }
               }
               throw new CelestialBodyInfoSyntaxException("missing closing brace");
            }
         }

         public CelestialBodyInfo()
            : this("FinalFrontier")
         {
            // default constructor
         }

         public CelestialBodyInfo(String plugin)
         {
            this.plugin = plugin;
         }

         private void ReadCelestialBodyData(StreamReader file, String name)
         {
            Log.Info("loading celestial body info for " + name);
            Info info = new Info();
            info.ReadSection(file);

            CelestialBody body = GameUtils.GetBodyForName(name);
            if(body==null)
            {
               Log.Warning("celestial body '"+name+"' not found. celestial body info ignored");
               return;
            }

            if(!this.infos.ContainsKey(body))
            { 
               this.infos.Add(body, info);
               Log.Detail("celestial body stored");
            }
            else
            {
               Log.Warning("celestial body info for '"+name+"' already present");
               info = this.infos[body];
            }
         }

         private void ReadInfoFile(String filename)
         {
            StreamReader file = null;
            try
            {
               file = File.OpenText(filename);
               String line;
               while ((line = file.ReadLine()) != null)
               {
                  line = line.Trim();
                  if(!line.StartsWith("#") && line.Length>0)
                  {
                     ReadCelestialBodyData(file, line);
                  }
               }
            }
            catch(Exception e)
            {
               Log.Error(e.Message);
            }
         }

         public void ScanGameData()
         {
            Log.Info("scanning "+Constants.GAMEDATA_PATH+" for celestial body info in "+plugin);
            ScanGameData(Constants.GAMEDATA_PATH);
            Log.Detail("scan for celestial body info completed");
         }

         public void ScanGameData(String basefolder)
         {
            if(Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("scanning folder " + basefolder +" for celestial body info");
            try
            {
               foreach (String folder in Directory.GetDirectories(basefolder))
               {
                  String filename = folder+"/"+INFO_FILE;
                  if (File.Exists(filename))
                  {
                     Log.Info("celestial body infos found in "+folder);
                     ReadInfoFile(filename);
                  }
                  ScanGameData(folder);
               }
            }
            catch (System.Exception)
            {
               Log.Error("failed to scan for celestial body info");
            }
         }

         public bool Contains(CelestialBody body)
         {
            return this.infos.ContainsKey(body);
         }

         public String GetString(CelestialBody body, String plugin, String key, String defaultValue = "")
         {
            if (this.infos.ContainsKey(body))
            {
               Info info = this.infos[body];
               return info.GetString(plugin, key, defaultValue);
            }
            return defaultValue;
         }

         public int GetInt(CelestialBody body, String plugin, String key, int defaultValue = 0)
         {
            if (this.infos.ContainsKey(body))
            {
               Info info = this.infos[body];
               return info.GetInt(plugin, key, defaultValue);
            }
            return defaultValue;
         }

         public bool GetBool(CelestialBody body, String plugin, String key, bool defaultValue = false)
         {
            if (this.infos.ContainsKey(body))
            {
               Info info = this.infos[body];
               return info.GetBool(plugin, key, defaultValue);
            }
            return defaultValue;
         }
      }
   }
}
