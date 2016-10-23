using System;
using UnityEngine;
using FinalFrontierAdapter;
using System.Collections.Generic;


namespace Nereid
{
   namespace FinalFrontier
   {
      public class HallOfFameBrowser : PositionableWindow
      {
         private static readonly int KERBAL_BUTTON_WIDTH = 140;
         private static readonly int KERBAL_AREA_WIDTH = 450;
         private static readonly int KERBAL_AREA_HEIGHT = 65;
         private readonly Texture2D TEXTURE_AVAILABLE;
         private readonly Texture2D TEXTURE_ASSIGNED;
         private readonly Texture2D TEXTURE_KILLED;
         private GUIStyle STYLE_KERBAL_BUTTON;
         private GUIStyle STYLE_KERBAL_STATUS;
         private GUIStyle STYLE_KERBAL_AREA;
         private GUIStyle STYLE_KERBAL_INFO;
         private GUIStyle STYLE_KERBAL_AREA_EXPANDED;
         private GUIStyle STYLE_RIBBON_AREA;
         private static readonly int STYLE_SCROLLVIEW_HEIGHT = 450;

         private RibbonBrowser ribbonBrowser;
         private DisplayWindow display;
         private AboutWindow about;
         private ConfigWindow configWindow;

         private Vector2 scrollPosition = Vector2.zero;

         private IButton toolbarButton;
         private String toolbarButtonTextureOn;
         private String toolbarButtonTextureOff;

         // Filter
         HallOfFameFilter filter;
         // Sorter
         HallOfFameSorter sorter;

         public class GameSceneBased
         {
            private GameScenes scene;

            protected GameSceneBased(GameScenes scene)
            {
               this.scene = scene;
            }

            public GameScenes GetScene()
            {
               return scene;
            }

            public override bool Equals(System.Object right)
            {
               if (right == null) return false;
               GameSceneBased cmp = right as GameSceneBased;
               if (cmp == null) return false;
               return scene.Equals(cmp.scene);
            }

            public override int GetHashCode()
            {
               return scene.GetHashCode();
            }
         }

         public class HallOfFameFilter : GameSceneBased,Filter<HallOfFameEntry>
         {
            public bool showDead { get; set; }
            public bool showAssigned { get; set; }
            public bool showAvailable { get; set; }
            public bool showUndecorated { get; set; }
            public bool showFlightOnly { get; set; }

            public HallOfFameFilter(GameScenes scene, bool showDead = true, bool showAssigned = true, bool showAvailable = true, bool showUndecorated = true, bool showFlightOnly = true)
               : base(scene)
            {
               this.showDead = true;
               this.showAssigned = showAssigned;
               this.showAvailable = showAvailable;
               this.showUndecorated = showUndecorated;
               this.showFlightOnly = showFlightOnly;
            }

            public bool Accept(HallOfFameEntry x)
            {
               ProtoCrewMember kerbal = x.GetKerbal();
               if (kerbal == null) return false;
               if (kerbal.rosterStatus == ProtoCrewMember.RosterStatus.Dead && !showDead) return false;
               if (kerbal.rosterStatus == ProtoCrewMember.RosterStatus.Missing && !showDead) return false;
               if (kerbal.rosterStatus == ProtoCrewMember.RosterStatus.Assigned && !showAssigned) return false;
               if (kerbal.rosterStatus == ProtoCrewMember.RosterStatus.Available && !showAvailable) return false;
               //
               if (showFlightOnly && FlightGlobals.ActiveVessel != null && !kerbal.InCrewOfActiveFlight()) return false;
               //
               if (x.GetRibbons().Count == 0 && !showUndecorated) return false;
               return true;

            }

            public override string ToString()
            {
               return GetScene() + ": dead=" + showDead + ", assigned=" + showAssigned + ", available=" + showAvailable + ", undecorated=" + showUndecorated + ", flight only=" + showFlightOnly;
            }
         }

