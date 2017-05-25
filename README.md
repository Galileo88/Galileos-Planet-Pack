# Galileos-Planet-Pack

This mods is licensed by Creative Commons Attribution-NonCommercial-NoDerivs 
CC BY-NC-ND 

TO INSTALL:

1. Create a new install of KSP and run once with zero mods. If, however, you're not creating a new install then backup and remove your saves. Any existing playthrough will be broken. Planet textures are in a separate download now so be sure to get both GPP downloads.

2. Planet textures are in a separate download now so be sure to get both GPP downloads. They are respectively 300MB and 400MB large. Make sure to install both and ensure that KSP always launches in 64-bit. Your PC/Mac/Linux box should have no less than 8GB RAM. They are separate because the textures very rarely update, and it is a waste of time for Galileo to upload and you to download so much for frequent updates to usually only the configs. GPP_Textures are at https://github.com/Galileo88/Galileos-Planet-Pack/releases/download/1.0/GPP_Textures.zip

3. Kopernicus and ModularFlightIntegrator (part of Kopernicus) are now included in this package, along with the modified dll to enable all planet rings to show, and on which our solution to the multi-star solar panel problem can function. Install everything.

4. Install GPP and ensure that KSP always launches in 64-bit (KSP_x64.exe on Windows). Your PC should have no less than 8GB RAM.

5. Before you launch, if you are deep into a GPP v1.1 career then install [Download]\GPP_CareerSaver\ anywhere within GameData\ as the addition of a celestial body at v1.2.0 will break your saves. GPP v1.2.3 should not break any saves that were started in v1.2.x. But the terrain updates in v1.2.3 can destroy landed bases or ships in v1.2.2 or older.

6. Install any of the remaining bundled mods if they suit you: KSC Switcher, Scatterer, TextureReplacer, Kerbal Konstructs with KSC++, Final Frontier.

## Konfigurating EVE

If you need to get clouds, aurorae and shadows working in your install, look in the [Download]\Optional Mods\GPP_Clouds\ directory.

1. Inside the GPP_Clouds folder are two folders. One is named High-res and the other is named Low-res. Inside of each is another GameData folder. Choose from inside the one you want and merge into the real GameData folder to install.
 
2. Install EVE (not the configs) Or, just use this link: https://github.com/WazWaz/EnvironmentalVisualEnhancements/releases/download/EVE-1.2.2-1/EnvironmentalVisualEnhancements-1.2.2.1.zip

## Re-scattering the Scatterer

Galileo has found the means to reduce the Scatterer bundles into MM toggles and package all the GPP-specific media within GPP itself, removing the need to modify the contents of GameData\scatterer directly. The various Scatter_* nodes in GPP's scatterer files all now contain an author field enabling filtration and targeting of planet lists and planet configs by author.

Install Scatterer from SpaceDock: https://spacedock.info/mod/141/scatterer

If you need to change the sunflare for either or both stars in GPP, you must now look into the following places for your operation:

1. GPP\GPP_Scatterer\Sunflares\[Star]\ to change the images, and the Scatterer_sunflare{} node inside the respective config file beside them.

2. If you have changed your sunflare sizes before, be aware that the configs are separate again and stored beside the sunflare images in step 1. There is no longer any scatterer cfg file in GPP\GPP_Configs\
 
 
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
## v1.2.3

* Kopernicus (W/Blackrack's ring fix) is included in the download to alleviate some confusion.

* Added PQSMods to all bodies resulting in better terrain.. Can 4K get any better?

  * Altitude info has not been updated in KSPedia pages to reflect these changes.

* Applied fixes and optimizations to Scatterer.

* Luminosity (multi-star) issue has been fixed (Thanks to TheRagingIrishman)

* Fixed the Agency compatibility with Clever Sats mod.

* Increased performance optimization for non-Scatterer users.

* Clouds now have a subtle UV noise applied, removing harsh edges from cloud textures textures.

* Fixed the Asteroids problem. They will spawn now.

  * Added authorship detection to asteroids as with Scatterer.

* More directory updates to help make the GPP install cleaner and more modular.

  * Separated all base textures into one directory (GPP_Textures\ ) and its own download to ease the downloads of further releases. Initial load time of KSP will take a little longer (Not too long), however, Mac and Linux users can now use .dds textures and save some ram.

  * Sifted all celestial configs into GPP_Planets\ .
  
  * Altered the GPP_Scatterer\ directory a little. Split the sunflare configs into separate files beside the sunflare images.

* Gave Thalia a chill pill. She now burns half as much in high orbit.

* Doubled Kerbals MaxTemp from 800 to 1600. Kerbals won't die as quickly on Icarus or Thalia.

* Updated resources to hopefully fix the vanishing Ore problem.

* Sigma Dimensions:

  * added 10.625x.
  
  * Now affects sunflares.
  
  * Now ensures Gael always has integer numbers of days, integer days in a year.


## Known Issues
 
* Clouds do not show up in main menu. Just a small bug with Kopernicus. not a big deal. Nothing is broken.

* Scatterer does not show in main menu. Again, normal. Nothing is broken.

* Sometimes KSC will appear flooded. This is normal and also because of Scatterer. Nothing is boken.

* Running game in dx11 causes terrain textures to be pinstriped.

* Orbit lines jump around when zoomed out to outer planets in map view and tracking station. Its stock bug made more noticeable by Kopernicus

* Sigma Dimensions does not play nice with KSCSwitcher AND KSC++. I recommend you remove KSC++ when using Sigma Dimensions

* Kerbal Konstructs does not scale with Sigma Dimensions. Statics spread apart. A fix is coming.

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
