# Galileo's Planet Pack

# 1.6.4.0 Changelog
## REQUIRES GPP_TEXTURES 4.2.1
:bookmark: *KSP 1.8.1  or newer*
* Added Unity sunflares.
* Added support for Kerbal Health.
* Added support for Principia (deletes Lili).
* Bundled Sigma TweakChutes.
* Updated scatterer configs to current version.
* Updated Kerbal Renamer.
* Updated Agency logos.
* Updated Strategia config.
* Fixed OPM/scatterer compatibility problems.
* Fixed bug MechJeb2 config.
* Fixed bugs in science definitions.
* Revised and fixed bugs in resource configs.
* Revised asteroid groups (location & lifetime).
* Revised internal biome names.
* Revised Lili's albedo and emissivity.
* Reenabled Lili's orbit icon.
* Disabled Ciro's atmosphere to remove artifact.
* Disabled on demand loading for biomes.
* Replaced HazardousOcean with HazardousBody.
* Changed Otho's semimajor axis.
* Reformatted CelestialBodies.pdf

# 1.6.3.1 Changelog
## REQUIRES GPP_TEXTURES 4.2.1
* Fixed incorrect body name in Asteroids config.
* Fixed incorrect body name in MechJeb config.
* Fixed incorrect texture name in OPMClouds and StockClouds.
* Fixed error in scatterer planet list (cause of 'black sky' bug).
* Rewrote several scatterer configs to improve compatibility with Module Manager.
* Increased Lili's surface gravity (can now land on most of its surface).
* Deleted Lili's orbit line from tracking station/map view.
* Revised Leto's atmosphere visual settings.
* Updated CelestialBodies.pdf.

# 1.6.3.0 Changelog
## REQUIRES GPP_TEXTURES 4.2.0
* Fixes to KK sites
* Added isles for KSP 1.4 launch sites (Larkes and Woomerang)
* Prevent these launch sites from appearing on Gael in GPP Scondary
* Added KK launch site for testing rovers
* Kerbinside is now compatible while playing with GPP_Secondary installed
* GPP no longer indiscriminately deletes/unloads planets and planet packs that have loaded before itself. It specifically deletes only the stock bodies so planet packs such as After Kerbin, Before Kerbin, Extrasolar, and even GEP, will remain loaded without having to perform MM voodoo
* Accommodations for new features in GEP 1.0
* Updated EVE configs for GPP + OPM installations
* Minor fixes to Gael in GPP Secondary
* Renamed Sigma skybox files for Sigma Replacements/Texture Replacer compatibility
* Fixed some scatterer issues
* Made Lili 20% more awesome
* Added detection in resource configs for Kerbin vs Gael for GPP Secondary

# 1.6.2.2 Changelog
## REQUIRES GPP_TEXTURES 4.1.1
* Fix KK spam due to incorrect name in a cfg
* Fix floating building at GSC

# 1.6.2.1 Changelog
## REQUIRES GPP_TEXTURES 4.1.1
* Fixed some Scatterer issues
* Scatterer compatibility is back for GPP_Secondary
* Added clouds for stock bodies when using GPP_Secondary (no need to install SVE anymore, just EVE)
* Other small miscellaneous fixes

# 1.6.2.0 Changelog
## REQUIRES GPP_TEXTURES 4.1.1
* Adds support for FlareReplacer
* Implememts EVE atmospheres when Scatterer is not installed (better performance. Instructions below)
* Scatterer is not required for atmospheric effects
* Updated Scatterer for softer edges of atmospheres
* Custom/random start menu and exit menus with SigmeReplacments: MenuScenes
* Added Custom KS3P configuration
* Added artistic twist to loading screens
* Fixed squiggly line in the sky due to Aurora texture gaffe
* Better noise of gas giants, bring the textures to life
* Added GPP Clouds support for OPM when OPMVO is not installed
* Fixed erroneous biome entries in body and resource configs
* Classic Stock resource system
* Added location for KrakenJuice for users of v0.8 or higher of the KrakenScience mod
* GPP KSCSwitcher has been removed
* All KSCSwitcher sites have been recreated with Kerbal Konstructs
  * Now you can fly from one site to the next.
* Added additional runway and launch pads to GSC with Kerbal Konstructs

# 1.6.1.2 Changelog
## REQUIRES GPP_TEXTURES 4.1.0
* Fixes CKAN issues (sorry)

