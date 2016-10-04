using System;
using UnityEngine;
using KSP.IO;

namespace Nereid
{
   namespace FinalFrontier
   {
      public abstract class AbstractWindow 
      {
         public delegate void OnWindowClose();

         public static readonly int AUTO_HEIGHT = -1;
         private static readonly int DEFAULT_WIDTH = 400;
         //
         private readonly int id;
         private string title;
         private bool visible = false;
         protected Rect bounds = new Rect();
         protected Vector2 mousePosition;
         private Vector2 tmp = new Vector2(0,0);

         private String tooltip;

         // called on WindowClose
         OnWindowClose onWindowClose;

         public AbstractWindow(int id, string title) 
         {
            Log.Detail("creating window "+id+" with title '"+title+"'");
            WindowManager.instance.AddWindow(this);
            this.id = id;
            this.title = title;
            GameEvents.onGameStateCreated.Add(this.OnGameStateCreated);
         }


         private void OnGameStateCreated(Game game)
         {
            SetVisible(false);
         }

         public int GetWindowId()
         {
            return id;
         }

         protected virtual void OnOpen()
         {
         }

         protected virtual void OnClose()
         {
         }

         protected void DragWindow()
         {
            GUI.DragWindow();
         }

         public void OnGUI()
         {
            if (visible)
            {
               if (GetInitialHeight() == AUTO_HEIGHT)
               {
                  bounds = GUILayout.Window(id, bounds, OnWindowInternal, title, FFStyles.STYLE_WINDOW, GUILayout.Width(GetInitialWidth()));
               }
               else
               {
                  bounds = GUILayout.Window(id, bounds, OnWindowInternal, title, FFStyles.STYLE_WINDOW, GUILayout.Width(GetInitialWidth()), GUILayout.Height(GetInitialHeight()));
               }
            }
         }

         protected void UseLeftMouseButtonEvent()
         {
            Event e = Event.current;
            if(e !=null && e.type != EventType.used) 
            {
               if ((e.type == EventType.MouseDown || e.type == EventType.MouseUp) && e.button == 0)
               {
                  e.Use();
               }
               if (e.type == EventType.ContextClick && e.button == 0)
               {
                  e.Use();
               }
               if (e.type == EventType.ScrollWheel)
               {
                  e.Use();
               }
            }
         }

         private void OnWindowInternal(int id)
         {
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("OnWindowInternal for ID "+id+" called; x="+bounds.x+", y="+bounds.y);
            mousePosition.x = Input.mousePosition.x - bounds.x;
            mousePosition.y = (Screen.height - Input.mousePosition.y) - bounds.y - FFStyles.STYLE_WINDOW.border.top;
            OnWindow(id);
            DrawTooltip();
            OnDrawFinished(id);
            CheckBounds();

            UseLeftMouseButtonEvent();
         }

         private void CheckBounds()
         {
            const float MARGIN = 5;
            if (bounds.x > Screen.width - MARGIN)
            {
               Log.Warning("WINDOW "+id+" OUT OF SCREEN (x=" + bounds.x+"); resetting x coordinates");
               bounds.x = Screen.width - bounds.width;
            }
            if (bounds.x + bounds.width < MARGIN)
            {
               Log.Warning("WINDOW " + id + " OUT OF SCREEN (x=" + bounds.x + "); resetting x coordinates");
               bounds.x = 0;
            }

            if (bounds.y > Screen.height - MARGIN)
            {
               Log.Warning("WINDOW " + id + " OUT OF SCREEN (y=" + bounds.y + "); resetting y coordinates");
               bounds.y = Screen.height - bounds.height;
            }
            if (bounds.y + bounds.height < MARGIN)
            {
               Log.Warning("WINDOW " + id + " OUT OF SCREEN (y=" + bounds.y + "); resetting y coordinates");
               bounds.y = 0;
            }

         }

         protected virtual void OnDrawFinished(int id)
         {
         }

         protected void DrawTooltip()
         {
            tooltip = GUI.tooltip;
            if (tooltip != null && tooltip.Trim().Length > 0)
            {
               Vector2 size = FFStyles.STYLE_TOOLTIP.CalcSize(new GUIContent(tooltip));
               float x = (mousePosition.x + size.x > bounds.width) ? (bounds.width - size.x) : mousePosition.x;
               float y = mousePosition.y + 32;
               if (x < 0) x = 0;
               if (y < 0) y = 0;
               GUI.Label(new Rect(x - 1, y - 1, size.x, size.y), tooltip, FFStyles.STYLE_BG_TOOLTIP);
               GUI.Label(new Rect(x, y, size.x, size.y), tooltip, FFStyles.STYLE_TOOLTIP);
            }
         }

         protected abstract void OnWindow(int id);


         public void SetVisible(bool visible, float x, float y)
         {
            bounds.x = x;
            bounds.y = y;
            SetVisible(visible);
         }

         public void CallOnWindowClose(OnWindowClose method)
         {
            onWindowClose = method;
         }

         public virtual void SetVisible(bool visible)
         {
            if (!this.visible && visible) OnOpen();
            if (this.visible && !visible) OnClose();
            if (this.visible && !visible && onWindowClose != null)  onWindowClose();
            this.visible = visible;
         }

         public bool IsVisible()
         {
            return this.visible;
         }

         // TODO: make protected and add GetWidth(), GetHeight()
         public virtual int GetInitialWidth()
         {
            return DEFAULT_WIDTH;
         }

         // TODO: make protected and add GetWidth(), GetHeight()
         protected virtual int GetInitialHeight()
         {
            return AUTO_HEIGHT;
         }

         public int GetX()
         {
            return (int)bounds.xMin;
         }

         public int GetY()
         {
            return (int)bounds.yMin;
         }

         protected void MoveWindowAside(AbstractWindow window)
         {
            int x = GetX() + GetInitialWidth() + 5;
            if (x + window.GetInitialWidth() > Screen.width) x = GetX() - window.GetInitialWidth() - 5;
            window.SetPosition(x, GetY());
         }

         protected bool MouseOver(float dx=0, float dy=0)
         {
            tmp.x = mousePosition.x + dx;
            tmp.y = mousePosition.y + dy;
            return GUILayoutUtility.GetLastRect().Contains(tmp);
         }

         public Vector2 GetMousePositionInWindow()
         {
            return mousePosition;
         }

         public void SetPosition(int x, int y)
         {
            Log.Trace("moving window "+id+" to "+x+"/"+y);
            bounds.Set(x, y, bounds.width, bounds.height);
         }

         public void SetTitle(String title)
         {
            this.title = title;
         }

         public void CenterWindow()
         {
            if (!visible) return;
            int x = (Screen.width - (int)bounds.width) / 2;
            int y = (Screen.height - (int)bounds.height) / 2;
            SetPosition(x, y);
         }
      }

   }
}
