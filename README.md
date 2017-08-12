
# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs
CC BY-NC-ND


TO INSTALL:

1. Create a fresh install of KSP version 1.3.0.  Ensure that KSP always launches in 64-bit.  Run once with no mods installed.

2. Download the third-party mod [Kopernicus](https://github.com/Kopernicus/Kopernicus/releases/).  The Kopernicus version number must match the KSP version number, i.e. 1.3.0.

3. Install by copying from [Kopernicus Download]\GameData\ to [KSP]\GameData\ the following folders and files:  
   * Kopernicus\
   * ModularFlightIntergrator\
   * ModuleManager.2.8.1.dll

4. Download Galileo’s Planet Pack 1.4.0.

5. Copy from [GPP Download]\GameData\ to [KSP]\GameData\ the folder GPP\ and all its contents.

6. Download [GPP_Textures](https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/2.0.0).

7. Copy from [Textures Download]\GameData\GPP\ to [KSP]\GameData\GPP\ the folder GPP_Textures\.

8. Run once in this configuration before installing additional mods

## __All terrain scatter (scenery like trees and rocks) is not working due to a bug in Kopernicus. When the next version of Kopernicus is released, it will fix this issue.__

## Optional Mods

1. Install the mods of your choice – Final Frontier, KSC Switcher, Texture Replacer – by copying [GPP Download]\Optional Mods\GPP_[mod name]\ to [KSP]\GameData\.

## KSC ++

1. For an extension to the Kerbal Space Center (fuel tanks, roads, cars, trees, the whole shebang), the third-party mod [Kerbal Konstructs](https://github.com/GER-Space/Kerbal-Konstructs/releases) must be downloaded and installed.

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

Kerbol Star System is not fully supported as it is currently known to have a colliding GPP compatibility ptch. Do not use GPP Secondary with Galactic Neighborhood.

To install, just place GPP_Secondary\ into GameData\ so it looks like this:
  * GPP\
  * GPP_Secondary\
  * Kopernicus\
  * ModularFlightIntegrator\
  * ModuleManager.2.8.1.dll

## Kerbal Renamer

Kerbal Renamer is a new feature that renames all new and existing kerbals from "Kerman" to "Gaelan." It has a toggle (the first line) within GPP\GPP_Renamer\Renamer.cfg that can be set to keep Jebediah and company (the original 4) or to replace them with GPP's developers. It is best to change the setting before starting a save.

To toggle, change the following setting *preserveOriginals = true* to *false.*

## Scaled Versions

GPP's own configs for Sigma Dimensions have been discontinued and removed. To upscale GPP, see [Rescale! Comprehensive SD Configs](http://forum.kerbalspaceprogram.com/index.php?/topic/163965-13-rescale-comprehensive-sd-configs-1021/).


**Recommended mods with support for or by GPP**
  * Environmental Visual Enhancements - min-version: 1.2-2
  * Scatterer - min-version: 0.0320
  * TextureReplacer _GPP still uses the original TextureReplacer. Use RangeMachines verion_
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
  * Kerbalism
  * Tarsier Space Technologies
  * ResearchBodies
  * Waypoint Manager
  * Decal Stickers
  * BlueDog Design Bureau (balanced optimally at 2.5x scale)


# Changelog:
## v1.4.0

* Overall compatibility with KSP 1.3 and Kopernicus v1.3.0-2+.

  * Lots of PQS and other terrain work.

  * Updated EVE visuals too. Check the gas giants.

  * Bundled mods also made 1.3-compatible: KSC Switcher.

  * Removed FinalFrontier itself but kept our ribbons for it. Final Frontier now must be installed separately.

* Added full support for Kronometer, successor of KopernicusTime.

* Added Localizaion support. Currently only English is available.

* Added Kerbal Renamer. All newly created kerbals will carry the surname Gaelan instead of Kerman, and references to "Kerbal" have been changed to "Gaelean" wherever possible.

* KSC++ is now built into the main GPP directory, and only requires an install of Kerbal Konstructs. With this, other features will also appear.

* Kopernicus Expansion Footprint compatibility.

* Updated LoadingScreenManager. New screenshots, new tips.

* Updated default sunflares.

* Strategia updates.

  * More realistic strategies. No more "cheat" strategies that take the challenge out of GPP.

* Removed GPP_CareerSaver.

* Removed Rescale! folder. To upscale GPP, see [Rescale! Comprehensive SD Configs](http://forum.kerbalspaceprogram.com/index.php?/topic/163965-13-rescale-comprehensive-sd-configs-1021/).

* Created GPP_Secondary (see Optional Mods\ folder) for seamless loading of GPP alongside Stock and/or other star system mods. Visual pack interoperability is not handled and not promised.

  * Any other replacement primary system just needs to reposition Ciro.

  * Do not use with Galactic Neighborhood.

* Created "SuitProgression" upgradeable heat tolerance for EVA kerbals.

  * Each time you ugrade the astronaut complex, the max temperature for a kerbal goes up by 400k, maxing at 1600K.

* Repaired and restored custom science for Gael and its moons.

* Updated ResearchBodies support and added science definitions for its sibling, Tarsier Space Technologies.

* Scatterer support for KSP 1.3.

  * Disabled volumetric clouds on Catullus due to scatterer or EVE bug.

* Added patch to change LqdAmmonia distributions to Ammonia if Kerbalism is present.



## Known Issues
* Catullus does not have volumetric clouds due to a bug with scatterer causing them to turn black. They will return. 
  * Gratian and Augustus no longer have dust storms due to the same issue as stated above

* Clouds do not show up in main menu. Just a small bug with Kopernicus. not a big deal. Nothing is broken.

* Scatterer does not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is broken.

* Running game in dx11 causes terrain textures to be pinstriped.

* Orbit lines jump around when zoomed out to outer planets in map view and tracking station. It's stock bug made more noticeable by Kopernicus

* Kerbal Konstructs/KSC++ do not scale with Sigma Dimensions. Statics spread apart. A fix is coming.

* Kerbalism does not support multiple stars. Solar panels will not work around Grannus. It is not up to us to fix that.

* All terrain scatter (scenery like trees and rocks) is not working due to a bug in Kopernicus. When the next version of Kopernicus is released, it will fix this issue.

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
