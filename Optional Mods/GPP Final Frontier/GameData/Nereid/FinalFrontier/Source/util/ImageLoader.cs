using System;
using UnityEngine;
using KSP.IO;

namespace Nereid
{
   namespace FinalFrontier
   {

      static class ImageLoader
      {

         public static Texture2D GetTexture(String pathInGameData)
         {
            Log.Detail("get texture " + pathInGameData);
            Texture2D texture = GameDatabase.Instance.GetTexture(pathInGameData, false);
            if (texture != null)
            {
               return texture;
            }
            else
            {
               Log.Error("texture " + pathInGameData + " not found");
               return null;
            }
         }

      }
   }
}