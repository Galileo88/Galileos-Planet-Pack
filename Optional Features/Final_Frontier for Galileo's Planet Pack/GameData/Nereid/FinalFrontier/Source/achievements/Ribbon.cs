using System;
using UnityEngine;
using KSP.IO;

namespace Nereid
{
   namespace FinalFrontier
   {
      public class Ribbon : IComparable<Ribbon>
      {
         public static readonly int WIDTH = 120;
         public static readonly int HEIGHT = 32;

         private readonly Texture2D texture;
         private readonly Achievement achievement;
         // ribbon that has to be superseded if any
         private readonly Ribbon supersede;

         // ribbon enabled?
         private bool enabled = true;

         public Ribbon(String imagePath, Achievement achievement, Ribbon supersede = null)
         {
            this.achievement = achievement;
            this.supersede = supersede;
            texture = ImageLoader.GetTexture(imagePath);
            if(texture!=null)
            {
               texture.filterMode = FilterMode.Trilinear;
            }
            else
            {
               // no texture => ribbon disabled
               Log.Warning("ribbon "+achievement.GetName()+" disabled");
               enabled = false;
            }
         }

         public bool IsEnabled()
         {
            return enabled;
         }

         public int GetWidth()
         {
            return WIDTH;
         }

         public int GetHeight()
         {
            return HEIGHT;
         }

         public Texture2D GetTexture()
         {
            return texture;
         }

         public String GetCode()
         {
            return achievement.GetCode();
         }

         public Achievement GetAchievement()
         {
            return achievement;
         }

         public Ribbon SupersedeRibbon()
         {
            return supersede;
         }

         public int CompareTo(Ribbon right)
         {
            return achievement.CompareTo(right.achievement);
         }

         public override bool Equals(System.Object right)
         {
            if (right == null) return false;
            Ribbon cmp = right as Ribbon;
            // Ribbons are the same, if and only if the achievements are the same
            return achievement.Equals(cmp.achievement);
         }

         public override int GetHashCode()
         {
            return achievement.GetHashCode();
         }

         public String GetDescription()
         {
            if (achievement.GetDescription() == null) return ""; // this should never happen, but its better to be safe than sorry
            return achievement.GetDescription();
         }

         public String GetName()
         {
            return achievement.GetName() + " Ribbon";
         }

         public override String ToString()
         {
            return achievement.GetCode();
         }
      }
   }
}