# 1.6.1.1 Changelog
## REQUIRES GPP_TEXTURES 4.1.0
* Update for Kopernicus 1.3.1-7
* Julia's Greater Pigments biome localization fixed.
* useManualMemoryManagement has been implemented.
* Included celestial body cache files to speed up initial load time.
* Fixed the Gael anomolies.
* Only apply the Sigma Replacements: Navigation patch to command modules if said mod is installed.
* Poodmund re-wrote the above patch note line, like, 5 times due to being a derp at language and things.

# 1.6.1.0 Changelog
## REQUIRES GPP_TEXTURES 4.1.0
* Update for Kopernicus 1.3.1-6
* File structures have changed to take full advantage of On Demand Loading in Kopernicus
  * Speeds up loading time and saves RAM during gameplay. 
* Terrain scatter is easily disabled and enabled by the EnableColliders.cfg in the GPP/GPP_Configs
* Fixed error with Eta biome map

# 1.6.0.1 Changelog
## REQUIRES GPP_TEXTURES 4.0.0
* Fixed a null spam problem caused by Sigma Loading Screens when KSP-AVC not installed.

# 1.6.0 Changelog
## REQUIRES GPP_TEXTURES 4.0.0
* **New textures!**
  * Ciro
  * Grannus
  * Eta
  * Lili
  * Gratian 
  * Geminus
  * Otho
  * Gauss
  * Nero
  * Hox
  * Leto
* Provide/contain support for GEP
* ResearchBodies config updated
  * Split into two part-upgrades which are closer to the telescope part in the tech tree
  * Second upgrade allows telescope range up to 9 Tm distance
* Revised biome maps
* Update KSPedia and dV map PNG
* Adjusted resource system configs
* Updated GPP_Clouds
  * New clouds on some bodies
  * New aurorae for all planets with them
  * Subtle gas giant cloud noise
  * Catullus is so fluffy! (Fluffier maybe?)
  * Dust and sandstorms are back! Like the Terminator T-1

# 1.5.99 Changelog
## REQUIRES GPP_TEXTURES 3.0.0
* Small changes to make DirectX 11 work. TU users rejoice!
* Fixes the renamer and enables it to work with career saves again.

# 1.5.88 Changelog
## REQUIRES GPP_TEXTURES 3.0.0
* Introduces Sigma Loading Screens
* Introduces Sigma Replacements:
  * High quality heads
  * High quality suits
  * High quality navball
  * Custom admin heads
  * New default skybox included
    * The skybox will rotate at the start of each new game and will remain persistent within that save
* Introduces Sigma Kerbal Descriptions: Adds fanciful semi-random quirks, descriptions, places of study, and colored profession labels to Gaeleans. Supports extra traits added by Colonists!, MKS and other mods
* Added Sigma Gaelan and Raging Gaelan to veteran roster
  * All 6 devs are available by default at the start of a game
* Added slight atmosphere to Leto
* Even more Kerbal Konstructs goodies
  * Gulls on Gael
  * Water launch sites in accordance with KSC Switcher
  * Other winged creatures on Tellumo
* Fixed ResearchBodies LOC tag issue(s)
* Fixed broken localization at Lili
* Fixed GPP_Renamer
* Fixed contracts for Strategia.
* Adjusted gas giant Scatterer cfgs

# 1.5.3 Changelog
## REQUIRES GPP_TEXTURES 3.0.0
* Update for 1.3.1
* GPP_Secondary optimization
  * GPP no longer steals OPM if secondary is active.
  * Reduced the need for GPP_Secondary itself when GPP is installed with KSS or GN.
  * Ensured that actual Gael will appear for KSS or GN, and not a Kerbin clone.
  * Grannus looks more like a star.

# 1.5.2 Changelog
## REQUIRES GPP_TEXTURES 3.0.0
* Update to keep in accord with Kopernicus 1.3.0-8
  * Solar panels will auto track the correct star!
* Disbaled contracts for Ciro and Grannus to _hopefully_ avoid the infamous "Collect Ore" contracts
* Adjusted ring colors for Nero and Tellumo since kopernicus fixed the ring color parameter
* Revised light intensity curves better lighting around Grannus
* Aligned Nero's rings with Nero's texture when EVE is not installed (wobble effect is back but it looks more aesthetically pleasing with than without)

# 1.5.1 Changelog
## REQUIRES GPP_TEXTURES 3.0.0
* Patch for OPM_Galileo to not move current orbiting vessels upon load.

