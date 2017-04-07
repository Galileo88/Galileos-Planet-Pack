# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs 
CC BY-NC-ND 

TO INSTALL:

1. Create a new install of KSP and run once with zero mods. 

2. Install Kopernicus, ModularFlightIntegrator (part of Kopernicus) and ModuleManager.dll within GameData\ and run KSP again. No planet mod works without these. They are also not included in this package. If, however, you're not creating a new install then backup and remove your saves. Any existing playthrough will be broken.

3. Install GPP and ensure that KSP always launches in 64-bit (KSP_x64.exe on Windows). Your PC should have no less than 8GB RAM.

4. Install any of the remaining bundled mods if they suit you: KSC Switcher, Kerbal Konstructs with KSC++ or Final Frontier.

## Konfigurating EVE

If you need to get clouds and ring shaders working in your install, GPPVE has been reduced to MM toggles and the GPP_Clouds directory

1. Install GPP_Clouds\ (High or Low res depending on your PC's performance) from the Optional Mods folder in the download and into GameData\GPP\
 
2. Install EVE from [its GitHub](https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases).
 
3. To get Kopernicus' fancy ring shaders to work on all ringed planets download [this interim update](https://mega.nz/#!vUowhKgB!PAIeK8M1KlBOXhcBNglxGTq6MzSiqFxF27fAXYOD8_w) to Kopernicus.dll and install it in GameData\Kopernicus\Plugins\ (click Yes if asked to overwrite).

## Re-scattering the Scatterer

Galileo has found the means to reduce the Scatterer bundles into MM toggles and package all the GPP-specific media within GPP itself, removing the need to modify the contents of GameData\scatterer directly. The various Scatter_* nodes in GPP's scatterer files all now contain an author field enabling filtration and targeting of planet lists and planet configs by author.

If you need to change the sunflare for either or both stars in GPP, you must now look into the following places for your operation:

1. GPP\GPP_Scatterer\Sunflares\ to change the images
 
2. GPP\GPP_Configs\GPP_Scatterer.cfg for the Scatterer_sunflare{} nodes where the custom sunflare images are tuned.

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
  * Research Bodies
  * Waypoint Manager
  * Decal Stickers
  * USI Constellation


# Changelog:
## v1.2.3

* Fixed strange effect on gas giants caused by scatterer **FOR REAL THIS TIME!**

* Gael has properly colored desert area

* Fixed duplicate flag issue in main menu

* Added to rescale cfgs code that should increase the resolution of the cloud layers in scaled systems

* Added to rescale code that multiplies the antenna power values by a factor of the rescale value


## Known Issues
 
* Clouds do not show up in main menu. Just a small bug with Kopernicus. not a big deal. Nothing is broken.

* Scatterer does not show in main menu. Again, normal. Nothing is broken.

* Mac and Linux Version uses quite a bit of ram. Its either this, or have pinstripey planets and not be able to use this planet pack. Sorry.

* Running game in dx11 causes terrain textures to be pinstriped.

* Orbit lines jump around when zoomed out to outer planets in map view and tracking station. Its stock bug made more noticeable by Kopernicus

* Sigma Dimensions does not play nice with KSCSwitcher AND KSC++. I recommend you remove KSC++ when using Sigma Dimensions

* Kerbal Konstructs does not scale with Sigma Dimensions. Statics spread apart.

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
