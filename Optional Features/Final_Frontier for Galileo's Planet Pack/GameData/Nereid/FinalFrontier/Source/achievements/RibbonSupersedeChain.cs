using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace Nereid
{

   namespace FinalFrontier
   {

      // this class is not used yet
      public class RibbonSupersedeChain
      {
         private static readonly String ROOT_PATH = Utils.GetRootPath();
         private static readonly String PATH = ROOT_PATH + "/GameData/Nereid/FinalFrontier";
         private static readonly String FILE_NAME = "supersede.cfg";

         Dictionary<Ribbon, Ribbon> chain = new Dictionary<Ribbon,Ribbon>();

         public void Load()
         {
            Load(PATH+"/"+FILE_NAME);
         }

         public void Load(String filename)
         {
            StreamReader file = null;
            try
            {
               file = File.OpenText(filename);
               String line;
               while ((line = file.ReadLine()) != null)
               {
                  String[] tokens = line.Split(' ');
                  if(tokens.Count()>1)
                  {
                     String code = tokens[0];
                     String supersede = tokens[1];
                     Ribbon ribbon = RibbonPool.Instance().GetRibbonForCode(code);
                     if (ribbon == null) continue;
                     Ribbon super = RibbonPool.Instance().GetRibbonForCode(supersede);
                     if (super == null) continue;
                     chain.Add(ribbon, super);
                  }
               }
            }
            finally
            {
               if(file!=null) file.Close();
            }
         }
      }
   }
}
