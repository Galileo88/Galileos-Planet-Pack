using System;
using UnityEngine;

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
    [KSPAddon(KSPAddon.Startup.EveryScene, false)]
    public class CameraFixer : MonoBehaviour {
        public static bool ready = false;
        public static bool hasKopernicus = false;
        public static bool foundKopernicus = false;

        public static bool FoundKopernicus() {
            foreach(AssemblyLoader.LoadedAssembly a in AssemblyLoader.loadedAssemblies) {
                if(a.assembly.GetName().Name.ToLowerInvariant().Contains("kopernicus")) {
                    return true;
				}
			}

            return false;
        }

        public void Start() {
            if(!foundKopernicus) {
                hasKopernicus = FoundKopernicus();
                foundKopernicus = true;
            }

            if(hasKopernicus) { return; }
            if(HighLogic.LoadedScene.Equals(GameScenes.MAINMENU)) { ready = true; }
            if(!ready) { return; }

            if(HighLogic.LoadedScene == GameScenes.SPACECENTER) {
                PQSCity ksc = null;
                foreach(PQSCity city in Resources.FindObjectsOfTypeAll(typeof(PQSCity))) {
                    if(city.name == "KSC") {
                        ksc = city;
                        break;
                    }
                }
                if(ksc == null) {
                    Debug.Log("KSCSwitcher could not find KSC to fix the camera.");
                    return;
                }
                foreach(SpaceCenterCamera2 cam in Resources.FindObjectsOfTypeAll(typeof(SpaceCenterCamera2))) {
                    if(ksc.repositionToSphere || ksc.repositionToSphereSurface) {
                        CelestialBody Kerbin = FlightGlobals.Bodies.Find(body => body.name == ksc.sphere.name);
                        if(Kerbin == null) {
                            Debug.Log("KSCSwitcher could not find find the CelestialBody specified as KSC's sphere.");
                            return;
                        }
                        double nomHeight = Kerbin.pqsController.GetSurfaceHeight((Vector3d) ksc.repositionRadial.normalized) - Kerbin.Radius;
                        if(ksc.repositionToSphereSurface) {
                            nomHeight += ksc.repositionRadiusOffset;
                        }
                        cam.altitudeInitial = 0f - (float) nomHeight;
                    } else {
                        cam.altitudeInitial = 0f - (float) ksc.repositionRadiusOffset;
                    }
                    cam.ResetCamera();
                    Debug.Log("KSCSwitcher fixed the Space Center camera.");
                }
            }
        }
	}
}