         public class HallOfFameSorter : GameSceneBased, Sorter<HallOfFameEntry>
         {
            public enum DIRECTION { ASCENDING = 1, DESCENDING = 2 };
            public enum STATS_SORTING { NAME = 1, MISSIONS = 2, MISSIONTIME = 3, RIBBONS = 4, DOCKINGS = 5, CONTRACTS = 6, SCIENCE = 7, EVA = 8, STATE = 9  }
            public enum SKILL_SORTING { SPECIALIST = 1, STUPIDITY = 2, COURAGE = 3, EXPERIENCE = 4 }
            //
            private DIRECTION direction;
            private STATS_SORTING stats_sorting;
            private SKILL_SORTING skill_sorting;
            //
            // kerbal display mode: statistics / skills
            public enum SORT_MODE { STATISTIC = 1, SKILL = 2 };
            private SORT_MODE mode = SORT_MODE.STATISTIC;

            public HallOfFameSorter(GameScenes scene, DIRECTION direction = DIRECTION.ASCENDING, SORT_MODE mode = SORT_MODE.STATISTIC, 
                                    STATS_SORTING stats_sort = STATS_SORTING.NAME, SKILL_SORTING skill_sort = SKILL_SORTING.SPECIALIST)
             :  base(scene)
            {
               this.direction = direction;
               this.mode = mode;
               this.stats_sorting = stats_sort;
               this.skill_sorting = skill_sort;
            }

            public String PredicateAsString()
            {
               switch (mode)
               {
                  case SORT_MODE.STATISTIC:
                     switch (stats_sorting)
                     {
                        case STATS_SORTING.NAME: return "Name";
                        case STATS_SORTING.MISSIONS: return "Missions";
                        case STATS_SORTING.MISSIONTIME: return "Mission Time";
                        case STATS_SORTING.RIBBONS: return "Ribbons";
                        case STATS_SORTING.DOCKINGS: return "Dockings";
                        case STATS_SORTING.CONTRACTS: return "Contracts";
                        case STATS_SORTING.SCIENCE: return "Science";
                        case STATS_SORTING.EVA: return "Eva";
                        case STATS_SORTING.STATE: return "State";
                        default:
                           Log.Warning("invalid statistic sort predicate: " + stats_sorting + " (in " + HighLogic.LoadedScene + ")");
                           break;
                     }
                     break;
                  case SORT_MODE.SKILL:
                     switch (skill_sorting)
                     {
                        case SKILL_SORTING.SPECIALIST: return "Specialist";
                        case SKILL_SORTING.STUPIDITY: return "Stupidy";
                        case SKILL_SORTING.COURAGE: return "Courage";
                        case SKILL_SORTING.EXPERIENCE: return "Experience";
                        default:
                           Log.Warning("invalid skill sort predicate: " + skill_sorting + " (in "+HighLogic.LoadedScene+")");
                           break;
                     }
                     break;
               }
               return "Unknown";
            }

            public String ModeAsString()
            {
               switch (mode)
               {
                  case SORT_MODE.SKILL: return "Skills";
                  case SORT_MODE.STATISTIC: return "Statistics";
               }
               return "Unknown";
            }

            public String DirectionAsString()
            {
               switch (direction)
               {
                  case DIRECTION.ASCENDING: return "ASCENDING";
                  case DIRECTION.DESCENDING: return "DESCENDING";
               }
               return "UNKNOWN";
            }


            public void NextStatistic()
            {
               stats_sorting++;
               if ( (int)stats_sorting > 9 ) stats_sorting = STATS_SORTING.NAME;
               HallOfFame.Instance().Sort();
            }

            public void NextSkill()
            {
               skill_sorting++;
               if ((int)skill_sorting > 4) skill_sorting = SKILL_SORTING.SPECIALIST;
               HallOfFame.Instance().Sort();
            }

            public void NextMode()
            {
               mode++;
               if ((int)mode > 2) mode = SORT_MODE.STATISTIC;
               HallOfFame.Instance().Sort();
            }

            public void NextDirection()
            {
               direction++;
               if ((int)direction > 2) direction = DIRECTION.ASCENDING;
               HallOfFame.Instance().Sort();
            }

