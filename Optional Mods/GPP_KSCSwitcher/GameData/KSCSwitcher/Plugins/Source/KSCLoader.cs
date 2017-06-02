using System;
using System.Collections.Generic;
using UnityEngine;
using KSP;

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
	// provides a simple method for different classes to load, manage, and read the launch sites.
	public class KSCSiteManager {
        public List<ConfigNode> Sites;
		public string defaultSite = "";
		public string lastSite = "";
		
		public KSCSiteManager() {
            Sites = new List<ConfigNode>();
			ConfigNode KSCSettings = null;

			foreach(ConfigNode node in GameDatabase.Instance.GetConfigNodes("KSCSWITCHER")) {
                KSCSettings = node;
			}
            if(KSCSettings == null) {
                throw new UnityException("KSCSwitcher KSCSWITCHER config node not found!");
			}

            if(KSCSettings.HasValue("DefaultSite")) {
				defaultSite = KSCSettings.GetValue("DefaultSite");
			}
            if(KSCSettings.HasNode("LaunchSites")) {
                ConfigNode node = KSCSettings.GetNode("LaunchSites");
                ConfigNode[] sites = node.GetNodes("Site");

                foreach (ConfigNode site in sites) {
                    if (site.HasValue("name")) {
                        ConfigNode pqsCity = site.GetNode("PQSCity");
                        if(pqsCity == null) { continue; }
                        if(pqsCity.HasValue("latitude") && pqsCity.HasValue("longitude")) {
                            Sites.Add(site);
                        }
                    }
                }
            } else {
                Debug.Log("KSCSwitcher No LaunchSites node found!");
			}
			
			Debug.Log("KSCSwitcher loaded " + Sites.Count + " launch sites.");
		}
		
		public ConfigNode getSiteByName(string name) {
            foreach(ConfigNode site in Sites) {
                if(site.HasValue("name")) {
                    if(site.GetValue("name").Equals(name)) {
                        return site;
                    }
                }
            }
            return null;
		}
		
		public SortedList<string, LaunchSite> getSitesGeographicalList() {
			SortedList<string, LaunchSite> siteLocations = new SortedList<string, LaunchSite>();
            double lat, lon, dtmp;

			foreach(ConfigNode site in KSCLoader.instance.Sites.Sites) {
				ConfigNode pqsCity = site.GetNode("PQSCity");
				LaunchSite temp = new LaunchSite();
				temp.name = site.GetValue("name");
				temp.displayName = site.GetValue("displayName");
				double.TryParse(pqsCity.GetValue("latitude"), out lat);
                double.TryParse(pqsCity.GetValue("longitude"), out lon);
				temp.geographicLocation = new Vector2d(lat, lon);
                if(site.HasValue("description")) {
					temp.description = site.GetValue("description");
				}
                if(site.HasValue("PQSName")) {
					temp.description = site.GetValue("PQSName");
				} else {
					temp.PQSName = "Kerbin";
				}
				if(site.HasValue("availableFromUT")) {
            		if(double.TryParse(site.GetValue("availableFromUT"), out dtmp)) {
						temp.availableFromUT = dtmp;
					}
				}
				if(site.HasValue("availableUntilUT")) {
            		if(double.TryParse(site.GetValue("availableUntilUT"), out dtmp)) {
						temp.availableUntilUT = dtmp;
					}
				}
				siteLocations.Add(temp.name, temp);
			}
			
			return siteLocations;
		}
	}

}
