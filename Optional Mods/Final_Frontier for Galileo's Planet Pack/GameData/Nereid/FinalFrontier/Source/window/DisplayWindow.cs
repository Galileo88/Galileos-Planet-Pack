using System;
using UnityEngine;
using System.Collections.Generic;

namespace Nereid
{
   namespace FinalFrontier
   {
      class DisplayWindow : PositionableWindow
      {

         private static readonly int RIBBON_LINES = 10;
         private static readonly int RIBBONS_PER_LINE = 4;
         private static readonly int RIBBON_DISPLAY_HEIGHT = RIBBON_LINES * Ribbon.HEIGHT;
         private static readonly int RIBBON_DISPLAY_SKIP = 2;
         private static readonly int RIBBON_DISPLAY_WIDTH = RIBBONS_PER_LINE * (RIBBON_DISPLAY_SKIP + Ribbon.WIDTH) + 20;
         private static readonly int RIBBON_LOGBOOK_HEIGHT = 100;
         private static readonly int WIDTH = 500;
         private static readonly GUIStyle STYLE_TEXT_LABEL = new GUIStyle(HighLogic.Skin.button);
         private static readonly GUIStyle STYLE_VALUE_LABEL = new GUIStyle(HighLogic.Skin.button);
         private static readonly GUIStyle STYLE_STATUS_LABEL = new GUIStyle(HighLogic.Skin.button);
         private static readonly GUIStyle STYLE_LOCATION_LABEL = new GUIStyle(HighLogic.Skin.button);
         private static readonly GUIStyle STYLE_LOGBOOK_BOX = new GUIStyle(HighLogic.Skin.box);
         private static readonly GUIStyle STYLE_TOPRIGHT_LAYOUT = new GUIStyle(HighLogic.Skin.label);

         // custom award dialogue
         private enum MODE { DISPLAY, AWARD, REVOCATION };
         private MODE mode = MODE.DISPLAY;
         private Ribbon selected = null;
         private String customRibbonName = "";
         private String customRibbonText = "";
         private bool showOwnedRibbons = false;
         HashSet<Ribbon> revocation = new HashSet<Ribbon>();


         // revocation dialogue
         private bool revocatioOfSupersededRibbons = true;

         private HallOfFameEntry entry;
         private Vessel vessel;

         private Vector2 scrollPosRibbons = Vector2.zero;
         private Vector2 scrollPosLogbook = Vector2.zero;
         private Vector2 scrollPosCustRib = Vector2.zero;
         private Vector2 scrollPosRevoRib = Vector2.zero;

         public DisplayWindow()
            : base(Constants.WINDOW_ID_DISPLAY, FinalFrontier.configuration.GetDecorationBoardWindowTitle())
         {
            //
            STYLE_TEXT_LABEL.fixedWidth = 200;
            STYLE_TEXT_LABEL.stretchWidth = false;
            STYLE_TEXT_LABEL.clipping = TextClipping.Clip;
            STYLE_TEXT_LABEL.alignment = TextAnchor.MiddleLeft;
            STYLE_VALUE_LABEL.fixedWidth = 120;
            STYLE_VALUE_LABEL.stretchWidth = false;
            STYLE_VALUE_LABEL.clipping = TextClipping.Clip;
            STYLE_VALUE_LABEL.alignment = TextAnchor.MiddleRight;
            STYLE_STATUS_LABEL.stretchWidth = true;
            STYLE_STATUS_LABEL.clipping = TextClipping.Clip;
            STYLE_STATUS_LABEL.alignment = TextAnchor.MiddleCenter;
            STYLE_LOCATION_LABEL.stretchWidth = true;
            STYLE_LOCATION_LABEL.clipping = TextClipping.Clip;
            STYLE_LOCATION_LABEL.alignment = TextAnchor.MiddleCenter;
            STYLE_LOGBOOK_BOX.stretchWidth = true;
            STYLE_LOGBOOK_BOX.wordWrap = true;
            STYLE_LOGBOOK_BOX.alignment = TextAnchor.UpperLeft;
            STYLE_LOGBOOK_BOX.normal.textColor = STYLE_VALUE_LABEL.normal.textColor;
            STYLE_TOPRIGHT_LAYOUT.alignment = TextAnchor.UpperRight;
         }

