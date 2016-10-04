using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      class WindowManager
      {
         public static readonly WindowManager instance = new WindowManager();


         private readonly List<AbstractWindow> windows = new List<AbstractWindow>();

         public void AddWindow(AbstractWindow window)
         {
            windows.Add(window);
         }


         public void RemoveWindow(AbstractWindow window)
         {
            windows.Remove(window);
         }

         public void OnGUI()
         {
            foreach(AbstractWindow window in windows)
            {
               if(window.IsVisible())
               {
                  window.OnGUI();
               }
            }
         }

         public void CloseAll()
         {
            foreach (AbstractWindow window in windows)
            {
               if (window.IsVisible())
               {
                  window.SetVisible(false);
               }
            }
         }
      }
   }
}
