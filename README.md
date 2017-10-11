
# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs
CC BY-NC-ND

# Now on CKAN!

# Changelog:
## v1.5.3

* Update for 1.3.1
* GPP_Secondary optimization
  * GPP no longer steals OPM if secondary is active.
  * Reduced the need for GPP_Secondary itself when GPP is installed with KSS or GN.
  * Ensured that actual Gael will appear for KSS or GN, and not a Kerbin clone.
  * Grannus looks more like a star.

TO INSTALL:

1. Begin with an installation of KSP version 1.3.1, running in 64-bit.

2. If reusing an existing install, empty the GameData folder of all contents but for the folder [KSP]\GameData\Squad\.  If starting with an entirely new install, is it recommended that you run once with no mods installed before proceeding.

3. Download the third-party mod [Kopernicus](https://github.com/Kopernicus/Kopernicus/releases/).  The Kopernicus version number must match the KSP version number, i.e. 1.3.1-x

4. Install by copying from [Kopernicus Download]\GameData\ to [KSP]\GameData\ the following folders and files:  
   * Kopernicus\
   * ModularFlightIntergrator\
   * ModuleManager.2.8.1.dll

5. Download Galileo’s Planet Pack 1.5.3

6. Copy from [GPP Download]\GameData\ to [KSP]\GameData\ the folder GPP\ and all its contents.

7. Download [GPP_Textures](https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/3.0.0).

8. Copy from [Textures Download]\GameData\GPP\ to [KSP]\GameData\GPP\ the folder GPP_Textures\.

9. This completes the basic installation.  If you want to, you can verify the installation by launching KSP.

## __All terrain scatter (scenery like trees and rocks) is not working due to a bug in Kopernicus. When the next version of Kopernicus is released, it will fix this issue.__

## Optional Mods

1. Install the optional mods of your choice by copying or merging [GPP Download]\Optional Mods\GPP_[mod name]\GameData\[mod name] to [KSP]\GameData\.

2. KSC Switcher and Loading Screen are the complete mod, no other action beyond step 1 is required.

3. [Final Frontier](https://spacedock.info/mod/580/Final%20Frontier) and [Texture Replacer](https://github.com/RangeMachine/TextureReplacer/releases/) must be downloaded and installed separately, and merged with the GPP-specific elements.

4. For GPP_Clouds and GPP_Secondary, see separate instructions below.

## KSC ++

1. For an extension to the Kerbal Space Center (fuel tanks, roads, cars, trees, the whole shebang), the third-party mod [Kerbal Konstructs](https://github.com/GER-Space/Kerbal-Konstructs/releases) must be downloaded and installed. Use the latest version developed for 1.3.1.

## Clouds, Aurorae and Shadows

1. For clouds, aurorae and shadows, go to [GPP Download]\Optional Mods\GPP_Clouds\ and select either High-res or Low-res.  Drill down further until you get to a second GPP_Clouds\ folder.  Copy this folder to [KSP]\GameData\GPP\.

2. To enable the visual effects, the third-party mod [EVE (Environmental Visual Enhancements)](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases) must be downloaded and installed.  You require only the small file, not the large one with “Configs” in its name (GPP comes with its own configs).

## Scatterer

1. GPP is configured to provide atmospheric scattering effects using the third-party mod Scatterer.  To enable these effects, download and install [Scatterer](https://spacedock.info/mod/141/scatterer).

2. If you want to change the sunflare for either or both stars in GPP, the images and .cfg files are in the folder,  GPP\GPP_Scatterer\Sunflares\ [Star]\.

## GPP Secondary

This new addon mod makes GPP into a distant non-primary system, allowing users to keep Kerbin and the stock planets, and set the Ciro system (GPP's main star) and Gael (not a Kerbin clone named Gael) as the mid-game or end-game. To be fully compatible with GPP one of the following must occur:

1. If the other planet pack is large and also replaces the stock solar system it must include a patch to reposition Ciro.

2. If the other planet pack only adds planets, the option exists to place itself around Grannus and be mindful of its asteroid field. [Ciro orbit] realistically is already well occupied by GPP's own planets.

Kerbol Star System is not fully supported as it is currently known to have a colliding GPP compatibility patch. Do not use GPP Secondary with Galactic Neighborhood.

To install, just place GPP_Secondary\ into GameData\ so it looks like this:
  * GPP\
  * GPP_Secondary\
  * Kopernicus\
  * ModularFlightIntegrator\
  * ModuleManager.2.8.1.dll

## Kerbal Renamer (WIP)

Kerbal Renamer is a new feature that renames all new and existing kerbals from "Kerman" to "Gaelan." It has a toggle (the first line) within GPP\GPP_Renamer\Renamer.cfg that can be set to keep Jebediah and company (the original 4) or to replace them with GPP's developers. It is best to change the setting before starting a save. It is a WIP and will likely have a few bugs. 

To toggle, change the following setting *preserveOriginals = true* to *false.*

## Scaled Versions

GPP's own configs for Sigma Dimensions have been discontinued and removed. To upscale GPP, see [Rescale! Comprehensive SD Configs](http://forum.kerbalspaceprogram.com/index.php?/topic/163965-13-rescale-comprehensive-sd-configs-1021/).


**Recommended mods with support for or by GPP**
  * Environmental Visual Enhancements - min-version: 1.2.2-1
  * Scatterer - min-version: 0.0320b
  * TextureReplacer _GPP still uses the original TextureReplacer. Use RangeMachines version linked in the TextureReplacer OP_
  * Distant Object Enhancement
  * PlanetShine
  * JX2 Large Antenna
  * Strategia
  * Near Future Technologies
  * Far Future Technologies
  * USI Constellation
  * MechJeb
  * Airline Kuisine
  * RemoteTech
  * Tarsier Space Technologies
  * ResearchBodies
  * Waypoint Manager
  * Decal Stickers
  * BlueDog Design Bureau (balanced optimally at 2.5x scale)

## Known Issues
* The following bodies no longer have volumetric clouds (including sand storms) due to a bug with scatterer causing them to turn black. They will return:

  * Catullus
  * Augustus and Gratian have an alternate particle effect in lieu.

* Clouds do not show up in main menu. Just a small bug with EVE and Kopernicus. Not a big deal. Nothing is broken.

* When not using Environmental Visual Enhancements, Nero will display axial precession. In future updates we may detect if EVE is installed and fix accordingly.

* Scatterer's effects do not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is broken. A quick scene change will fix this.

* Running game in dx11 causes terrain textures to be pinstriped.

* Orbit lines jump around when zoomed out to outer planets in map view and tracking station. It's stock bug made more noticeable by Kopernicus.


## Bundled Licenses

**These mods and/or assets are distributed by their own license terms, included in each mod's folder**

"KSCFloodlight"
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

"KSC++"
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

"SuitProgression"
Attribution-NonCommercial-ShareAlike 3.0 International (CC BY-NC-SA 3.0)

"GPP_Renamer"
Simplified BSD License (BSD 2-clause)