            private void SortBySkill(List<HallOfFameEntry> list)
            {
               list.Sort(delegate(HallOfFameEntry left, HallOfFameEntry right)
               {
                  int sign = direction == DIRECTION.ASCENDING ? 1 : -1;
                  ProtoCrewMember leftkerbal = left.GetKerbal();
                  ProtoCrewMember rightkerbal = right.GetKerbal();
                  if(leftkerbal == null ) return -1;
                  if(rightkerbal == null ) return 1;
                  int cmp;
                  switch (skill_sorting)
                  {
                     case SKILL_SORTING.SPECIALIST:
                        cmp = sign * (leftkerbal.experienceTrait.TypeName.CompareTo(rightkerbal.experienceTrait.TypeName));
                        if (cmp != 0) return cmp;
                        cmp = sign * (leftkerbal.experienceLevel - rightkerbal.experienceLevel);
                        if (cmp != 0) return cmp;
                        return sign * (left.GetName().CompareTo(right.GetName()));
                     case SKILL_SORTING.COURAGE:
                        cmp = sign * (Math.Sign(leftkerbal.courage - rightkerbal.courage));
                        if (cmp != 0) return cmp;
                        return sign * (left.GetName().CompareTo(right.GetName()));
                     case SKILL_SORTING.STUPIDITY:
                        cmp = sign * (Math.Sign(leftkerbal.stupidity - rightkerbal.stupidity));
                        if (cmp != 0) return cmp;
                        return sign * (left.GetName().CompareTo(right.GetName()));
                     case SKILL_SORTING.EXPERIENCE:
                        cmp = sign * (Math.Sign(leftkerbal.experience - rightkerbal.experience));
                        if (cmp != 0) return cmp;
                        return sign * (left.GetName().CompareTo(right.GetName()));
                     default:
                        Log.Error("unknown sorting method");
                        return 0;
                  }
               });
            }

            private void SortByStatistic(List<HallOfFameEntry> list)
            {
               list.Sort(delegate(HallOfFameEntry left, HallOfFameEntry right)
               {
                  int sign = direction == DIRECTION.ASCENDING ? 1 : -1;
                  int cmp;
                  switch (stats_sorting)
                  {
                     case STATS_SORTING.NAME:
                        return sign * (left.GetName().CompareTo(right.GetName()));
                     case STATS_SORTING.MISSIONS:
                        cmp = sign * (left.MissionsFlown - right.MissionsFlown);
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.MISSIONTIME:
                        cmp = (int)(sign * (left.TotalMissionTime - right.TotalMissionTime));
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.RIBBONS:
                        cmp = sign * (left.GetRibbons().Count - right.GetRibbons().Count);
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.STATE:
                        ProtoCrewMember leftKerbal = left.GetKerbal();
                        ProtoCrewMember rightKerbal = right.GetKerbal();
                        if (left == null) return -1;
                        if (right == null) return 1;
                        cmp = sign * (leftKerbal.rosterStatus.CompareTo(rightKerbal.rosterStatus));
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.DOCKINGS:
                        cmp = sign * (left.Dockings - right.Dockings);
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.CONTRACTS:
                        cmp = sign * (left.ContractsCompleted - right.ContractsCompleted);
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.SCIENCE:
                        cmp = sign * (int)(100.0 * (left.Research - right.Research));
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     case STATS_SORTING.EVA:
                        cmp = sign * (int)(left.TotalEvaTime - right.TotalEvaTime);
                        if (cmp != 0) return cmp;
                        return left.GetName().CompareTo(right.GetName());
                     default:
                        Log.Error("unknown sorting method");
                        return 0;
                  }
               });

            }

            public void Sort(List<HallOfFameEntry> list)
            {
               if (list == null) return;
               switch(mode)
               {
                  case SORT_MODE.STATISTIC:
                     SortByStatistic(list);
                     break;
                  case SORT_MODE.SKILL:
                     SortBySkill(list);
                     break;
               }
            }

            public void SetDirection(DIRECTION direction)
            {
               this.direction = direction;
               HallOfFame.Instance().Sort();
            }

            public void SetStatsPredicate(STATS_SORTING predicate)
            {
               this.stats_sorting = predicate;
               HallOfFame.Instance().Sort();
            }

