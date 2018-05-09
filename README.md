
# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs
CC BY-NC-ND

# Now on CKAN!

# Changelog:
## v1.6.3.0
## REQUIRES GPP_TEXTURES 4.1.1
* Fixes to KK sites
* Added isles for KSP 1.4 launch sites (Larkes and Woomerang)
* Prevent these launch sites from appearing on Gael in GPP Scondary
* Added KK launch sites for testing ~~Duna~~ Niven rovers
* GPP no longer indiscriminately deletes/unloads planets and planet packs that have loaded before itself. It specifically deletes only the stock bodies so planet packs such as Extrasolar, any pack by Gameslinx, and even GEP, will remain loaded without having to perform MM voodoo
* Accommodations for new features in GEP 1.0
* Updated EVE configs for GPP + OPM installations
* Minor fixes to Gael in GPP Secondary
* Renamed Sigma skybox files for Sigma Replacements/Texture Replacer compatibility
* Fixed some scatterer issues
* Made Lili 20% more awesome
* Added detection in resource configs for Kerbin vs Gael for GPP Secondary


## TO INSTALL:

1. Begin with an installation of KSP version 1.4.3, running in 64-bit.

2. If reusing an existing install, empty the GameData folder of all contents but for the folder [KSP]\GameData\Squad\.  If starting with an entirely new install, is it recommended that you run once with no mods installed before proceeding.

