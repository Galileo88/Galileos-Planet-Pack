# Galileo's Planet Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs
CC BY-NC-ND

## TO INSTALL:

1. Begin with an installation of KSP version 1.8.1 or newer, running in 64-bit.

2. If reusing an existing install, empty the GameData folder of all contents but for the folder `[KSP]\GameData\Squad\`. If starting with an entirely new install, is it recommended that you run once with no mods installed before proceeding.

3. Download the third party mod [Kopernicus](https://github.com/Kopernicus/Kopernicus/releases/tag/release-1.8.1-1), or [Kopernicus Continued](https://github.com/prestja/Kopernicus/releases/). The Kopernicus version number must match the KSP version number, i.e. 1.8.1-x

4. Install by copying from `[Kopernicus Download]\GameData\` to `[KSP]\GameData\` the following folders and files: 
   * Kopernicus\
   * ModularFlightIntergrator\
   * ModuleManager

5. Download Galileo’s Planet Pack 1.6.4.0

6. Copy from `[GPP Download]\GameData\` to `[KSP]\GameData\` the folder `GPP\` and all its contents.

7. Download [GPP_Textures](https://github.com/Galileo88/Galileos-Planet-Pack/releases/tag/4.2.1).

8. Copy from `[Textures Download]\GameData\GPP\` to `[KSP]\GameData\GPP\` the folder `GPP_Textures\`.

9. This completes the basic installation. If you want to, you can verify the installation by launching KSP.

## Optional Mods

1. Install the optional mods of your choice by copying or merging `[GPP Download]\Optional Mods\GPP_[mod name]\GameData\[mod name]` to `[KSP]\GameData\`.

2. [Final Frontier](https://forum.kerbalspaceprogram.com/index.php?/topic/61065-142-final-frontier-kerbal-individual-merits-142-3375/) must be downloaded and installed separately.

4. For GPP_Clouds and GPP_Secondary, see separate instructions below.

## KSC ++

1. For an extension to the Kerbal Space Center (fuel tanks, roads, cars, trees, the whole shebang), the third-party mod [Kerbal Konstructs](https://github.com/GER-Space/Kerbal-Konstructs/releases) must be downloaded and installed.

## Clouds, Aurorae and Shadows

1. For clouds, aurorae and shadows, go to `[GPP Download]\Optional Mods\GPP_Clouds\` and select either High-res or Low-res. Drill down further until you get to a second `GPP_Clouds\` folder. Copy this folder to `[KSP]\GameData\GPP\`.

2. To enable the visual effects, the third-party mod [EVE (Environmental Visual Enhancements)](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases) must be downloaded and installed. You require only the small, plugin file, not the large one with “Configs” in its name (GPP comes with its own configs).

## Scatterer
 
1. GPP is configured to provide atmospheric scattering effects using the third-party mod Scatterer. To enable these effects, download and install [Scatterer](https://github.com/LGhassen/Scatterer/releases).

2. If you want to change the *Ciroflare* for either or both stars in GPP, the images and .cfg files are in the folder, `GPP\GPP_Scatterer\Ciroflares\[Star]\` or, you can easily install one of the [Sunflares Of Maar](https://github.com/JadeOfMaar/sandbox/releases/tag/som.1.2) GPP packs.

## GPP Secondary

This addon mod makes GPP into a distant non-primary system, allowing users to keep Gael and the stock planets, and set the Ciro system (GPP's main star) and Gael (not a Gael clone named Gael) as the mid-game or end-game. To be fully compatible with GPP one of the following must occur:

1. If the other planet pack is large and also replaces the stock solar system it must include a patch to reposition Ciro.

2. If the other planet pack only adds planets, the option exists to place itself around Grannus and be mindful of its asteroid field. Ciro orbit realistically is already well occupied by GPP's own planets.

Kerbol Star System is not fully supported as it is currently known to have a colliding GPP compatibility patch. Do not use GPP Secondary with Galactic Neighborhood.

To install, just place GPP_Secondary\ into GameData\ so it looks like this:
  * GPP\
  * GPP_Secondary\
  * Kopernicus\
  * ModularFlightIntegrator\
  * ModuleManager
 
## Kerbal Renamer

Kerbal Renamer is a new feature that renames all new and existing kerbals from "Kerman" to "Gaelan." It has a toggle (the first line) within GPP\GPP_Renamer\Renamer.cfg that can be set to keep Jebediah and company (the original 4) or to replace them with GPP's developers.

To toggle, change the following setting *preserveOriginals = true* to *false.*

## Supported/Recommended mods

To find a list of mods that are supported by GPP or are recommended by the GPP Team, please visit this exhaustive documentation to show how you can extend your GPP gameplay, enhance the visuals of your GPP install or even rescale your GPP system: [Link](https://forum.kerbalspaceprogram.com/index.php?/topic/152136-ksp-143-galileos-planet-pack-v1630-9-may-2018/&do=findComment&comment=2853191) 

## Known Issues

* When not using Environmental Visual Enhancements, Nero will display axial precession. In future updates we may detect if EVE is installed and fix accordingly.

* Scatterer's effects do not show in main menu or tracking station. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is broken. A quick scene change will fix this. Or you can go to the main menu and turn off the ocean shader. If you are having performance trouble with Scatterer's oceans you can always try [Better Looking Oceans](https://github.com/Galileo88/Better-Looking-Oceans/releases) for low resource usage but better than stock visuals.

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

"Sigma TweakChutes"
All Rights Reserved (ARR)