            public void SetSkillPredicate(SKILL_SORTING predicate)
            {
               this.skill_sorting = predicate;
               HallOfFame.Instance().Sort();
            }

            public void SetMode(SORT_MODE mode)
            {
               this.mode = mode;
               HallOfFame.Instance().Sort();
            }

            public SORT_MODE GetMode()
            {
               return mode;
            }

            public DIRECTION GetDirection()
            {
               return direction;
            }

            public STATS_SORTING GetStatsPredicate()
            {
               return stats_sorting;
            }

            public SKILL_SORTING GetSkillPredicate()
            {
               return skill_sorting;
            }

            public override string ToString()
            {
               switch(mode)
               {
                  case SORT_MODE.STATISTIC: return GetScene() + ": sort by " + stats_sorting + " " + direction;
                  case SORT_MODE.SKILL: return GetScene() + ": sort by " + skill_sorting + " " + direction;
               }
               return "unknown sort mode";
            }
         }

         // expanded ribbon area (-1: none)
         private int expandedRibbonAreaIndex = -1;


         public HallOfFameBrowser()
            : base(Constants.WINDOW_ID_HALLOFFAMEBROWSER, FinalFrontier.configuration.GetHallOfFameWindowTitle())
         {
            STYLE_KERBAL_BUTTON = new GUIStyle(HighLogic.Skin.button);
            STYLE_KERBAL_BUTTON.fixedWidth = KERBAL_BUTTON_WIDTH;
            STYLE_KERBAL_BUTTON.clipping = TextClipping.Clip;
            STYLE_KERBAL_STATUS = new GUIStyle(HighLogic.Skin.button);
            STYLE_KERBAL_STATUS.fixedWidth = 20;
            STYLE_KERBAL_AREA = new GUIStyle(HighLogic.Skin.box);
            STYLE_KERBAL_AREA.fixedWidth = KERBAL_AREA_WIDTH;
            STYLE_KERBAL_AREA.fixedHeight = KERBAL_AREA_HEIGHT;
            STYLE_KERBAL_AREA.clipping = TextClipping.Clip;
            STYLE_KERBAL_AREA_EXPANDED = new GUIStyle(HighLogic.Skin.box);
            STYLE_KERBAL_AREA_EXPANDED.fixedWidth = KERBAL_AREA_WIDTH;
            STYLE_KERBAL_AREA_EXPANDED.stretchHeight = true;
            STYLE_KERBAL_AREA_EXPANDED.clipping = TextClipping.Clip;
            STYLE_KERBAL_INFO = new GUIStyle(HighLogic.Skin.label);
            STYLE_RIBBON_AREA = new GUIStyle(HighLogic.Skin.label);
            STYLE_RIBBON_AREA.stretchHeight = true;
            STYLE_RIBBON_AREA.stretchWidth = true;
            STYLE_RIBBON_AREA.padding = new RectOffset(10, 10, 2, 2);

            TEXTURE_AVAILABLE = ImageLoader.GetTexture(FinalFrontier.RESOURCE_PATH + "active");
            TEXTURE_ASSIGNED = ImageLoader.GetTexture(FinalFrontier.RESOURCE_PATH + "assigned");
            TEXTURE_KILLED = ImageLoader.GetTexture(FinalFrontier.RESOURCE_PATH + "killed");

            ribbonBrowser = new RibbonBrowser();
            display = new DisplayWindow();
            about = new AboutWindow();
            configWindow = new ConfigWindow();
         }