3. Download the third party mod [Kopernicus](https://github.com/Kopernicus/Kopernicus/releases/).  The Kopernicus version number must match the KSP version number, i.e. 1.4.3-x

4. Install by copying from [Kopernicus Download]\GameData\ to [KSP]\GameData\ the following folders and files:  
   * Kopernicus\
   * ModularFlightIntergrator\
   * ModuleManager.3.0.7.dll

5. Download Galileo’s Planet Pack 1.6.3.0

6. Copy from [GPP Download]\GameData\ to [KSP]\GameData\ the folder GPP\ and all its contents.

7. Download [GPP_Textures](https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/4.1.1).

8. Copy from [Textures Download]\GameData\GPP\ to [KSP]\GameData\GPP\ the folder GPP_Textures\.

9. This completes the basic installation.  If you want to, you can verify the installation by launching KSP.

## Optional Mods

1. Install the optional mods of your choice by copying or merging `<GPP Download>\Optional Mods\GPP_<mod name>\GameData\<mod name>` to `<KSP>\GameData\`.

2. [Final Frontier](https://spacedock.info/mod/580/Final%20Frontier/download/1.3.6-3189) must be downloaded and installed separately.

4. For GPP_Clouds and GPP_Secondary, see separate instructions below.

## KSC ++

1. For an extension to the Kerbal Space Center (fuel tanks, roads, cars, trees, the whole shebang), the third-party mod [Kerbal Konstructs](https://github.com/GER-Space/Kerbal-Konstructs/releases) must be downloaded and installed. Use the latest version developed for 1.4.x.

2. If KSC++ in used combination with a one of the scaled versions of GPP, [KKtoSD](https://forum.kerbalspaceprogram.com/index.php?/topic/162782-wip130-kktosd/) must be downloaded and installed.

## Sigma Replacements

1. To use GPP's high quality Gaelan heads, suits, navball and Skybox install Sigma Replacements. [Links here](https://github.com/Galileo88/Galileos-Planet-Pack#recommended-mods-with-support-for-or-by-gpp).

## Clouds, Aurorae and Shadows

1. For clouds, aurorae and shadows, go to `<GPP Download>\Optional Mods\GPP_Clouds\` and select either High-res or Low-res.  Drill down further until you get to a second GPP_Clouds\ folder.  Copy this folder to `<KSP>\GameData\GPP\`.

2. To enable the visual effects, the third-party mod [EVE (Environmental Visual Enhancements)](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases/tag/EVE-1.2.2-1) must be downloaded and installed.  You require only the small file, not the large one with “Configs” in its name (GPP comes with its own configs).

## Scatterer

1. GPP is configured to provide atmospheric scattering effects using the third-party mod Scatterer.  To enable these effects, download and install [Scatterer](https://spacedock.info/mod/141/scatterer/download/0.0324).

2. If you want to change the *Ciroflare* for either or both stars in GPP, the images and .cfg files are in the folder,  `GPP\GPP_Scatterer\Ciroflares\<Star>\` or, you can easily install one of the [Sunflares Of Maar](https://github.com/JadeOfMaar/sandbox/releases/tag/som.1.2) GPP packs.

## Optional High(er) Performance Visuals

If your computer can't handle the performance hit of Scatterer, GPP is fully set up to work without it, using EVE to simulate the atmosphere effect. In addition to this, there are a few other mods that can give you nice looking oceans and Ciro flares all without Scatterer, and with great performance. Following these 5 steps, you can make your game look as good as if you had Scatterer installed.

1. Download and install [Better Looking Oceans](https://github.com/Galileo88/Better-Looking-Oceans/releases) provides a good, high performance alternate to Scatterer's ocean shader, and cover all bodies with oceans in GPP/GEP/OPM.

2. Download and install [Flare Replacer](https://forum.kerbalspaceprogram.com/index.php?/topic/171820-ksp-131-flare-replacer-v102-09-mar-2018/) replaces the stock Ciro flare a higher quality Ciro flare. 15 different flares to choose from!

3. Download and install [KS3P](https://spacedock.info/mod/1618/KS3P) can provide some post processing effects that look great. A custom cfg for GPP is included in the GPP download.

4. Download and install [Minimum Ambient Lighting](https://spacedock.info/mod/448/Minimum%20Ambient%20Lighting) can make the dark side of the planets in flight as dark or as light as you would like with the ease of a slider in game.

5. Turn your [Ambient Light Boost: Map](https://i.imgur.com/vQK1aOW.jpg) down to about 90% or to your liking. [HERE](https://i.imgur.com/6IHAxwA.png) is an example.


## Classic Stock Resource System

This is an implementation of the unreleased stock resource library devised by **NovaSilisko, HarvesteR** and other early KSP developers, and delivered by Angel-125 and his Wild Blue Industries (WBI) mod suite. [Read about it here](https://github.com/Angel-125/Pathfinder/wiki/Classic-Stock-Play-Mode). It is an alternative to Community Resource Pack (CRP) and only activates if Classic Stock mode is selected at the WBI first run window in-game following a fresh install of the Pathfinder mod.

Mod compatibility with Classic Stock is entirely opt-in and is not to be expected to be readily available and provided by Wild Blue Industries.

## GPP Secondary

This addon mod makes GPP into a distant non-primary system, allowing users to keep Gael and the stock planets, and set the Ciro system (GPP's main star) and Gael (not a Gael clone named Gael) as the mid-game or end-game. To be fully compatible with GPP one of the following must occur:

1. If the other planet pack is large and also replaces the stock solar system it must include a patch to reposition Ciro.

2. If the other planet pack only adds planets, the option exists to place itself around Grannus and be mindful of its asteroid field. [Ciro orbit] realistically is already well occupied by GPP's own planets.

Kerbol Star System is not fully supported as it is currently known to have a colliding GPP compatibility patch. Do not use GPP Secondary with Galactic Neighborhood.

To install, just place GPP_Secondary\ into GameData\ so it looks like this:
  * GPP\
  * GPP_Secondary\
  * Kopernicus\
  * ModularFlightIntegrator\
  * ModuleManager.3.0.7.dll
  
## Grannus Expansion Pack (GEP)

Grannus Expansion Pack (GEP) is an expansion that adds planets and moons around the red dwarf star Grannus. GEP is designed to work in a variety of installation modes - as a GPP expansion, a stock expansion, or as a independent primary system.

While GEP is standalone mod, it has been developed with the full cooperation of the GPP team.  Special care has been taken to ensure that GEP integrates seamlessly with GPP.

For more information, download links and install instructions, visit the [GEP thread](https://forum.kerbalspaceprogram.com/index.php?/topic/169664-ksp-131-grannus-expansion-pack-v0800-16-jan-2018/).


## Kerbal Renamer

Kerbal Renamer is a new feature that renames all new and existing kerbals from "Kerman" to "Gaelan." It has a toggle (the first line) within GPP\GPP_Renamer\Renamer.cfg that can be set to keep Jebediah and company (the original 4) or to replace them with GPP's developers.

To toggle, change the following setting *preserveOriginals = true* to *false.*

## Scaled Versions

:triangular_ruler: To upscale GPP, see [Rescale! Comprehensive SD Configs](http://forum.kerbalspaceprogram.com/index.php?/topic/163965-13-rescale-comprehensive-sd-configs-1021/).

If one of the scaled versions of GPP is used in combinations with KSC++, the third-party mod [KKtoSD](https://forum.kerbalspaceprogram.com/index.php?/topic/162782-wip130-kktosd/) must be downloaded and installed.


## Recommended mods with support for or by GPP
  ### OhioBob's mod
  * [Grannus Expansion Pack (GEP)](https://github.com/OhioBob/Grannus-Expansion-Pack/releases)
  
  ### Sigma88's mods
  * [Sigma Dimensions](https://github.com/Sigma88/Sigma-Dimensions/releases)
  * Sigma Replacements
    * [Heads](https://github.com/Sigma88/Sigma-Replacements/releases/tag/H_v0.2.4)
    * [Suits](https://github.com/Sigma88/Sigma-Replacements/releases/tag/S_v0.3.0)
    * [Skybox](https://github.com/Sigma88/Sigma-Replacements/releases/tag/B_v0.3.0)
    * [Navigation](https://github.com/Sigma88/Sigma-Replacements/releases/tag/N_v0.2.2)
    * [Descriptions](https://github.com/Sigma88/Sigma-Replacements/releases/tag/D_v0.2.5)
    * [Menu Scenes](https://github.com/Sigma88/Sigma-Replacements/releases/tag/K_v0.1.0)
  
  ### General visual mods
  * [Environmental Visual Enhancements](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases/)
  * [Flare Replacer](https://forum.kerbalspaceprogram.com/index.php?/topic/171820-ksp-131-flare-replacer-v102-09-mar-2018/) (overrides scatterer)
  * [Better Looking Oceans](https://github.com/Galileo88/Better-Looking-Oceans/releases) (overrides scatterer)
  * [KS3P](https://spacedock.info/mod/1618/KS3P)
  * [Distant Object Enhancement](https://github.com/MOARdV/DistantObject/releases/)
  * [PlanetShine](https://github.com/PapaJoesSoup/ksp-planetshine/releases)
  * [Scatterer - min-version: 0.0320b](https://spacedock.info/mod/141/scatterer)
  
  ### Angel-125's mods
  * Wild Blue Industries
    * [Pathfinder](https://github.com/Angel-125/Pathfinder/releases)
    * [DSEV (Deep Space Exploration Vessels)](https://github.com/Angel-125/DSEV/releases)
	* [MOLE (Mark One Laboratory Extensions)](https://github.com/Angel-125/MOLE/releases)
	* [Kerbal Komets](https://github.com/Angel-125/KerbalKomets/releases)
	
  ### JadeOfMaar's mods
  * Deep Sky
    * [Thor Tech](https://forum.kerbalspaceprogram.com/index.php?/topic/168326-131-143-thor-tech-v096-~-may-7-2018/)
	* [The Spice](https://forum.kerbalspaceprogram.com/index.php?/topic/167366-131-143-the-spice-v081-may-7-2018/)
    * [Sunflares Of Maar](https://github.com/JadeOfMaar/sandbox/releases/tag/som.1.2) (needs scatterer)

  ### Rocketry mods
  * [Near Future Technologies](https://forum.kerbalspaceprogram.com/index.php?/topic/155465-131-near-future-technologies-bugfix-updates-march-2/)
  * [BlueDog Design Bureau](https://forum.kerbalspaceprogram.com/index.php?/topic/122020-14x-bluedog-design-bureau-stockalike-saturn-apollo-and-more-v142-i-numbered-this-update-before-ksp-updated-1feb2018/)
  
  ### Quality of life mods
  * [SCANsat](https://spacedock.info/mod/129/SCANsat)
  * [JX2 Large Antenna](https://spacedock.info/mod/1107/JX2Antenna/)
  * [Strategia](https://github.com/jrossignol/Strategia/releases)
  * [MechJeb](https://www.curseforge.com/kerbal/ksp-mods/mechjeb/download/2518230)
  * [Tarsier Space Technologies](https://github.com/JPLRepo/TarsierSpaceTechnology/releases)
  * [ResearchBodies](https://github.com/JPLRepo/ResearchBodies/releases)
  * [Waypoint Manager](https://github.com/jrossignol/WaypointManager/releases)
  
  ### RoverDude's mods
  * [Karbonite (with Karborundum)](https://github.com/BobPalmer/Karbonite/releases)
  * [Asteroid Recycling Technologies](https://github.com/BobPalmer/ART/releases)
  * [USI Alcubierre Drive](https://github.com/BobPalmer/WarpDrive/releases)
  
  ### Other mods
  * [RemoteTech](https://spacedock.info/mod/520/RemoteTech/)
  * [Decal Stickers](https://spacedock.info/mod/1108/Decal%20Stickers/)

## Known Issues

* When not using Environmental Visual Enhancements, Nero will display axial precession. In future updates we may detect if EVE is installed and fix accordingly.

* Scatterer's effects do not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is broken. A quick scene change will fix this. Or you can go to the main menu and turn off the ocean shader. At this point you regain a remarkable amount of PC performance and [Better Looking Oceans](https://github.com/Galileo88/Better-Looking-Oceans/releases) can be installed for, clearly, better looking oceans.

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
