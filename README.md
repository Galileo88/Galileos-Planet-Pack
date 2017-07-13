CASUAL PLAYERS: DO NOT DOWNLOAD FROM HERE. ONLY DOWNLOAD FROM THE [RELEASES PAGE](https://github.com/Galileo88/Galileos-Planet-Pack/releases). THE DEV VERSION IS NOT RELEASE-READY AND WILL DO MORE HARM THAN GOOD TO YOUR PLAYTHROUGH.


# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs 
CC BY-NC-ND 


TO INSTALL:

1. Create a fresh install of KSP version 1.3.0.  Ensure that KSP always launches in 64-bit.  Run once with no mods installed.
 
2. Download the third-party mod [Kopernicus](https://github.com/Kopernicus/Kopernicus/releases/).  The Kopernicus version number must match the KSP version number, i.e. 1.3.0.
 
3. Install by copying from [Kopernicus Download]\GameData\ to [KSP]\GameData\ the following folders and files:  
   * Kopernicus\ 
   * ModularFlightIntergrator\ 
   * ModuleManager.2.8.0.dll
 
4. Download Galileo’s Planet Pack 1.4.0.
 
5. Copy from [GPP Download]\GameData\ to [KSP]\GameData\ the folder GPP\ and all its contents. 
 
6. Download [GPP_Textures](https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/1.0).
 
7. Copy from [Textures Download]\GameData\GPP\ to [KSP]\GameData\GPP\ the folder GPP_Textures\.

8. Run once in this configuration before installing additional mods

## Optional Mods

1. Install the mods of your choice – Final Frontier, KSC Switcher, Texture Replacer – by copying [GPP Download]\Optional Mods\GPP_[mod name]\ to [KSP]\GameData\.

## KSC ++
 
1. For an extension to the Kerbal Space Center (fuel tanks, roads, cars, trees, the whole shebang), go to [GPP Download]\Optional Mods\KSCPlusPlus and copy this folder to [KSP]\GameData\.
 
2. To enable the improved KSC, the third-party mod [Kerbal Konstructs](https://github.com/GER-Space/Kerbal-Konstructs/releases) must be downloaded and installed.

## Clouds, Aurorae and Shadows
 
1. For clouds, aurorae and shadows, go to [GPP Download]\Optional Mods\GPP_Clouds\ and select either High-res or Low-res.  Drill down further until you get to a second GPP_Clouds\ folder.  Copy this folder to [KSP]\GameData\GPP\.
 
2. To enable the visual effects, the third-party mod [EVE (Environmental Visual Enhancements)](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases) must be downloaded and installed.  You require only the small file, not the large one with “Configs” in its name (GPP comes with its own configs).

## Scatterer

1. GPP is configured to provide atmospheric scattering effects using the third-party mod Scatterer.  To enable these effects, download and install [Scatterer](https://spacedock.info/mod/141/scatterer).
 
2. If you want to change the sunflare for either or both stars in GPP, the images and .cfg files are in the folder,  GPP\GPP_Scatterer\Sunflares\[Star]\.

## Scaled Versions

1. In addition to the stock-sized version, GPP comes with the configs needed to play at five enlarged scales.  To use, just copy the .cfg file for your choice of scale from [GPP Download]\Optional Mods\Rescale!\ to anywhere within the [KSP]\GameData\ folder.
 
2. To enable the use of the rescaled versions, it is necessary that you download and install the third-party mod [Sigma Dimensions](https://github.com/Sigma88/Sigma-Dimensions/releases/).
 
3. To modify the game clock and calendar to match the length of the Gael day and year, download and install the third-party mod [Kronometer](https://github.com/StollD/Kronometer/releases/).
 
 
**Recommended mods with support for or by GPP**
  * Environmental Visual Enhancements - min-version: 1.2-2
  * Scatterer - min-version: 0.0300
  * TextureReplacer
  * Distant Object Enhancements 
  * PlanetShine
  * JX2 Large Antenna
  * Kerbalism (Not updated to work with the latest Kopernicus)
  * Strategia
  * RemoteTech
  * MechJeb
  * ResearchBodies
  * Waypoint Manager
  * Decal Stickers
  * USI Constellation


# Changelog:
## v1.4.0

* Overall compatibility with KSP 1.3 and Kopernicus v1.3.0-2+.

  * Lots of PQS and other terrain work.
  
  * Updated EVE visuals too. Check the gas giants.
  
  * Bundled mods also made 1.3-compatible: KSC Switcher.
  
  * Removed FinalFrontier itself but kept our ribbons for it. Final Frontier now must be installed separately.

* Added full support for Kronometer, successor of KopernicusTime.

* Added Localizaion support. Currently only English is available.

* KSC++ is now built into the main GPP directory, and only requires an install of Kerbal Konstructs. With this, other features will also appear.
  
* Kopernicus Expansion Footprint compatibility.

* Removed LoadingScreenManager (mod aborted by its author).
  
  * (WIP) Restore LoadingScreenManager.

* Strategia updates.
  
  * More realistic strategies. No more "cheat" strategies that take the challenge out of GPP.

* Removed GPP_CareerSaver.

* Created GPP_Secondary (see Optional Mods\ folder) for perfect compatibility with other star system mods (such as Kerbol Star System or Galactic Neighborhood) or just to have Stock + GPP.

  * Any other replacement primary system just needs to reposition Ciro.
  
* Created "SuitProgression" upgradeable heat tolerance for EVA kerbals.

  * Each time you ugrade the astronaut complex, the max temperature for a kerbal goes up by 400k, maxing at 1600K.

* Repaired and restored custom science for Gael and its moons.

* (WIP) Updated ResearchBodies support and added science for its sibling, Tarsier Space Technologies.

* (WIP) Scatterer support for KSP 1.3. The ocean shaders have been disabled to prevent the floating tile bug.

* (WIP) Added patch to change LqdAmmonia distributions to Ammonia if Kerbalism is present.



## Known Issues
 
* Clouds do not show up in main menu. Just a small bug with Kopernicus. not a big deal. Nothing is broken.

* Scatterer does not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is broken.

* Running game in dx11 causes terrain textures to be pinstriped.

* Orbit lines jump around when zoomed out to outer planets in map view and tracking station. It's stock bug made more noticeable by Kopernicus

* Kerbal Konstructs/KSC++ do not scale with Sigma Dimensions. Statics spread apart. A fix is coming.

* Kerbalism does not support multiple stars. Solar panels will not work around Grannus. It is not up to us to fix that.

## Bundle Licenses

**These mods and/or assets are distributed by their own license terms, included in each mod's folder**
 
"KSCFloodlight"
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License

"KSC++"
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