         protected override void OnWindow(int id)
         {
            // persistent filter for displaying kerbals
            if(filter==null || filter.GetScene()!=HighLogic.LoadedScene) this.filter = FinalFrontier.configuration.GetDisplayFilterForSzene(HighLogic.LoadedScene);
            //
            // persistent sorter for displaying kerbals
            if (sorter == null || sorter.GetScene() != HighLogic.LoadedScene)
            {
               // sorter has changed
               this.sorter = FinalFrontier.configuration.GetHallOfFameSorterForScene(HighLogic.LoadedScene);
               HallOfFame.Instance().SetSorter(this.sorter);
            }
            // color of info
            switch(sorter.GetMode())
            {
               case HallOfFameSorter.SORT_MODE.STATISTIC:
                  STYLE_KERBAL_INFO.normal.textColor = HighLogic.Skin.label.normal.textColor;
                  break;
               case HallOfFameSorter.SORT_MODE.SKILL:
                  STYLE_KERBAL_INFO.normal.textColor = Color.cyan;
                  break;
            }
            //
            GUILayout.BeginHorizontal();
            scrollPosition = GUILayout.BeginScrollView(scrollPosition, GUILayout.Width(490), GUILayout.Height(STYLE_SCROLLVIEW_HEIGHT));
            GUILayout.BeginVertical();
            int index = 0;
            bool expandDetected = false;
            bool autoexpandEnabled = FinalFrontier.configuration.IsAutoExpandEnabled();
            lock(HallOfFame.Instance())
            {
               foreach (HallOfFameEntry entry in HallOfFame.Instance())
               {
                  // autoexpand this entry on mouse hover?
                  bool expandedEntry = autoexpandEnabled && (expandedRibbonAreaIndex == index) && (entry.GetRibbons().Count > Constants.MAX_RIBBONS_PER_AREA);
                  //
                  ProtoCrewMember kerbal = entry.GetKerbal();
                  String info = GetInfo(entry);
                  String missionTimeInDays = Utils.GameTimeInDaysAsString(entry.TotalMissionTime) + (GameUtils.IsKerbinTimeEnabled() ? " kerbin" : "");
                  if (kerbal != null && filter.Accept(entry) && kerbal.IsCrew())
                  {
                     String buttonTooltip = kerbal.name + ": " + entry.MissionsFlown + " missions, " + missionTimeInDays + " days mission time";
                     GUILayout.BeginHorizontal(STYLE_KERBAL_AREA_EXPANDED); //expandedEntry ? STYLE_KERBAL_AREA_EXPANDED : STYLE_KERBAL_AREA);          
                     GUILayout.BeginVertical();
                     GUILayout.BeginHorizontal();
                     // butto to open decoration board
                     if (GUILayout.Button(new GUIContent(entry.GetName(), buttonTooltip), STYLE_KERBAL_BUTTON))
                     {
                        Log.Detail("opening decoration board for kerbal " + entry.GetName());
                        display.SetEntry(entry);
                        display.SetVisible(true);
                     }
                     DrawStatus(kerbal);
                     GUILayout.EndHorizontal();
                     GUILayout.Label(info, STYLE_KERBAL_INFO);
                     GUILayout.EndVertical();
                     DrawRibbons(entry, expandedEntry ? Constants.MAX_RIBBONS_PER_EXPANDED_AREA : Constants.MAX_RIBBONS_PER_AREA);
                     GUILayout.EndHorizontal();
                     //
                     if (Event.current.type == EventType.Repaint)
                     {
                        if (MouseOver(0.0f, scrollPosition.y))
                        {
                           expandedRibbonAreaIndex = index;
                           expandDetected = true;
                        }
                     }
                  }
                  index++;
               } // foreach entry
            } // lock (HAllOfFame)
            GUILayout.EndVertical();
            GUILayout.EndScrollView();
            GUILayout.BeginVertical();
            if (GUILayout.Button("Close", FFStyles.STYLE_BUTTON))
            {
               SetVisible(false);
               ribbonBrowser.SetVisible(false);
               display.SetVisible(false);
            }
            GUILayout.Label("", FFStyles.STYLE_STRETCHEDLABEL);
            if (GUILayout.Button("Ribbons", FFStyles.STYLE_BUTTON))
            {
               if(!ribbonBrowser.IsVisible())
               {
                  OpenRibbonBrowser();
               }
               else
               {
                  ribbonBrowser.SetVisible(false);
               }
            }
            GUILayout.Label("", FFStyles.STYLE_STRETCHEDLABEL);
            GUILayout.Label("Filter:", FFStyles.STYLE_STRETCHEDLABEL);
            if (GUILayout.Toggle(filter.showDead, "dead", FFStyles.STYLE_TOGGLE)) filter.showDead = true; else filter.showDead = false;
            if (GUILayout.Toggle(filter.showAssigned, "active", FFStyles.STYLE_TOGGLE)) filter.showAssigned = true; else filter.showAssigned = false;
            if (GUILayout.Toggle(filter.showAvailable, "available", FFStyles.STYLE_TOGGLE)) filter.showAvailable = true; else filter.showAvailable = false;
            if (GUILayout.Toggle(filter.showUndecorated, "undecorated", FFStyles.STYLE_TOGGLE)) filter.showUndecorated = true; else filter.showUndecorated = false;
            if (HighLogic.LoadedScene == GameScenes.FLIGHT)
            {
               if (GUILayout.Toggle(filter.showFlightOnly, "flight only", FFStyles.STYLE_TOGGLE)) filter.showFlightOnly = true; else filter.showFlightOnly = false;
            }
            GUILayout.Label("", FFStyles.STYLE_STRETCHEDLABEL); // fixed space

            // sorter
            GUILayout.FlexibleSpace();
            GUILayout.Label("Sort by:", FFStyles.STYLE_STRETCHEDLABEL);
            DrawSorterButtons();
            GUILayout.Label("", FFStyles.STYLE_STRETCHEDLABEL); // fixed space

            GUILayout.FlexibleSpace();
            if (GUILayout.Button("Config", FFStyles.STYLE_BUTTON))
            {
               if (!configWindow.IsVisible()) MoveWindowAside(configWindow);
               configWindow.SetVisible(!configWindow.IsVisible());
            }
            if (GUILayout.Button("About", FFStyles.STYLE_BUTTON)) about.SetVisible(!about.IsVisible());
            GUILayout.EndVertical();
            GUILayout.EndHorizontal();

            if (Event.current.type == EventType.Repaint && !expandDetected)
            {
               expandedRibbonAreaIndex = -1;
            }
            
            DragWindow();

         }