         protected override void OnWindow(int id)
         {
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("drawing of decoration board started (mode="+mode+")");
            GUILayout.BeginVertical();
            // detailed statistics
            GUILayout.BeginVertical(HighLogic.Skin.scrollView);
            GUILayout.BeginHorizontal();
            GUILayout.Label(entry != null ? entry.GetName() : "", FFStyles.STYLE_BUTTON);
            CloseButton();
            GUILayout.EndHorizontal();
            DrawStatistics();
            GUILayout.EndVertical();
            // decorations
            GUILayout.BeginHorizontal();
            GUILayout.Label("Decorations", FFStyles.STYLE_TITLE_LABEL);
            GUILayout.FlexibleSpace();
            switch(mode)
            {
               case MODE.DISPLAY:
                  if(FinalFrontier.configuration.IsRevocationOfRibbonsEnabled())
                  {
                     if (GUILayout.Button("Revocation", FFStyles.STYLE_NARROW_BUTTON)) 
                     {
                        mode = MODE.REVOCATION;
                     }
                  }
                  if (GUILayout.Button("Award Ribbon", FFStyles.STYLE_NARROW_BUTTON))
                  {
                     mode = MODE.AWARD;
                  }
                  break;
               case MODE.AWARD:
                  if(FinalFrontier.configuration.IsRevocationOfRibbonsEnabled())
                  {
                     if (GUILayout.Button("Revocation", FFStyles.STYLE_NARROW_BUTTON)) 
                     {
                        mode = MODE.REVOCATION;
                     }
                  }
                  if (GUILayout.Button("Show Ribbons", FFStyles.STYLE_NARROW_BUTTON))
                  {
                     mode = MODE.DISPLAY;
                  }
                  break;
               case MODE.REVOCATION:
                  if(FinalFrontier.configuration.IsRevocationOfRibbonsEnabled())
                  {
                     if (GUILayout.Button("Show Ribbons", FFStyles.STYLE_NARROW_BUTTON)) 
                     {
                        mode = MODE.DISPLAY;
                     }
                  }
                  if (GUILayout.Button("Award Ribbon", FFStyles.STYLE_NARROW_BUTTON))
                  {
                     mode = MODE.AWARD;
                  }
                  break;
            }
            GUILayout.EndHorizontal();
            scrollPosRibbons = GUILayout.BeginScrollView(scrollPosRibbons, FFStyles.STYLE_SCROLLVIEW, GUILayout.Width(RIBBON_DISPLAY_WIDTH), GUILayout.Height(RIBBON_DISPLAY_HEIGHT));
            switch(mode)
            {
               case MODE.DISPLAY: 
                  DrawRibbons(); 
                  break;
               case MODE.AWARD:
                  // draw warning if not in flight
                  if (HighLogic.LoadedScene == GameScenes.FLIGHT || FinalFrontier.configuration.IsCustomRibbonAtSpaceCenterEnabled())
                  {
                     DrawCustomAwardDialog();
                  }
                  else
                  {
                     DrawWarningDialog(); 
                  }
                  break;
               case MODE.REVOCATION:
                  DrawRevocationDialog();
                  break;
            }
            GUILayout.EndScrollView();
            // logbook
            GUILayout.Label("Logbook", FFStyles.STYLE_TITLE_LABEL);
            scrollPosLogbook = GUILayout.BeginScrollView(scrollPosLogbook, FFStyles.STYLE_SCROLLVIEW, GUILayout.Width(RIBBON_DISPLAY_WIDTH), GUILayout.Height(RIBBON_LOGBOOK_HEIGHT));
            GUILayout.Box(entry.GetLogText(), STYLE_LOGBOOK_BOX);
            GUILayout.EndScrollView();
            GUILayout.EndVertical();
            //
            DragWindow();
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("drawing decoration of board finished");
         }

         private void CloseButton()
         {
            if (GUILayout.Button("Close", FFStyles.STYLE_CONTROL_BUTTON))
            {
               SetVisible(false);
            }
         }

