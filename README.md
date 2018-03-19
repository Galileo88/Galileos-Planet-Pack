
# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs
CC BY-NC-ND

# Now on CKAN!

# Changelog:
## v1.6.2.0 Aesthetic Pass
## REQUIRES GPP_TEXTURES 4.1.0
* Adds support for FlareReplacer
* Implememts EVE atmospheres when Scatterer is not installed
* Added Custom KS3P configuration
* Added artistic twist to loading screens
* Updated Scatterer for softer edges of atmospheres
* Fixed squiggly line in the sky due to Aurora texture gaffe
* Better noise of gas giants, bring the textures to life
* Added GPP Clouds support for OPM when OPMVO is not installed
* Fixed erroneous biome entries in body and resource configs
* GPP KSC Switcher no longer activates if GPP Secondary is installed
* Classic Stock resource system


## TO INSTALL:

1. Begin with an installation of KSP version 1.3.1, running in 64-bit.

2. If reusing an existing install, empty the GameData folder of all contents but for the folder [KSP]\GameData\Squad\.  If starting with an entirely new install, is it recommended that you run once with no mods installed before proceeding.

3. Download the third party mod [Kopernicus](https://github.com/Kopernicus/Kopernicus/releases/).  The Kopernicus version number must match the KSP version number, i.e. 1.3.1-x

4. Install by copying from [Kopernicus Download]\GameData\ to [KSP]\GameData\ the following folders and files:  
   * Kopernicus\
   * ModularFlightIntergrator\
   * ModuleManager.3.0.4.dll

5. Download Galileo’s Planet Pack 1.6.2.0

6. Copy from [GPP Download]\GameData\ to [KSP]\GameData\ the folder GPP\ and all its contents.

7. Download [GPP_Textures](https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/4.1.0).

8. Copy from [Textures Download]\GameData\GPP\ to [KSP]\GameData\GPP\ the folder GPP_Textures\.

9. This completes the basic installation.  If you want to, you can verify the installation by launching KSP.

## Optional Mods

1. Install the optional mods of your choice by copying or merging [GPP Download]\Optional Mods\GPP_[mod name]\GameData\[mod name] to [KSP]\GameData\.

2. KSC Switcher is the complete mod, no other action beyond step 1 is required.

3. [Final Frontier](https://spacedock.info/mod/580/Final%20Frontier/download/1.3.6-3189) must be downloaded and installed separately.

4. For GPP_Clouds and GPP_Secondary, see separate instructions below.

## KSC ++

1. For an extension to the Kerbal Space Center (fuel tanks, roads, cars, trees, the whole shebang), the third-party mod [Kerbal Konstructs](https://github.com/GER-Space/Kerbal-Konstructs/releases) must be downloaded and installed. Use the latest version developed for 1.3.1.

2. If KSC++ in used combination with a one of the scaled versions of GPP, [KKtoSD](https://forum.kerbalspaceprogram.com/index.php?/topic/162782-wip130-kktosd/) must be downloaded and installed.

## Sigma Replacements

1. To use GPP's high quality Gaelan heads, suits, navball and Skybox install Sigma Replacements [Links Here](https://github.com/Galileo88/Galileos-Planet-Pack#recommended-mods-with-support-for-or-by-gpp).

## Clouds, Aurorae and Shadows

1. For clouds, aurorae and shadows, go to [GPP Download]\Optional Mods\GPP_Clouds\ and select either High-res or Low-res.  Drill down further until you get to a second GPP_Clouds\ folder.  Copy this folder to [KSP]\GameData\GPP\.

2. To enable the visual effects, the third-party mod [EVE (Environmental Visual Enhancements)](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases/tag/EVE-1.2.2-1) must be downloaded and installed.  You require only the small file, not the large one with “Configs” in its name (GPP comes with its own configs).

## Scatterer

1. GPP is configured to provide atmospheric scattering effects using the third-party mod Scatterer.  To enable these effects, download and install [Scatterer](https://spacedock.info/mod/141/scatterer/download/0.0324).

2. If you want to change the sunflare for either or both stars in GPP, the images and .cfg files are in the folder,  GPP\GPP_Scatterer\Sunflares\ [Star]\.

## Optional High(er) Performance Visuals

If your computer can't handle the performance hit of Scatterer, GPP is fully set up to work without it, using EVE to simulate the atmosphere effect. In addition to this, there are a few other mods that can give you nice looking oceans and sun flares all without Scatterer, and with great performance. Following these 5 steps, you can make your game look as good as if you had Scatterer installed.

1. Download and install [Better Looking Oceans](https://github.com/Galileo88/Better-Looking-Oceans/releases) provides a good, high performance alternate to Scatterer's ocean shader, and cover all bodies with oceans in GPP/GEP/OPM.

2. Download and install [Flare Replacer](https://forum.kerbalspaceprogram.com/index.php?/topic/171820-ksp-131-flare-replacer-v102-09-mar-2018/) replaces the stock sun flare a higher quality sun flare.

3. Download and install [KS3P](https://spacedock.info/mod/1618/KS3P) can provide some post processing effects that look great. A custom cfg for GPP is included in GPP.

4. Download and install [Minimum Ambient Lighting](https://spacedock.info/mod/448/Minimum%20Ambient%20Lighting) can make the dark side of the planets in flight as dark or as light as you would like with the ease of a slider in game.

5. Turn your [Ambient Light Boost: Map](https://i.imgur.com/vQK1aOW.jpg) down to about 90% or to your liking. [HERE](https://i.imgur.com/6IHAxwA.png) is an example.


## Classic Stock Resource System

This is an implementation of the unreleased stock resource library devised by **NovaSilisko, HarvesteR** and other early KSP developers, and delivered by Angel-125 and his Wild Blue Industries (WBI) mod suite. [Read about it here](https://github.com/Angel-125/Pathfinder/wiki/Classic-Stock-Play-Mode). It is an alternative to Community Resource Pack (CRP) and only activates if Classic Stock mode is selected at the WBI first run window in-game following a fresh install of the Pathfinder mod.

Mod compatibility with Classic Stock is entirely opt-in and is not to be expected to be readily available and provided by Wild Blue Industries.

## GPP Secondary

This addon mod makes GPP into a distant non-primary system, allowing users to keep Kerbin and the stock planets, and set the Ciro system (GPP's main star) and Gael (not a Kerbin clone named Gael) as the mid-game or end-game. To be fully compatible with GPP one of the following must occur:

1. If the other planet pack is large and also replaces the stock solar system it must include a patch to reposition Ciro.

2. If the other planet pack only adds planets, the option exists to place itself around Grannus and be mindful of its asteroid field. [Ciro orbit] realistically is already well occupied by GPP's own planets.

Kerbol Star System is not fully supported as it is currently known to have a colliding GPP compatibility patch. Do not use GPP Secondary with Galactic Neighborhood.

To install, just place GPP_Secondary\ into GameData\ so it looks like this:
  * GPP\
  * GPP_Secondary\
  * Kopernicus\
  * ModularFlightIntegrator\
  * ModuleManager.3.0.4.dll
  
## Grannus Expansion Pack (GEP)

Grannus Expansion Pack (GEP) is an expansion to Galileo’s Planet Pack (GPP) that adds planets and moons around the red dwarf star Grannus.  GEP is designed to work only when installed with GPP, it is not a standalone planet pack.

The current version of GEP is not yet complete, but most of the essential game elements are present.  It should be fully playable in its current state, though some mods may not yet be supported.

While GEP is separate from GPP, it has been developed with the endorsement and cooperation of the GPP team.  Special care has been taken to ensure that GEP integrates seamlessly with GPP.

For more information, download links and install instructions, visit the [GEP thread](https://forum.kerbalspaceprogram.com/index.php?/topic/169664-ksp-131-grannus-expansion-pack-v0800-16-jan-2018/).


## Kerbal Renamer

Kerbal Renamer is a new feature that renames all new and existing kerbals from "Kerman" to "Gaelan." It has a toggle (the first line) within GPP\GPP_Renamer\Renamer.cfg that can be set to keep Jebediah and company (the original 4) or to replace them with GPP's developers.

To toggle, change the following setting *preserveOriginals = true* to *false.*

## Scaled Versions

:triangular_ruler: To upscale GPP, see [Rescale! Comprehensive SD Configs](http://forum.kerbalspaceprogram.com/index.php?/topic/163965-13-rescale-comprehensive-sd-configs-1021/).

If one of the scaled versions of GPP is used in combinations with KSC++, the third-party mod [KKtoSD](https://forum.kerbalspaceprogram.com/index.php?/topic/162782-wip130-kktosd/) must be downloaded and installed.


## Recommended mods with support for or by GPP
  * [Grannus Expansion Pack (GEP)](https://github.com/OhioBob/Grannus-Expansion-Pack/releases)
  * Sigma Replacements
    * [Heads](https://github.com/Sigma88/Sigma-Replacements/releases/download/H_v0.2.1/Sigma-Replacements_Heads.v0.2.1.zip)
    * [Suits](https://github.com/Sigma88/Sigma-Replacements/releases/download/S_v0.2.1/Sigma-Replacements_Suits.v0.2.1.zip)
    * [Skybox](https://github.com/Sigma88/Sigma-Replacements/releases/download/B_v0.2.1/Sigma-Replacements_SkyBox.v0.2.1.zip)
    * [Navigation](https://github.com/Sigma88/Sigma-Replacements/releases/download/N_v0.2.1/Sigma-Replacements_Navigation.v0.2.1.zip)
    * [Descriptions](https://github.com/Sigma88/Sigma-Replacements/releases/download/D_v0.2.4/Sigma-Replacements_Descriptions.v0.2.4.zip)
  * [Environmental Visual Enhancements - min-version: 1.2.2-1](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases/tag/EVE-1.2.2-1)
  * [Better Looking Oceans](https://github.com/Galileo88/Better-Looking-Oceans/releases)
  * [Flare Replacer](https://forum.kerbalspaceprogram.com/index.php?/topic/171820-ksp-131-flare-replacer-v102-09-mar-2018/)
  * [KS3P](https://spacedock.info/mod/1618/KS3P)
  * [Scatterer - min-version: 0.0320b](https://spacedock.info/mod/141/scatterer/download/0.0324)
  * [Distant Object Enhancement](https://github.com/MOARdV/DistantObject/releases/)
  * [PlanetShine](https://www.curseforge.com/kerbal/ksp-mods/planetshine/download)
  * Wild Blue Industries
    * [Pathfinder](https://github.com/Angel-125/Pathfinder/releases)
    * [DSEV (Deep Space Exploration Vessels)](https://github.com/Angel-125/DSEV/releases)
  * [JX2 Large Antenna](https://spacedock.info/mod/1107/JX2Antenna/download/2.0.2)
  * [Strategia](https://github.com/jrossignol/Strategia/releases/download/1.6.0/Strategia_1.6.0.zip)
  * [Near Future Technologies](https://forum.kerbalspaceprogram.com/index.php?/topic/155465-131-near-future-technologies-bugfix-updates-march-2/)
  * [USI Constellation](https://github.com/BobPalmer/USI_Constellation/releases)
  * [MechJeb](https://www.curseforge.com/kerbal/ksp-mods/mechjeb/download)
  * [Airline Kuisine](https://forum.kerbalspaceprogram.com/index.php?/topic/156475-131-airline-kuisine-v161-~-jan-8-2018/)
  * [RemoteTech](https://spacedock.info/mod/520/RemoteTech/download/1.8.9)
  * [Tarsier Space Technologies](https://github.com/JPLRepo/TarsierSpaceTechnology/releases/tag/v7.2)
  * [ResearchBodies](https://github.com/JPLRepo/ResearchBodies/releases/download/V1.9.6/ResearchBodies_V1.9.6.0.zip)
  * [Waypoint Manager](https://github.com/jrossignol/WaypointManager/releases/download/2.7.0/WaypointManager_2.7.0.zip)
  * [Decal Stickers](https://spacedock.info/mod/1108/Decal%20Stickers/download/1.5)
  * [BlueDog Design Bureau (balanced optimally at 2.5x scale)](https://github.com/CobaltWolf/Bluedog-Design-Bureau/releases)

## Known Issues

* Clouds do not show up in main menu. Just a small bug with EVE and Kopernicus. Not a big deal. Nothing is broken.

* When not using Environmental Visual Enhancements, Nero will display axial precession. In future updates we may detect if EVE is installed and fix accordingly.

* Scatterer's effects do not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is broken. A quick scene change will fix this.

## Bundled Licenses

**These mods and/or assets are distributed by their own license terms, included in each mod's folder**

"KSCFloodlight"
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

"KSC++"
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)


"GPP_Renamer"
Simplified BSD License (BSD 2-clause)

"Sigma LoadingScreens"
All Rights Reserved (ARR)