         private String GetInfo(HallOfFameEntry entry)
         {
            switch(sorter.GetMode())
            {
               default:
               case HallOfFameSorter.SORT_MODE.STATISTIC:
                  switch(sorter.GetStatsPredicate())
                  {
                     default:
                        return entry.MissionsFlown + " missions";
                     case HallOfFameSorter.STATS_SORTING.EVA:
                        return Utils.GameTimeAsString(entry.TotalEvaTime) + " in EVA";
                     case HallOfFameSorter.STATS_SORTING.DOCKINGS:
                        return entry.Dockings + " docking operations";
                     case HallOfFameSorter.STATS_SORTING.MISSIONTIME:
                        return Utils.GameTimeInDaysAsString(entry.TotalMissionTime) + " days in missions";
                     case HallOfFameSorter.STATS_SORTING.CONTRACTS:
                        return entry.ContractsCompleted + " contracts completed";
                     case HallOfFameSorter.STATS_SORTING.SCIENCE:
                        return entry.Research.ToString("0.0") + " science points";
                  }
               case HallOfFameSorter.SORT_MODE.SKILL:
                  ProtoCrewMember kerbal = entry.GetKerbal();
                  if (kerbal == null) return "no kerbal";
                  String specialist = kerbal.experienceTrait.TypeName;
                  switch (sorter.GetSkillPredicate())
                  {
                     case HallOfFameSorter.SKILL_SORTING.STUPIDITY:
                        return specialist+" ("+kerbal.stupidity.ToString("0.00")+ " stupidity)";
                     case HallOfFameSorter.SKILL_SORTING.COURAGE:
                        return specialist + " (" + kerbal.courage.ToString("0.00") + " courage)";
                     case HallOfFameSorter.SKILL_SORTING.EXPERIENCE:
                        return specialist + " (" + kerbal.experience + " xp)";
                     default:
                        return specialist + " (level " + kerbal.experienceLevel + ")";
                  }
            }
         }