         private void DrawStatistics()
         {
            ProtoCrewMember kerbal = entry.GetKerbal();
            double missionTimeInDays = Utils.GameTimeInDays(entry.TotalMissionTime);
            String evaTime = Utils.GameTimeAsString(entry.TotalEvaTime);
            GUILayout.BeginVertical();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Completed Missions: ", STYLE_TEXT_LABEL);
            GUILayout.Label(entry.MissionsFlown.ToString(), STYLE_VALUE_LABEL);
            DrawStatus(kerbal);
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Docking Operations: ", STYLE_TEXT_LABEL);
            GUILayout.Label(entry.Dockings.ToString(), STYLE_VALUE_LABEL);
            DrawVessel(kerbal);
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Accumulated Mission Time: ", STYLE_TEXT_LABEL);
            GUILayout.Label(missionTimeInDays.ToString("0.00")+" days", STYLE_VALUE_LABEL);
            DrawSituation(kerbal);
            GUILayout.EndHorizontal();
            GUILayout.BeginHorizontal();
            GUILayout.Label("Accumulated Eva Time: ", STYLE_TEXT_LABEL);
            GUILayout.Label(evaTime, STYLE_VALUE_LABEL);
            DrawLocation(kerbal);
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
         }


         private void DrawWarningDialog()
         {
            GUILayout.BeginVertical();
            GUILayout.Label("Warning: Assigning ribbons at space center may not work as expected!", FFStyles.STYLE_BUTTON_LABEL);
            if(GUILayout.Toggle(false, "ignore this warning", FFStyles.STYLE_TOGGLE)) 
            {
               FinalFrontier.configuration.SetCustomRibbonAtSpaceCenterEnabled(true);
            }
            GUILayout.EndVertical();
         }

         private void DrawCustomAwardDialog()
         {
            GUILayout.BeginVertical();
            GUILayout.Label("Select ribbon to award", FFStyles.STYLE_BUTTON_LABEL);
            GUILayout.BeginHorizontal();
            // ribbon choice
            scrollPosCustRib = GUILayout.BeginScrollView(scrollPosCustRib, FFStyles.STYLE_SCROLLVIEW);
            foreach (Ribbon ribbon in RibbonPool.Instance().GetCustomRibbons())
            {
               if(showOwnedRibbons || !entry.HasRibbon(ribbon))
               {
                  GUILayout.BeginHorizontal();
                  Achievement achievement = ribbon.GetAchievement();
                  String tooltip = ribbon.GetName();
                  GUIContent content = new GUIContent(ribbon.GetTexture(), tooltip);
                  if (GUILayout.Button(content, FFStyles.STYLE_RIBBON))
                  {
                     selected = ribbon;
                     customRibbonName = achievement.GetName();
                     customRibbonText = achievement.GetDescription();
                  }
                  GUILayout.Label(achievement.GetName(), FFStyles.STYLE_RIBBON_LABEL);
                  GUILayout.EndHorizontal();
               }
            }
            GUILayout.EndScrollView();
            DrawSelectedCustomRibbon(selected);
            GUILayout.EndHorizontal();
            // OK/CANCEL
            GUILayout.BeginHorizontal();
            // Filter
            if (GUILayout.Toggle(showOwnedRibbons, "achieved ribbons", FFStyles.STYLE_TOGGLE)) showOwnedRibbons = true; else showOwnedRibbons = false;
            // 
            GUILayout.FlexibleSpace();
            // OK/CANCEL
            if(selected!=null)
            {
               if (GUILayout.Button("OK", FFStyles.STYLE_CONTROL_BUTTON))
               {
                  AwardSelectedCustomRibbon();
                  // leave
                  LeaveCustomRibbonSelection();
               }
            }
            if (GUILayout.Button("CANCEL", FFStyles.STYLE_CONTROL_BUTTON)) LeaveCustomRibbonSelection();
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
         }

         private void DrawSelectedCustomRibbon(Ribbon ribbon)
         {
            GUILayout.BeginVertical();
            GUILayout.BeginHorizontal(STYLE_TOPRIGHT_LAYOUT);
            if (ribbon != null)
            {
               GUIContent selected = new GUIContent(ribbon.GetTexture(), customRibbonName);
               GUILayout.Label(selected, FFStyles.STYLE_SINGLE_RIBBON);
            }
            else
            {
               String tooltip = "no ribbon selected";
               GUIContent selected = new GUIContent("NO RIBBON SELECTED", tooltip);
               GUILayout.Label(selected, FFStyles.STYLE_SINGLE_RIBBON);
            }
            if(ribbon!=null)
            {
               Ribbon supersede = ribbon.SupersedeRibbon();
               if(supersede!=null)
               {
                  GUIContent superseede = new GUIContent(supersede.GetTexture(), "supersede: "+supersede.GetName());
                  GUILayout.Label(superseede, FFStyles.STYLE_RIBBON_OFF5);
               }
            }
            GUILayout.EndHorizontal();
            customRibbonName = GUILayout.TextField(customRibbonName, FFStyles.STYLE_TEXTFIELD);
            customRibbonText = GUILayout.TextArea(customRibbonText, FFStyles.STYLE_TEXTAREA, GUILayout.Width(300));
            GUILayout.EndVertical();
         }


