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
 
8. If you want to preserve a career game from a previous GPP installation, install [GPP Download]\GPP_CareerSaver\ to [KSP]\GameData\.

9. Run once in this configuration before installing additional mods

## Optional Mods

1. Install the mods of your choice – Final Frontier, Kerbal Konstructs, KSC Switcher, Texture Replacer – by copying [GPP Download]\Optional Mods\GPP_[mod name]\ to [KSP]\GameData\.
 
2. For clouds, aurorae and shadows, go to [GPP Download]\Optional Mods\GPP_Clouds\ and select either High-res or Low-res.  Drill down further until you get to a second GPP_Clouds\ folder.  Copy this folder to [KSP]\GameData\GPP\.
 
3. To enable the visual effects in step 2, the third-party mod [EVE (Environmental Visual Enhancements)](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases) must be downloaded and installed.  You require only the small file, not the large one with “Configs” in its name (GPP comes with its own configs).

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
  * Kerbalism
  * Strategia
  * RemoteTech
  * MechJeb
  * ResearchBodies
  * Waypoint Manager
  * Decal Stickers
  * USI Constellation


# Changelog:
## v1.4.0

* Overall compatibility with KSP 1.3 and Kopernicus v1.3.0-2. (This biggest horse in the stable)

  * Bundled mods also made 1.3-compatible: KSC Switcher

* Added full support for Kronometer, successor of KopernicusTime

* Created "SuitProgression" upgradeable heat tolerance for EVA kerbals.

* Removed LoadingScreen (mod aborted by its author).

* Created GPP_Secondary for perfect compatibility with other star system mods or just to have Stock + GPP.

* Repaired and restored custom science for Gael and its moons.


## Known Issues
 
* Clouds do not show up in main menu. Just a small bug with Kopernicus. not a big deal. Nothing is broken.

* Scatterer does not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is boken.

* Running game in dx11 causes terrain textures to be pinstriped.

* Orbit lines jump around when zoomed out to outer planets in map view and tracking station. Its stock bug made more noticeable by Kopernicus

* Kerbal Konstructs/KSC++ do not scale with Sigma Dimensions. Statics spread apart. A fix is coming.

* Any Decal Stickers parts with stock flags set in them revert to GPP flags on launch or on reload within the SPH/VAB.

## Bundle Licenses

**These mods and/or assets are distributed by their own license terms, included in each mod's folder**

"Final Frontier"
Copyright (c) 2014, André Kolster (Nereid)
 All rights reserved.

"Kerbal Konstructs Plugin"
The MIT License (MIT)

"KSCFloodlight"
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License

"KSC++"
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