         private void DrawSorterButtons()
         {
            if (GUILayout.Button(sorter.ModeAsString(), FFStyles.STYLE_NARROW_BUTTON))
            {
               sorter.NextMode();
            }
            if (GUILayout.Button(sorter.PredicateAsString(), FFStyles.STYLE_BUTTON))
            {
               switch(sorter.GetMode())
               {
                  case HallOfFameSorter.SORT_MODE.STATISTIC:
                     sorter.NextStatistic();
                     break;
                  case HallOfFameSorter.SORT_MODE.SKILL:
                     sorter.NextSkill();
                     break;
               }
            }
            if (GUILayout.Button(sorter.DirectionAsString(), FFStyles.STYLE_NARROW_BUTTON))
            {
               sorter.NextDirection();
            }
         }


         private void DrawStatus(ProtoCrewMember kerbal)
         {
            ProtoCrewMember.RosterStatus status = kerbal.rosterStatus;
            String tooltip;
            switch(status)
            {
               case ProtoCrewMember.RosterStatus.Dead:
               case ProtoCrewMember.RosterStatus.Missing:
                  tooltip = kerbal.name + " is dead";
                  GUILayout.Label(new GUIContent(TEXTURE_KILLED, tooltip), STYLE_KERBAL_STATUS);
                  break;
               case ProtoCrewMember.RosterStatus.Assigned:
                  tooltip = kerbal.name + " is currently on a mission";
                  GUILayout.Label(new GUIContent(TEXTURE_ASSIGNED, tooltip), STYLE_KERBAL_STATUS);
                  break;
               default:
                  tooltip = kerbal.name + " is available for next mission";
                  GUILayout.Label(new GUIContent(TEXTURE_AVAILABLE, tooltip), STYLE_KERBAL_STATUS);
                  break;
            }
         }

         private void OpenRibbonBrowser()
         {
            float x = bounds.x + bounds.width + 8;
            float y = bounds.y;
            if (x + RibbonBrowser.WIDTH > Screen.width)
            {
               x = Screen.width - RibbonBrowser.WIDTH;
            }
            ribbonBrowser.SetVisible(true, x, y);
         }


         private void DrawRibbons(HallOfFameEntry entry, int max)
         {
            ProtoCrewMember kerbal = entry.GetKerbal();
            List<Ribbon> ribbons = entry.GetRibbons();

            GUILayout.BeginVertical(STYLE_RIBBON_AREA);
            int n = 0;
            int RIBBONS_PER_LINE = 4;
            foreach (Ribbon ribbon in ribbons)
            {
               if (n % RIBBONS_PER_LINE == 0) GUILayout.BeginHorizontal();
               String tooltip = ribbon.GetName() + "\n" + ribbon.GetDescription();
               GUILayout.Button(new GUIContent(ribbon.GetTexture(), tooltip), FFStyles.STYLE_RIBBON);
               n++;
               if (n % RIBBONS_PER_LINE == 0) GUILayout.EndHorizontal();
               if (n >= max) break;
            }
            if (n % RIBBONS_PER_LINE != 0) GUILayout.EndHorizontal();
            GUILayout.EndVertical();
         }

         protected void DrawRibbon(int x, int y, Ribbon ribbon, int scale = 1)
         {
            Rect rect = new Rect(x, y, ribbon.GetWidth() / scale, ribbon.GetHeight() / scale);
            GUI.DrawTexture(rect, ribbon.GetTexture());
         }

         protected override void OnOpen()
         {
            Log.Info("hall of fame browser opened");
            base.OnOpen();
            HallOfFame.Instance().Refresh();
            if (toolbarButton != null)
            {
               toolbarButton.TexturePath = toolbarButtonTextureOn;
            }
         }

         protected override void OnClose()
         {
            base.OnClose();
            if (toolbarButton != null)
            {
               toolbarButton.TexturePath = toolbarButtonTextureOff;
            }
         }

         public override int GetInitialWidth()
         {
            return 650;
         }

         public void registerToolbarButton(IButton button, String textureOn, String textureOff)
         {
            this.toolbarButton = button;
            this.toolbarButtonTextureOn = textureOn;
            this.toolbarButtonTextureOff = textureOff;
         }
      }
   }
}


