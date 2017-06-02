using System;
using UnityEngine;
using KSP;
using System.Linq;

/******************************************************************************
 * Copyright (c) 2014~2016, Justin Bengtson
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met: 
 * 
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/

namespace regexKSP {
	// Taniwha graciously offered the use of this code/method for saving our settings per save game.
	// I've changed where appropriate and reformatted because of 1TBS.
	public class LastKSC : ScenarioModule {
		public string lastSite = "";
		private static LastKSC instance;
		
		public static LastKSC fetch {
			get {
				if(instance == null) {
					Game g = HighLogic.CurrentGame;
					instance = g.scenarios.Select(s => s.moduleRef).OfType<LastKSC>().SingleOrDefault();
				}
				return instance;
			}
		}
		
		public override void OnLoad(ConfigNode config) {
			if(config.HasValue("LastLaunchSite")) {
				lastSite = config.GetValue("LastLaunchSite");
			}
			if(lastSite.Length > 0) {
				KSCLoader.instance.Sites.lastSite = lastSite;
			}
/*
			if(HighLogic.LoadedScene == GameScenes.TRACKSTATION) {
				KSCSwitcher.activeSite = lastSite;
			}
*/
		}
		
		public override void OnSave(ConfigNode config) {
			config.AddValue("LastLaunchSite", lastSite);
		}

		public static void CreateSettings(Game game) {
			if(!game.scenarios.Any(p=>p.moduleName == typeof(LastKSC).Name)) {
				ProtoScenarioModule proto = game.AddProtoScenarioModule(typeof (LastKSC), GameScenes.TRACKSTATION);
				proto.Load(ScenarioRunner.Instance);
			}
		}
	}

	public class KSCLoader {
		public static KSCLoader instance = null;
		public KSCSiteManager Sites = new KSCSiteManager();

		void onGameStateCreated(Game game) {
			LastKSC.CreateSettings(game);
			bool noSite = false;
			if(HighLogic.LoadedScene == GameScenes.SPACECENTER) {
				foreach(ProtoScenarioModule m in HighLogic.CurrentGame.scenarios) {
					if(m.moduleName == "LastKSC") {
						LastKSC l = (LastKSC) m.Load(ScenarioRunner.Instance);
						if(l.lastSite.Length > 0) {
							// found a site, load it
							ConfigNode site = Sites.getSiteByName(l.lastSite);
				            if(site == null) {
								l.lastSite = Sites.defaultSite;
								noSite = true;
							} else {
								KSCSwitcher.setSite(site);
								Debug.Log("KSCSwitcher set the launch site to " + l.lastSite);
								return;
							}
						} else {
							l.lastSite = Sites.defaultSite;
							noSite = true;
						}
						if(noSite) {
							if(Sites.defaultSite.Length > 0) {
								ConfigNode site = Sites.getSiteByName(Sites.defaultSite);
					            if(site == null) {
									Debug.LogError("KSCSwitcher found a default site name but could not retrieve the site config: " + Sites.defaultSite);
									return;
								} else {
									KSCSwitcher.setSite(site);
									Debug.Log("KSCSwitcher set the initial launch site to " + Sites.defaultSite);
								}
							}
						}
					}
				}
			}
		}

		public KSCLoader() {
			GameEvents.onGameStateCreated.Add(onGameStateCreated);
		}
	}

	[KSPAddon(KSPAddon.Startup.MainMenu, false)]
	public class ScenarioSpawn : MonoBehaviour {
		void Start() {
            if((object)(KSCLoader.instance) == null) {
                KSCLoader.instance = new KSCLoader();
			}
            enabled = false;
		}
	}
}
