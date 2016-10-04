using System;
using UnityEngine;
using System.Collections.Generic;

namespace Nereid
{
   namespace FinalFrontier
   {
      class RibbonBrowser : AbstractWindow
      {

         private Vector2 scrollPosition = Vector2.zero;

         public static int WIDTH = 480;
         public static int HEIGHT = 600;

         private String search = "";


         public RibbonBrowser()
            : base(Constants.WINDOW_ID_RIBBONBROWSER, "Ribbons")
         {


         }

         protected override void OnWindow(int id)
         {
            GUILayout.BeginVertical();
            GUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace(); // Button("Ribbons:", GUIStyles.STYLE_LABEL);
            if (GUILayout.Button("Close", FFStyles.STYLE_BUTTON)) SetVisible(false);
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Search:", HighLogic.Skin.label);
            search = GUILayout.TextField(search, FFStyles.STYLE_STRETCHEDTEXTFIELD);
            GUILayout.EndHorizontal();
            scrollPosition = GUILayout.BeginScrollView(scrollPosition, FFStyles.STYLE_SCROLLVIEW, GUILayout.Height(HEIGHT));
            GUILayout.BeginVertical();
            int ribbonsFound = 0;
            foreach (Ribbon ribbon in RibbonPool.Instance())
            {
               String name = ribbon.GetName();
               String description = ribbon.GetDescription();
               if (search == null || search.Trim().Length == 0 || name.ContainsIgnoringCase(search) || description.ContainsIgnoringCase(search))
               {
                  GUILayout.BeginHorizontal(FFStyles.STYLE_RIBBON_AREA);
                  GUILayout.Label(ribbon.GetTexture(), FFStyles.STYLE_SINGLE_RIBBON);
                  GUILayout.Label(name + ": " + description, FFStyles.STYLE_RIBBON_DESCRIPTION);
                  GUILayout.EndHorizontal();
                  ribbonsFound++;
               }
            }
            // no ribbons match search criteria
            if(ribbonsFound == 0)
            {
               GUILayout.BeginHorizontal(FFStyles.STYLE_RIBBON_AREA);
               GUILayout.Label("NONE", FFStyles.STYLE_SINGLE_RIBBON);
               GUILayout.Label("no ribbons found", FFStyles.STYLE_RIBBON_DESCRIPTION);
               GUILayout.EndHorizontal();
            }
            GUILayout.EndVertical();
            GUILayout.EndScrollView();
            GUILayout.Label(RibbonPool.Instance().Count() + " ribbons in total (" + RibbonPool.Instance().GetCustomRibbons().Count + " custom ribbons)", FFStyles.STYLE_STRETCHEDLABEL);
           
            GUILayout.EndVertical();

            DragWindow();
         }

         public override int GetInitialWidth()
         {
            return WIDTH;
         }
      }
   }
}