         private void AwardSelectedCustomRibbon()
         {
            if(selected==null)
            {
               Log.Warning("no custom ribbon selected");
               return;
            }

            CustomAchievement achievement = selected.GetAchievement() as CustomAchievement;
            if (achievement == null)
            {
               Log.Warning("invalid custom ribbon");
               return;
            }

            // changed name or text?
            if (!achievement.GetDescription().Equals(customRibbonText) || !achievement.GetName().Equals(customRibbonName))
            {
               Log.Detail("name or text change of ribbon " + selected.GetCode());
               // change name and text
               achievement.SetName(customRibbonName);
               achievement.SetDescription(customRibbonText);
               // record changed ribbon
               HallOfFame.Instance().RecordCustomRibbon(selected);
            }

            // assign ribbon to kerbal
            Log.Trace("assigning custom ribbon " + selected + " to kerbal " + entry.GetKerbal().name+" at game time "+Planetarium.GetUniversalTime());
            HallOfFame.Instance().BeginArwardOfRibbons();
            HallOfFame.Instance().Record(entry.GetKerbal(), selected);
            HallOfFame.Instance().EndArwardOfRibbons();
            //
            // mark game as updated, if not in flight
            if ( HighLogic.LoadedScene != GameScenes.FLIGHT )
            {
               Log.Trace("mark game as updated");
               HighLogic.CurrentGame.Updated();
            }
         }

         private void LeaveCustomRibbonSelection()
         {
            mode = MODE.DISPLAY;
            selected = null;
            customRibbonName = "";
            customRibbonText = "";
         }

         private void DrawRibbons()
         {
            if(entry==null) return;
            int n = 0;
            foreach(Ribbon ribbon in entry.GetRibbons())
            {
               if (n % RIBBONS_PER_LINE == 0) GUILayout.BeginHorizontal();
               String tooltip = ribbon.GetName();
               GUIContent content = new GUIContent(ribbon.GetTexture(), tooltip);
               GUILayout.Label(content, FFStyles.STYLE_SINGLE_RIBBON);
               n++;
               if (n % RIBBONS_PER_LINE == 0) 
               {
                  // next line of ribbons
                  GUILayout.EndHorizontal(); 
               } 
            }
            if (n % RIBBONS_PER_LINE != 0) GUILayout.EndHorizontal();
         }

         private void DrawRevocationDialog()
         {

            GUILayout.BeginVertical();
            if (entry == null) return;
            GUILayout.Label("Select ribbons for revocation", FFStyles.STYLE_STRETCHEDLABEL);
            scrollPosRevoRib = GUILayout.BeginScrollView(scrollPosRevoRib, FFStyles.STYLE_SCROLLVIEW);
            foreach (Ribbon ribbon in entry.GetRibbons())
            {
               Achievement achievement = ribbon.GetAchievement();
               GUIContent content = new GUIContent(ribbon.GetTexture(), customRibbonName);
               GUILayout.BeginHorizontal();
               if (GUILayout.Toggle(revocation.Contains(ribbon), "", FFStyles.STYLE_NARROW_TOGGLE))
               {
                  revocation.Add(ribbon);
               }
               else
               {
                  revocation.Remove(ribbon);
               }
               GUILayout.Label(content, FFStyles.STYLE_RIBBON_OFF5);
               GUILayout.Label(achievement.GetName(), FFStyles.STYLE_LABEL_OFF5);
               GUILayout.FlexibleSpace();
               GUILayout.EndHorizontal();
            }
            GUILayout.EndScrollView(); 
            //GUILayout.FlexibleSpace();
            // OK/CANCEL
            GUILayout.BeginHorizontal();
            // 
            revocatioOfSupersededRibbons = GUILayout.Toggle(revocatioOfSupersededRibbons, "superseded ribbons",  FFStyles.STYLE_TOGGLE);
            GUILayout.FlexibleSpace();
            // OK/CANCEL
            if (revocation.Count>0)
            {
               if (GUILayout.Button("OK", FFStyles.STYLE_CONTROL_BUTTON))
               {
                  ProtoCrewMember kerbal = entry.GetKerbal();
                  foreach(Ribbon ribbon in revocation)
                  {
                     HallOfFame.Instance().Revocation(kerbal, ribbon, revocatioOfSupersededRibbons);
                  }
                  revocation.Clear();
                  mode = MODE.DISPLAY;
                  Log.Trace("mark game as updated, because of revocation");
                  HighLogic.CurrentGame.Updated();
               }
            }
            
            if (GUILayout.Button("CANCEL", FFStyles.STYLE_CONTROL_BUTTON))
            {
               revocation.Clear();
               mode = MODE.DISPLAY;
            }
            GUILayout.EndHorizontal();
            GUILayout.EndVertical();
         }


