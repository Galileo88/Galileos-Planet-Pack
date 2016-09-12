using System;
using UnityEngine;

namespace Nereid
{
   namespace FinalFrontier
   {
      class AboutWindow : PositionableWindow
      {
         public AboutWindow()
            : base(Constants.WINDOW_ID_ABOUT, "About")
         {

         }

         protected override void OnWindow(int id)
         {
            GUILayout.BeginHorizontal();
            GUILayout.BeginVertical(FFStyles.STYLE_RIBBON_DESCRIPTION);
            GUILayout.Label("Final Frontier - written by Nereid (A.Kolster)",FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("");
            GUILayout.Label("  Some ribbons and graphics are inspired and/or created by Unistrut.", FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("  The First-In-Space and First-EVA-In-Space ribbons are created by SmarterThanMe.", FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("  The toolbar was created by blizzy78.", FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("  Some custom ribbons are created/provided by nothke, SmarterThanMe, helldiver and Wyrmshadow.", FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("");
            GUILayout.Label("  Special thanks to Unistrut for giving permissions to use his ribbon graphics.", FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("");
            GUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
            if (GUILayout.Button("Close", FFStyles.STYLE_BUTTON)) SetVisible(false);
            GUILayout.EndHorizontal();
            DragWindow();
         }

         public override int GetInitialWidth()
         {
            return 350;
         }
      }
   }
}