# 1.5.0 Changelog
## REQUIRES GPP_TEXTURES 3.0.0
* The starting positions of most planets have been changed to provide better launch windows in years 1 and 2. This could be game-breaking for current saves.
* The new sun curves have been added to Ciro and Grannus, curing the infinite multiple starlight problem. (Bodies get darker the further away they are)
* Nero's precession has been fixed when using Environmental Visual Enhancements will appear to have a 10° axial tilt (no more perciveable wobble).
  * Nero's four moons are all now inclined in concert with the rings. See updated dV map in the download.
  * Nero has two new moonlets: Agrippina and Julia. This could be game-breaking.
* Updated KSPedia.
* Kerbalism support has been dropped from GPP. It will return natively in Kerbalism in a future update.
* GPP now alerts the player if GPP_Textures are misplaced or missing.
* Preliminary support (Planet Challenge settings) for Station Science Continued.
* Planet texture updates. Be sure to download the latest.
* GPP Secondary now handles visual packs. At minimum, SVE, GPP_Clouds, and sunflares for Stock + GPP work seamlessly.
* Strategia "Private Sector" strategy is less cheaty, but still plentyful in rewards.
* OPM_Galileo can populate Grannus SOI. https://github.com/Galileo88/OPM_Galileo/releases
* Added resource setup for Far Future Technologies.
* Rescale! now properly places Kerbal Konstructs statics when using Sigma Dimensions.

# 1.4.0 Changelog
## REQUIRES GPP_TEXTURES 2.0.0
* Overall compatibility with KSP 1.3 and the latest Kopernicus 
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
* Strategia balance and updates.
  * More realistic strategies. No more "cheat" strategies that take the challenge out of GPP.
