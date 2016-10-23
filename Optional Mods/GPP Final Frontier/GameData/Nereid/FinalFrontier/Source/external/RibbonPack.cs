using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      class RibbonPack : IEnumerable<Ribbon>
      {
         public String name { get; private set; }
         private int baseId = 0;
         private String baseFolder;
         private String ribbonFolder;

         private List<Ribbon> ribbons = new List<Ribbon>();

         public RibbonPack(String config)
         {
            name = "unnamed";
            baseFolder = Path.GetDirectoryName(config).Substring(Constants.GAMEDATA_PATH.Length+1).Replace("\\","/");
            ribbonFolder = baseFolder;
            Load(config);
         }

         private void ReadLine(String line)
         {
            // ignore comments
            if (!line.StartsWith("#") && line.Length>0)
            {
               String[] fields = line.Split(':');
               if(fields.Length>0)
               {
                  String what = fields[0];
                  if (what.Equals("NAME") && fields.Length==2)
                  {
                     this.name = fields[1];
                  }
                  else if (what.Equals("FOLDER") && fields.Length==2)
                  {
                     this.ribbonFolder = baseFolder+ "/" + fields[1];
                     Log.Detail("changing ribbon folder of ribbon pack '"+name+"' to '"+this.ribbonFolder+"'");
                  }
                  else if (what.Equals("BASE") && fields.Length==2 )
                  {
                     try
                     {
                        this.baseId = int.Parse(fields[1]);
                        Log.Detail("changing base id of ribbon pack '" + name + "' to " + this.baseId);
                     }
                     catch
                     {
                        Log.Error("failed to parse custom ribbon base id");
                     }
                  }
                  else if ( fields.Length==4 || fields.Length==5 )
                  {
                     int id;
                     try
                     {
                        id = baseId + int.Parse(fields[0]);
                     }
                     catch
                     {
                        Log.Error("failed to parse custom ribbon id");
                        return;
                     }
                     String fileOfRibbon = ribbonFolder + "/" + fields[1];
                     String nameOfRibbon = fields[2];
                     String descOfRibbon = fields[3];
                     int prestigeOfRibbon = id;
                     if( fields.Length==5 )
                     {
                        try
                        {
                           prestigeOfRibbon = int.Parse(fields[4]);
                        }
                        catch
                        {
                           Log.Error("failed to parse custom ribbon id");
                        }
                     }
                     try
                     {
                        Log.Detail("adding custom ribbon '" + nameOfRibbon + "' (id " + id + ") to ribbon pack '" + name + "'");
                        Log.Trace("path of custom ribbon file is '" + fileOfRibbon+"'");
                        CustomAchievement achievement = new CustomAchievement(id, prestigeOfRibbon);
                        achievement.SetName(nameOfRibbon);
                        achievement.SetDescription(descOfRibbon);
                        Ribbon ribbon = new Ribbon(fileOfRibbon, achievement);
                        ribbons.Add(ribbon);
                     }
                     catch
                     {
                        Log.Warning("failed to add custom ribbon '"+nameOfRibbon+"' to ribbon pack '"+name+"'");
                     }
                  }
                  else
                  {
                     Log.Warning("invalid ribbon pack file for "+name+" custom ribbon pack. failed to parse line '"+line+"'");
                  }
               }
            }
         }

         private void Load(String config)
         {
            using(TextReader reader = File.OpenText(config))
            {
               String line;
               while ((line = reader.ReadLine()) != null)
               {
                  line = line.Trim();
                  ReadLine(line);
               }
            }
         }

         public System.Collections.IEnumerator GetEnumerator()
         {
            return ribbons.GetEnumerator();
         }

         IEnumerator<Ribbon> IEnumerable<Ribbon>.GetEnumerator()
         {
            return ribbons.GetEnumerator();
         }
      }
   }
}