         private void DrawStatus(ProtoCrewMember kerbal)
         {
            String status = "unknown";
            switch(kerbal.rosterStatus)
            {
               case ProtoCrewMember.RosterStatus.Missing:
               case ProtoCrewMember.RosterStatus.Dead:
                  STYLE_STATUS_LABEL.normal.textColor = Color.red;
                  status = "DEAD";
                  this.vessel = null;
                  break;
               case ProtoCrewMember.RosterStatus.Available:
                  STYLE_STATUS_LABEL.normal.textColor = Color.green;
                  status = "AVAILABLE";
                  this.vessel = null;
                  break;
               case ProtoCrewMember.RosterStatus.Assigned:
                  STYLE_STATUS_LABEL.normal.textColor = Color.blue;
                  status = "MISSION";
                  break;
            }
            GUILayout.Label(status, STYLE_STATUS_LABEL);
         }

         private void DrawVessel(ProtoCrewMember kerbal)
         {
            if( GUILayout.Button(vessel!=null?vessel.GetName():"Not in a vessel", STYLE_LOCATION_LABEL))
            {
               if(vessel!=null && HighLogic.LoadedSceneIsFlight) FlightGlobals.ForceSetActiveVessel(vessel);
            }
         }

         private void DrawSituation(ProtoCrewMember kerbal)
         {
            switch(kerbal.rosterStatus)
            {
               case ProtoCrewMember.RosterStatus.Missing:
               case ProtoCrewMember.RosterStatus.Dead:
               case ProtoCrewMember.RosterStatus.Available:
                  GUILayout.Button("Not on EVA", STYLE_LOCATION_LABEL);
                 break;
               case ProtoCrewMember.RosterStatus.Assigned:
                  if(vessel == null)
                  {
                     GUILayout.Button("Not in a vessel", STYLE_LOCATION_LABEL);
                  }
                  else
                  {
                     if(vessel.isEVA)
                     {
                        GUILayout.Button("EVA", STYLE_LOCATION_LABEL);
                     }
                     else
                     {
                        switch(vessel.situation)
                        {
                           case Vessel.Situations.DOCKED: GUILayout.Button("DOCKED", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.ESCAPING: GUILayout.Button("ESCAPING", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.FLYING: GUILayout.Button("FLYING", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.LANDED: GUILayout.Button("LANDED", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.ORBITING: GUILayout.Button("ORBITING", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.PRELAUNCH: GUILayout.Button("PRELAUNCH", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.SPLASHED: GUILayout.Button("SPLASHED", STYLE_LOCATION_LABEL); break;
                           case Vessel.Situations.SUB_ORBITAL: GUILayout.Button("SUB_ORBITAL", STYLE_LOCATION_LABEL); break;
                        }
                     }
                  }
                  break;
            }
         }


         private void DrawLocation(ProtoCrewMember kerbal)
         {
            String location = "no kerbal selected";
            if(kerbal != null)
            {
               if(kerbal.rosterStatus==ProtoCrewMember.RosterStatus.Dead || kerbal.rosterStatus==ProtoCrewMember.RosterStatus.Missing)
               {
                  location = "Graveyard";
               }
               else if (kerbal.rosterStatus==ProtoCrewMember.RosterStatus.Available)
               {
                  location = "Kerbin Spacecenter";
               }
               else if(vessel!=null)
               {
                  location = vessel.mainBody.GetName();
               }
               else
               {
                  location = "Unknown location";
               }

            }
            GUILayout.Label(location, STYLE_LOCATION_LABEL);
         }

         public override int GetInitialWidth()
         {
            return WIDTH;
         }

         public void SetEntry(HallOfFameEntry entry)
         {
            this.entry = entry;
            if (entry != null)
            {
               this.vessel = entry.GetKerbal().GetVessel();
            }
            else
            {
               this.vessel = null;
            }
         }
      }
   }
}