* Removed GPP_CareerSaver.
* Removed Rescale! folder. To upscale GPP, see [Rescale! Comprehensive SD Configs](http://forum.kerbalspaceprogram.com/index.php?/topic/163965-13-rescale-comprehensive-sd-configs-1021/).
* Created GPP_Secondary (see Optional Mods\ folder) for seamless loading of GPP alongside Stock and/or other star system mods. Visual pack interoperability is not handled and not promised.
  * Any other replacement primary system just needs to reposition Ciro.
  * Do not use with Galactic Neighborhood.
* Created "SuitProgression" upgradeable heat tolerance for EVA kerbals.
  * Each time you upgrade the astronaut complex, the max temperature for a kerbal goes up by 400k, maxing at 1600K.
* Repaired and restored custom science for Gael and its moons.
* Updated ResearchBodies support and added science definitions for its sibling, Tarsier Space Technologies.
* Scatterer v0.0320b support.
  * Disabled volumetric clouds on Catullus due to scatterer bug.
* Added patch to change LqdAmmonia distributions to Ammonia if Kerbalism is present.

# 1.2.3 Changelog
## REQUIRES GPP_TEXTURES
* Kopernicus (W/Blackrack's ring fix) is included in the download to alleviate some confusion.
* Added PQSMods to all bodies resulting in better terrain.
  * Altitude info has not been updated in KSPedia pages to reflect these changes.
* Complete revamp of all normal maps. Planets look even nicer from scaled space... Can 4K get any better?
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
  * Sun flares now scale with the rescale size.
  * Now ensures Gael always has integer numbers of days, integer days in a year.

# 1.2.2 Changelog
## REQUIRES GPP_TEXTURES
* Fixed strange effect on gas giants caused by scatterer **FOR REAL THIS TIME!**
* Gael has properly colored desert area
* Fixed duplicate flag issue in main menu
* Added code to rescale cfgs that should increase the resolution of the cloud layers in scaled systems
* Added code to rescale cfgs that multiplies the stock antenna power values by a factor of the rescale value

# 1.2.1 Changelog
* Directory has changed
  * Scatterer is now a Module Manager config
  * EVE configs (GPP_Clouds) are now a module Manager config
* Refactored CommNet Antenna Power and DSN Power patches when using a scaled system to pull scale factor directly Sigma Dimensions 'Rescale' key
* Fixed strange effect on gas giants caused by scatterer
* Made clouds a little brighter and more opaque 
* Strategia config no longer deletes stock strategies
* Time warp limits adjusted for quicker time warps in lower orbits (not too quick though)
* Added Kopernicus ring shader support

# 1.2.0 Changelog
* Support for Scatterer v0.0300 and renamed bundled SVE to GPPVE to cure chronic Stock Visual Confusion.
  * Removed Medium SVE/GPPVE option to save on download size. The difference between Medium and High was minimal in-game.
* Reduced the following into MM patches, simplifying things overall and saving more on download size:
  * Distant Object Enhancement; Strategia; Planetshine; Waypoint Manager; Sunflare toggle for whether Scatterer is present or not.
* Enabled MechJeb to acknowledge KSC default location.
* KSPedia implementation - With information on all major bodies!
* Catered for new 'big' sticker in Decal Stickers mod.
* Far-reaching body updates:
  * Simplified biome distributions on the noisier of biome maps.
  * Optimized color textures to lose excess file size but keep all quality.
  * Adjusted Scaled Space to PQS render height for much smoother transitions.
  * Visual updates to Niven!
  * Merged Gael and Tellumo cloud layers to consolidate textures.
  * Implemented EVE eclipses. ALL bodies receive eclipses, with and without Scatterer.
  * Optimized Nero color and biomes to match ring tilt.
  * Added slight tilt to Otho and Gauss.
  * Raised Lili's SOI to 40km to un-break Lili Orbital Survey contracts.
  * Optimized terrain elevations so KER and the like can honestly tell where sea level is.
  * Added anomalies to all bodies, and more PQSMod tweaks to some worlds. This includes fixes for terrain jitter and performance drain, especially at Tellumo.
  * Improved texture details even more on some worlds.
  * Changed Flight Globals to enable certain provisions and prevent a related issue.
* Added "Career Saver" as the Flight Globals change will cause other issues (specifically: break existing game saves).
* Strategia updates.
* Updated deltaV map.
* Full Kerbalism support.
* Gael updates:
  * Lowered KSC island height and made shoreline friendly to enter/exit the ocean. Updated KSC++ and island biomes accordingly.
  * Changed Initial Rotation to put sunrise at 01:30 UTC.
  * Tuned Semi-major Axis so years are exactly 426.0 days long.
  * Renamed the Kerbin World-Firsts Society to Gaelean Historians Collective.
  * Minor adjustments to terrain and biome maps.
* Updated Texture Replacer.
* Custom loading screen!
* Other new bells and whistles. Some very small... Some very big.

# 1.1 Changelog
* Revised all biome map colors to resemble planets' surfaces/easy on the eyes.
* Strategia compatibility.
* Improved scatter objects for Gael and Tellumo.
* Improves Scatterer effects for nearly all atmospheric bodies.
* Improved EVE: Better particles for snow on Tellumo and Gael. All gas giants have have moving cloud bands with simulated tilt. 
  * Snow on Gael is no longer on the poles. It is now scattered just below the north polar region and above the south polar region.
* Sigma Dimensions: 3.2x, 6.4x, 10x.
* Changed the following worlds signficiantly: Iota, Tellumo, Gratian, Geminus, Otho, Hephaestus, Jannah, Gauss, Loki, Nero, Muse, Argo (and fixed all pole pinching).
  * Also retextured Ciro and added biomes.
* Niven atmosphere pressure raised slightly, height raised to 65km.
* Added SFX: IVA under pressure, splashdown, quieter launch clamps.
* Gael updates
  * Iota now has different biomes and flat areas but they won't be obvious to the naked eye.
  * Ceti now has science definitions.
  * Gael has a new Reefs biome with custom science, and discreet shores biomes to help identify the three supercontinents.
* Fixed default sun intensity. Brightness patches no longer needed.
* KSC now oriented Eastward (but is still off-equator)
  * KSC++ features aligned to fit.
  * KSC isle topology changed.
  * KSC Switcher support with 6 alternate locations including an equatorial one, like stock.
* Fixed RemoteTech support. Gael now has 7 ground stations and is properly ID'd by deployed satellites.
* Thalia and Icarus improvements. Improved so much that you'll need to bring radiators.
* Waypoint Manager icons for every celestial body.
* Buffed karbonite ocean harvester slightly and all Karbonite air-breathing engines except the radial turbojet. It's clearly described as super-slow and goes untouched.
* Decal Sticker support:
  * Apply your choice GPP flag as a decal with options for extending like a banner and spanning a cross-section of a craft.
* Added resource configs for Kerbalism. Other resource biases and optimizations also applied.