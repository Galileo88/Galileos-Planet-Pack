using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{

   namespace FinalFrontier
   {
      public abstract class PositionableWindow : AbstractWindow
      {
         private static readonly LinkedList<PositionableWindow> INSTANCES = new LinkedList<PositionableWindow>();

         // flag if this window was opened before; the initial postion will only be set on the first opening
         private bool opened = false;

         public PositionableWindow(int id, string title, int initialX = 0, int initialY = 0)
            : base(id, title)
         {
            INSTANCES.AddLast(this);
         }

         public static void ResetAllWindowPositions()
         {
            if (FinalFrontier.configuration != null)
            {
               FinalFrontier.configuration.ResetWindowPositions();
            }
            foreach (PositionableWindow window in INSTANCES)
            {
               window.Reset();
            }
         }

         protected void Reset()
         {
            opened = IsVisible();
            if (FinalFrontier.configuration != null)
            {
               SetPosition(FinalFrontier.configuration.GetWindowPosition(this));
            }
         }

         protected override void OnDrawFinished( int id )
         {
            if (FinalFrontier.configuration != null)
            {
               FinalFrontier.configuration.SetWindowPosition(this);
            }
            else
            {
               Log.Warning("PositionableWindow:: no configuration created, cant store window position");
            }
         }

         public void SetPosition(Pair<int,int> position )
         {
            SetPosition(position.first, position.second);
         }

         protected override void OnOpen()
         {
            Log.Trace("positionable window " + GetWindowId() + " opened");
            if (!opened)
            {
               if (FinalFrontier.configuration != null)
               {
                  Log.Detail("first opening of window " + GetWindowId());
                  Pair<int, int> position = FinalFrontier.configuration.GetWindowPosition(GetWindowId());
                  if (position != null)
                  {
                     SetPosition(position.first, position.second);
                  }
                  else
                  {
                     Log.Warning("no initial position found for window " + GetWindowId()+" while opening");
                  }
                  opened = true;
               }
               else
               {
                  Log.Warning("PositionableWindow:: no configuration created");
               }
            }
         }
      }
   }
}
