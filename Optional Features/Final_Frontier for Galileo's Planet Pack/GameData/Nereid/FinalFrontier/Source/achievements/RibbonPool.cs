using System;
using UnityEngine;
using System.IO;
using System.Collections.Generic;


namespace Nereid
{
   namespace FinalFrontier
   {

      class RibbonPool : Pool<Ribbon>
      {
         private const int CUSTOM_RIBBON_BASE = 1000;
         private const String FILENAME_RIBBONPACK = "FinalFrontierCustomRibbons.cfg";

         public delegate void Callback();

         public List<Callback> OnRibbonPoolReady {  get; private set; }

         // default ribbon path
         private const String _RP = "Nereid/FinalFrontier/Ribbons/";

         private static volatile RibbonPool instance;
         //
         public static RibbonPool Instance()
         {
            if (instance == null)
            {
               instance = new RibbonPool();
               Log.Info("new ribbon pool instance created");
            }
            return instance;
         }

         // flag if ribbons already created
         private volatile bool ribbonsCreated = false;

         // custom ribbons
         private readonly List<Ribbon> customRibbons = new List<Ribbon>();
         private readonly Dictionary<int, Ribbon> customMap = new Dictionary<int,Ribbon>();

         // external ribbons
         private readonly List<Ribbon> externalRibbons = new List<Ribbon>();


         // -- special ribbons --
         // private Ribbon FirstGrandTourRibbon;
         private Ribbon GrandTourRibbon;
         // private Ribbon FirstJoolTourRibbon;
         private Ribbon JoolTourRibbon;
         private Ribbon ServiceOperations;
         private Ribbon ServiceEngineer;
         private Ribbon ServiceScientist;

         private RibbonPool()
         {
            OnRibbonPoolReady = new List<Callback>();
            GameEvents.onGameStateCreated.Add(OnGameStateCreated);
         }

         protected override string CodeOf(Ribbon x)
         {
            return x.GetCode();
         }

         public Ribbon GetRibbonForCode(String code)
         {
            return base.GetElementForCode(code);
         }

         public Ribbon GetGrandTourRibbon(bool first)
         {
            //if(first) return FirstGrandTourRibbon;
            return GrandTourRibbon;
         }

         public Ribbon GetJoolTourRibbon(bool first)
         {
            //if (first) return FirstJoolTourRibbon;
            return JoolTourRibbon;
         }

         private Ribbon AddRibbon(Ribbon ribbon)
         {
            if(ribbon.IsEnabled())
            {
               Add(ribbon);
            }
            else
            {
               Log.Warning("ribbon "+ribbon.GetName()+" ("+ribbon.GetCode()+") disabled");
            }
            return ribbon;
         }

         private void AddCustomRibbon(int index, Ribbon ribbon)
         {
            if (ribbon.IsEnabled())
            {
               customRibbons.Add(ribbon);
               customMap.Add(index, ribbon);
               Add(ribbon);
            }
            else
            {
               Log.Warning("custom ribbon " + ribbon.GetName() + " (" + ribbon.GetCode() + ") disabled");
            }
         }

         private void CreateRibbons()
         {
            Log.Info("creating ribbons in pool");
            //

            // mapping for celestial bodies
            CelestialBodyMapper mapper = new CelestialBodyMapper();
            //
            foreach (CelestialBody body in PSystemManager.Instance.localBodies)
            {
               string bodyName = body.GetName();
               int basePrestige = mapper.GetBasePrestige(body);

               String BODY_RIBBON_PATH = mapper.GetRibbonPath(body, _RP)+bodyName;
               Log.Info("ribbon path for " + bodyName + " is " + BODY_RIBBON_PATH);

               Log.Detail("creating ribbons for " + bodyName + ", base prestige is " + basePrestige + "type is "+body.RevealType());

               Achievement soi = new SphereOfInfluenceAchievement(body, basePrestige);
               Ribbon soiRibbon = new Ribbon(BODY_RIBBON_PATH + "/SphereOfInfluence", soi);
               AddRibbon(soiRibbon);

               Ribbon evaOrbitRibbon = null;
               Ribbon evaRibbon = null;
               Ribbon orbitRibbon = null;
               Ribbon landingRibbon = null;
               Ribbon evagroundRibbon = null;
               Ribbon orbitDockedRibbon = null;
               Ribbon flagRibbon = null;
               Ribbon roverRibbon = null;
               Ribbon atmosphereRibbon = null;
               Ribbon closerSolarOrbitRibbon = null;
               for (int i = 1; i <= 2; i++)
               {
                  bool first = (i == 2);
                  String prefix = first ? "/First" : "/";
                  Achievement orbit = new OrbitAchievement(body, basePrestige + 10 + i, first);
                  Achievement atmosphere = new EnteringAtmosphereAchievement(body, basePrestige + 15 + i, first);
                  Achievement landing = new LandingAchievement(body, basePrestige + 20 + i, first);
                  Achievement flag = new PlantFlagAchievement(body, basePrestige + 25 + i, first);
                  Achievement eva = new EvaAchievement(body, basePrestige + 30 + i, first);
                  Achievement rover = new RoverAchievement(body, basePrestige + 35 + i, first);
                  Achievement evaorbit = new EvaOrbitAchievement(body, basePrestige + 40 + i, first);
                  Achievement evaground = new EvaGroundAchievement(body, basePrestige + 50 + i, first);
                  Achievement docked = new DockingAchievement(body, basePrestige + 60 + i, first);

                  AddRibbon(orbitRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "OrbitCapsule", orbit, first ? orbitRibbon : soiRibbon));
                  AddRibbon(evaRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "EvaSpace", eva, first ? evaRibbon : soiRibbon));
                  AddRibbon(evaOrbitRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "EvaOrbit", evaorbit, first ? evaOrbitRibbon : orbitRibbon));
                  AddRibbon(orbitDockedRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "OrbitCapsuleDocked", docked, first ? orbitDockedRibbon : orbitRibbon));

                  // some achievements are impossible on the sun and other bodies
                  if (!body.IsSun())
                  {
                     Log.Detail(bodyName + " is no sun");
                     // no flag, land, eva ground or rover on gas giants (Jool)
                     if (!mapper.IsGasGiant(body))
                     {
                        Log.Detail(bodyName + " is no gas giant");
                        AddRibbon(landingRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "Landing", landing, first ? landingRibbon : soiRibbon));
                        AddRibbon(evagroundRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "EvaGround", evaground, first ? evagroundRibbon : landingRibbon));
                        AddRibbon(flagRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "PlantFlag", flag, first ? flagRibbon : evagroundRibbon));
                        AddRibbon(roverRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "Rover", rover, first ? roverRibbon : evagroundRibbon));
                     }
                  }
                  // some achievements are impossible without atmosphere
                  if(body.atmosphere)
                  {
                     Log.Detail(bodyName + " has atmosphere");
                     // no atmosphere ribbon for Homeworld
                     if (!body.isHomeWorld)
                     {
                        AddRibbon(atmosphereRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "Atmosphere", atmosphere, first ? atmosphereRibbon : soiRibbon));
                     }
                  }
                  // achievemts for gas giants
                  if (mapper.IsGasGiant(body))
                  {
                     Log.Detail(bodyName + " is gas giant");
                     if (!first)
                     {
                        //  deep athmosphere
                        AddRibbon(new Ribbon(BODY_RIBBON_PATH + prefix + "DeepAtmosphere", new DeepAtmosphereArchievement(body, basePrestige + 90), soiRibbon));
                     }
                  }
                  // achievements for sun
                  if (body.IsSun())
                  {
                     Log.Detail(bodyName+" is sun");
                     // is Kerbin orbiting around this star? (if multiple star system)
                     if (body.IsSunOfHomeWorld())
                     {
                        Log.Detail("Homeworld is orbiting around " + bodyName);
                        CelestialBody innermost = body.Innermost();
                        if (innermost != null)
                        {
                           Log.Detail("innermost planet of " + bodyName + " is " + innermost.name);
                           closerSolarOrbitRibbon = new Ribbon(BODY_RIBBON_PATH + prefix + "CloserSolarOrbit", new CloserSolarOrbitAchievement(body, 50500 + i, innermost, first), first ? closerSolarOrbitRibbon : soiRibbon);
                           AddRibbon(closerSolarOrbitRibbon);
                        }
                        else
                        {
                           // cant be
                           Log.Warning("no innermost body for "+bodyName);
                        }
                     }
                  }
               }
            }
            // 
            // Deep Space
            Ribbon deepSpace = new Ribbon(_RP+"DeepSpace", new DeepSpaceAchievement(48000, false));
            Ribbon firstDeepSpace = new Ribbon(_RP+"FirstDeepSpace", new DeepSpaceAchievement(48001, true), deepSpace);
            Add(deepSpace);
            Add(firstDeepSpace);

            // Ribbons without a celestial body
            //
            // Multiple Missions
            Achievement flownFiveOrMoreMissions = new MissionsFlownAchievement(5, 56);
            Achievement flownTwentyOrMoreMissions = new MissionsFlownAchievement(20, 57);
            Achievement flownFiftyOrMoreMissions = new MissionsFlownAchievement(50, 58);
            Achievement flown100OrMoreMissions = new MissionsFlownAchievement(100, 59);
            Achievement flown200OrMoreMissions = new MissionsFlownAchievement(200, 60);
            Ribbon ribbonFiveOrMoreMissions = new Ribbon(_RP+"Missions5", flownFiveOrMoreMissions);
            Ribbon ribbonTwentyOrMoreMissions = new Ribbon(_RP + "Missions20", flownTwentyOrMoreMissions, ribbonFiveOrMoreMissions);
            Ribbon ribbonFiftyOrMoreMissions = new Ribbon(_RP + "Missions50", flownFiftyOrMoreMissions, ribbonTwentyOrMoreMissions);
            Ribbon ribbon100OrMoreMissions = new Ribbon(_RP + "Missions100", flown100OrMoreMissions, ribbonFiftyOrMoreMissions);
            Ribbon ribbon200OrMoreMissions = new Ribbon(_RP + "Missions200", flown200OrMoreMissions, ribbon100OrMoreMissions);
            AddRibbon(ribbonFiveOrMoreMissions);
            AddRibbon(ribbonTwentyOrMoreMissions);
            AddRibbon(ribbonFiftyOrMoreMissions);
            AddRibbon(ribbon100OrMoreMissions);
            AddRibbon(ribbon200OrMoreMissions);
            //
            // Dangerous EVA
            AddRibbon(new Ribbon(_RP + "DangerousEva", new DangerousEvaAchievement(100001)));
            //
            // Wet EVA
            Ribbon wetEvaRibbon = AddRibbon(new Ribbon(_RP + "WetEva", new WetEvaAchievement(9350, false)));
            AddRibbon(new Ribbon(_RP + "WetEvaFirst", new WetEvaAchievement(9351, true), wetEvaRibbon));
            //
            // Fast Orbit
            Achievement fastOrbit1 = new FastOrbitAchievement(250, 3101);
            Achievement fastOrbit2 = new FastOrbitAchievement(200, 3102);
            Achievement fastOrbit3 = new FastOrbitAchievement(150, 3103);
            Achievement fastOrbit4 = new FastOrbitAchievement(120, 3104);
            Ribbon ribbonFastOrbit1 = new Ribbon(_RP + "FastOrbit1", fastOrbit1);
            Ribbon ribbonFastOrbit2 = new Ribbon(_RP + "FastOrbit2", fastOrbit2, ribbonFastOrbit1);
            Ribbon ribbonFastOrbit3 = new Ribbon(_RP + "FastOrbit3", fastOrbit3, ribbonFastOrbit2);
            Ribbon ribbonFastOrbit4 = new Ribbon(_RP + "FastOrbit5", fastOrbit4, ribbonFastOrbit3); // FastOrbit4 skipped, because of upper/lower case problems in file name
            AddRibbon(ribbonFastOrbit1);
            AddRibbon(ribbonFastOrbit2);
            AddRibbon(ribbonFastOrbit3);
            AddRibbon(ribbonFastOrbit4);
            //
            // Mission Time
            Achievement missionTime5days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(5), 4901);
            Achievement missionTime20days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(20), 4902);
            Achievement missionTime50days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(50), 4903);
            Achievement missionTime100days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(100), 4904);
            Achievement missionTime500days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(500), 4905);
            Achievement missionTime2000days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(2000), 4906);
            Achievement missionTime5000days = new MissionTimeAchievement(Utils.ConvertDaysToSeconds(5000), 4907);
            Ribbon ribbonMissionTime5days = new Ribbon(_RP + "LongMissionTime1", missionTime5days);
            Ribbon ribbonMissionTime20days = new Ribbon(_RP + "LongMissionTime2", missionTime20days, ribbonMissionTime5days);
            Ribbon ribbonMissionTime50days = new Ribbon(_RP + "LongMissionTime3", missionTime50days, ribbonMissionTime20days);
            Ribbon ribbonMissionTime100days = new Ribbon(_RP + "LongMissionTime4", missionTime100days, ribbonMissionTime50days);
            Ribbon ribbonMissionTime500days = new Ribbon(_RP + "LongMissionTime5", missionTime500days, ribbonMissionTime100days);
            Ribbon ribbonMissionTime2000days = new Ribbon(_RP + "LongMissionTime6", missionTime2000days, ribbonMissionTime500days);
            Ribbon ribbonMissionTime5000days = new Ribbon(_RP + "LongMissionTime7", missionTime5000days, ribbonMissionTime2000days);
            AddRibbon(ribbonMissionTime5days);
            AddRibbon(ribbonMissionTime20days);
            AddRibbon(ribbonMissionTime50days);
            AddRibbon(ribbonMissionTime100days);
            AddRibbon(ribbonMissionTime500days);
            AddRibbon(ribbonMissionTime2000days);
            AddRibbon(ribbonMissionTime5000days);
            //
            // Endurance
            Achievement endurance20days = new SingleMissionTimeAchievement(Utils.ConvertDaysToSeconds(20), 4951);
            Achievement endurance50days = new SingleMissionTimeAchievement(Utils.ConvertDaysToSeconds(50), 4952);
            Achievement endurance125days = new SingleMissionTimeAchievement(Utils.ConvertDaysToSeconds(125), 4953);
            Achievement endurance500days = new SingleMissionTimeAchievement(Utils.ConvertDaysToSeconds(500), 4954);
            Achievement endurance2000days = new SingleMissionTimeAchievement(Utils.ConvertDaysToSeconds(2000), 4955);
            Ribbon ribbonEndurance20days = new Ribbon(_RP + "SingleMissionTime1", endurance20days);
            Ribbon ribbonEndurance50days = new Ribbon(_RP + "SingleMissionTime2", endurance50days, ribbonEndurance20days);
            Ribbon ribbonEndurance125days = new Ribbon(_RP + "SingleMissionTime3", endurance125days, ribbonEndurance50days);
            Ribbon ribbonEndurance500days = new Ribbon(_RP + "SingleMissionTime4", endurance500days, ribbonEndurance125days);
            Ribbon ribbonEndurance2000days = new Ribbon(_RP + "SingleMissionTime5", endurance2000days, ribbonEndurance500days);
            AddRibbon(ribbonEndurance20days);
            AddRibbon(ribbonEndurance50days);
            AddRibbon(ribbonEndurance125days);
            AddRibbon(ribbonEndurance500days);
            AddRibbon(ribbonEndurance2000days);
            //
            // Splashdown
            AddRibbon(new Ribbon(_RP + "Splashdown", new SplashdownAchievement(80)));
            //
            // EVA over water
            AddRibbon(new Ribbon(_RP + "EvaInWater", new EvaInHomeWatersAchievement(81)));
            //
            // Collision
            AddRibbon(new Ribbon(_RP + "Collision", new CollisionAchievement(0)));
            //
            // First in Space
            Ribbon ribbonFirstInSpace = new Ribbon(_RP + "FirstInSpace", new InSpaceAchievement(999000));
            AddRibbon(ribbonFirstInSpace);
            //
            // First EVA in Space
            Ribbon ribbonFirstEvaInSpace = new Ribbon(_RP + "FirstEvaInSpace", new FirstEvaInSpaceAchievement(899000));
            AddRibbon(ribbonFirstEvaInSpace);
            //
            // Solid Fuel Booster Launch
            Ribbon solidFuelLaunch10;
            Ribbon solidFuelLaunch20;
            AddRibbon(solidFuelLaunch10 = new Ribbon(_RP + "SolidFuelBooster10", new SolidFuelLaunchAchievement(10, 710)));
            AddRibbon(solidFuelLaunch20 = new Ribbon(_RP + "SolidFuelBooster20", new SolidFuelLaunchAchievement(20, 720), solidFuelLaunch10));
            AddRibbon(new Ribbon(_RP + "SolidFuelBooster30", new SolidFuelLaunchAchievement(30, 730), solidFuelLaunch20));

            //
            // G-Force
            Ribbon geeForce = null;
            for(int g=3; g<19; g++)
            {
               geeForce = new Ribbon(_RP + "HighGeeForce" + g, new HighGeeForceAchievement(g, 80 + g), geeForce);   
               AddRibbon(geeForce);
            }
            //
            // Heavy Vehicle
            Ribbon heavyVehicle1 = new Ribbon(_RP + "HeavyVehicle1", new HeavyVehicleAchievement(250, 401));
            Ribbon heavyVehicle2 = new Ribbon(_RP+"HeavyVehicle2", new HeavyVehicleAchievement(500, 402),  heavyVehicle1);
            Ribbon heavyVehicle3 = new Ribbon(_RP+"HeavyVehicle3", new HeavyVehicleAchievement(750, 403),  heavyVehicle2);
            Ribbon heavyVehicle4 = new Ribbon(_RP+"HeavyVehicle4", new HeavyVehicleAchievement(1000, 404), heavyVehicle3);
            Ribbon heavyVehicle5 = new Ribbon(_RP+"HeavyVehicle5", new HeavyVehicleAchievement(1500, 405), heavyVehicle4);
            Ribbon heavyVehicle6 = new Ribbon(_RP+"HeavyVehicle6", new HeavyVehicleAchievement(2000, 406), heavyVehicle5);
            Ribbon heavyVehicle7 = new Ribbon(_RP+"HeavyVehicle7", new HeavyVehicleAchievement(4000, 407), heavyVehicle6);
            AddRibbon(heavyVehicle1);
            AddRibbon(heavyVehicle2);
            AddRibbon(heavyVehicle3);
            AddRibbon(heavyVehicle4);
            AddRibbon(heavyVehicle5);
            AddRibbon(heavyVehicle6);
            AddRibbon(heavyVehicle7);
            //
            // Heavy Vehicle Landing
            Ribbon heavyVehicleLanding1 = new Ribbon(_RP+"HeavyVehicleLanding1", new HeavyVehicleLandAchievement(250, 421));
            Ribbon heavyVehicleLanding2 = new Ribbon(_RP+"HeavyVehicleLanding2", new HeavyVehicleLandAchievement(500, 422), heavyVehicleLanding1);
            Ribbon heavyVehicleLanding3 = new Ribbon(_RP+"HeavyVehicleLanding3", new HeavyVehicleLandAchievement(750, 423), heavyVehicleLanding2);
            Ribbon heavyVehicleLanding4 = new Ribbon(_RP+"HeavyVehicleLanding4", new HeavyVehicleLandAchievement(1000, 424), heavyVehicleLanding3);
            Ribbon heavyVehicleLanding5 = new Ribbon(_RP+"HeavyVehicleLanding5", new HeavyVehicleLandAchievement(1500, 425), heavyVehicleLanding4);
            Ribbon heavyVehicleLanding6 = new Ribbon(_RP+"HeavyVehicleLanding6", new HeavyVehicleLandAchievement(2000, 426), heavyVehicleLanding5);
            Ribbon heavyVehicleLanding7 = new Ribbon(_RP+"HeavyVehicleLanding7", new HeavyVehicleLandAchievement(4000, 427), heavyVehicleLanding6);
            AddRibbon(heavyVehicleLanding1);
            AddRibbon(heavyVehicleLanding2);
            AddRibbon(heavyVehicleLanding3);
            AddRibbon(heavyVehicleLanding4);
            AddRibbon(heavyVehicleLanding5);
            AddRibbon(heavyVehicleLanding6);
            AddRibbon(heavyVehicleLanding7);
            //
            // Heavy Vehicle Launch
            Ribbon heavyVehicleLaunch1 = new Ribbon(_RP+"HeavyVehicleLaunch1", new HeavyVehicleLaunchAchievement(250,  411));
            Ribbon heavyVehicleLaunch2 = new Ribbon(_RP+"HeavyVehicleLaunch2", new HeavyVehicleLaunchAchievement(500, 412), heavyVehicleLaunch1);
            Ribbon heavyVehicleLaunch3 = new Ribbon(_RP+"HeavyVehicleLaunch3", new HeavyVehicleLaunchAchievement(750, 413), heavyVehicleLaunch2);
            Ribbon heavyVehicleLaunch4 = new Ribbon(_RP+"HeavyVehicleLaunch4", new HeavyVehicleLaunchAchievement(1000, 414), heavyVehicleLaunch3);
            Ribbon heavyVehicleLaunch5 = new Ribbon(_RP+"HeavyVehicleLaunch5", new HeavyVehicleLaunchAchievement(1500, 415), heavyVehicleLaunch4);
            Ribbon heavyVehicleLaunch6 = new Ribbon(_RP+"HeavyVehicleLaunch6", new HeavyVehicleLaunchAchievement(2000, 416), heavyVehicleLaunch5);
            Ribbon heavyVehicleLaunch7 = new Ribbon(_RP+"HeavyVehicleLaunch7", new HeavyVehicleLaunchAchievement(4000, 417), heavyVehicleLaunch6);
            AddRibbon(heavyVehicleLaunch1);
            AddRibbon(heavyVehicleLaunch2);
            AddRibbon(heavyVehicleLaunch3);
            AddRibbon(heavyVehicleLaunch4);
            AddRibbon(heavyVehicleLaunch5);
            AddRibbon(heavyVehicleLaunch6);
            AddRibbon(heavyVehicleLaunch7);
            //
            // Mountain Ribbons
            Ribbon mountain1 = new Ribbon(_RP + "Mountain01", new MountainLandingAchievement(1500, 431));
            Ribbon mountain2 = new Ribbon(_RP + "Mountain02", new MountainLandingAchievement(2000, 432), mountain1);
            Ribbon mountain3 = new Ribbon(_RP + "Mountain03", new MountainLandingAchievement(2500, 433), mountain2);
            Ribbon mountain4 = new Ribbon(_RP + "Mountain04", new MountainLandingAchievement(3000, 434), mountain3);
            Ribbon mountain5 = new Ribbon(_RP + "Mountain05", new MountainLandingAchievement(3500, 435), mountain4);
            Ribbon mountain6 = new Ribbon(_RP + "Mountain06", new MountainLandingAchievement(4000, 436), mountain4);
            AddRibbon(mountain1);
            AddRibbon(mountain2);
            AddRibbon(mountain3);
            AddRibbon(mountain4);
            AddRibbon(mountain5);
            AddRibbon(mountain6);
            //
            // Fuel Left on Landing ribbons
            Ribbon nofuel1 = new Ribbon(_RP + "NoFuel01", new NoFuelLandingAchievement(5, 441));
            Ribbon nofuel2 = new Ribbon(_RP + "NoFuel02", new NoFuelLandingAchievement(1, 442), nofuel1);
            AddRibbon(nofuel1);
            AddRibbon(nofuel2);
            //
            // Polar ribbons
            Ribbon northPolar = new Ribbon(_RP + "NorthPolar", new PolarLandingAchievement("North", 491, false));
            Ribbon northPolar1st = new Ribbon(_RP + "FirstNorthPolar", new PolarLandingAchievement("North", 492, true), northPolar);
            Ribbon southPolar = new Ribbon(_RP + "SouthPolar", new PolarLandingAchievement("South", 493, false));
            Ribbon southPolar1st = new Ribbon(_RP + "FirstSouthPolar", new PolarLandingAchievement("South", 494, true), southPolar);
            AddRibbon(northPolar);
            AddRibbon(northPolar1st);
            AddRibbon(southPolar);
            AddRibbon(southPolar1st);
            //
            // Eva Time
            Ribbon evaTime1 = new Ribbon(_RP+"TotalEva1", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(1),   471));
            Ribbon evaTime2 = new Ribbon(_RP+"TotalEva2", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(2),   472), evaTime1);
            Ribbon evaTime3 = new Ribbon(_RP+"TotalEva3", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(6),   473), evaTime2);
            Ribbon evaTime4 = new Ribbon(_RP+"TotalEva4", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(12),  474), evaTime3);
            Ribbon evaTime5 = new Ribbon(_RP+"TotalEva5", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(24),  475), evaTime4);
            Ribbon evaTime6 = new Ribbon(_RP+"TotalEva6", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(48),  476), evaTime5);
            Ribbon evaTime7 = new Ribbon(_RP+"TotalEva7", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(96),  477), evaTime6);
            Ribbon evaTime8 = new Ribbon(_RP+"TotalEva8", new EvaTotalTimeAchievement(Utils.ConvertHoursToSeconds(192), 478), evaTime7);
            AddRibbon(evaTime1);
            AddRibbon(evaTime2);
            AddRibbon(evaTime3);
            AddRibbon(evaTime4);
            AddRibbon(evaTime5);
            AddRibbon(evaTime6);
            AddRibbon(evaTime7);
            AddRibbon(evaTime8);
            //
            // EVA Endurance 
            Ribbon evaEndurance1 = new Ribbon(_RP+"Eva1", new EvaTimeAchievement(2 * Utils.ConvertHoursToSeconds(1) / 6, 451));
            Ribbon evaEndurance2 = new Ribbon(_RP+"Eva2", new EvaTimeAchievement(3 * Utils.ConvertHoursToSeconds(1) / 6, 452), evaEndurance1);
            Ribbon evaEndurance3 = new Ribbon(_RP+"Eva3", new EvaTimeAchievement(4 * Utils.ConvertHoursToSeconds(1) / 6, 453), evaEndurance2);
            Ribbon evaEndurance4 = new Ribbon(_RP+"Eva4", new EvaTimeAchievement(5 * Utils.ConvertHoursToSeconds(1) / 6, 454), evaEndurance3);
            Ribbon evaEndurance5 = new Ribbon(_RP+"Eva5", new EvaTimeAchievement(1 * Utils.ConvertHoursToSeconds(1),     455), evaEndurance4);
            Ribbon evaEndurance6 = new Ribbon(_RP+"Eva6", new EvaTimeAchievement(3 * Utils.ConvertHoursToSeconds(1) / 2, 456), evaEndurance5);
            Ribbon evaEndurance7 = new Ribbon(_RP+"Eva7", new EvaTimeAchievement(1 * Utils.ConvertHoursToSeconds(2),     457), evaEndurance6);
            Ribbon evaEndurance8 = new Ribbon(_RP+"Eva8", new EvaTimeAchievement(1 * Utils.ConvertHoursToSeconds(3),     458), evaEndurance7);
            Ribbon evaEndurance9 = new Ribbon(_RP+"Eva9", new EvaTimeAchievement(1 * Utils.ConvertHoursToSeconds(4),     459), evaEndurance8);
            Ribbon evaEndurance10 = new Ribbon(_RP+"Eva10", new EvaTimeAchievement(1 * Utils.ConvertHoursToSeconds(5),   460), evaEndurance9);
            AddRibbon(evaEndurance1);
            AddRibbon(evaEndurance2);
            AddRibbon(evaEndurance3);
            AddRibbon(evaEndurance4);
            AddRibbon(evaEndurance5);
            AddRibbon(evaEndurance6);
            AddRibbon(evaEndurance7);
            AddRibbon(evaEndurance8);
            AddRibbon(evaEndurance9);
            AddRibbon(evaEndurance10);
            //
            // Mach
            Ribbon mach1 = new Ribbon(_RP+"Mach1", new MachNumberAchievement(1, 481));
            Ribbon mach2 = new Ribbon(_RP+"Mach2", new MachNumberAchievement(2, 482),  mach1);
            Ribbon mach3 = new Ribbon(_RP+"Mach3", new MachNumberAchievement(3, 483),  mach2);
            Ribbon mach4 = new Ribbon(_RP+"Mach4", new MachNumberAchievement(4, 484),  mach3);
            Ribbon mach5 = new Ribbon(_RP+"Mach5", new MachNumberAchievement(5, 485),  mach4);
            Ribbon mach6 = new Ribbon(_RP+"Mach6", new MachNumberAchievement(6, 486),  mach5);
            Ribbon mach7 = new Ribbon(_RP+"Mach7", new MachNumberAchievement(8, 487),  mach6);
            Ribbon mach8 = new Ribbon(_RP+"Mach8", new MachNumberAchievement(10, 488), mach7);
            AddRibbon(mach1);
            AddRibbon(mach2);
            AddRibbon(mach3);
            AddRibbon(mach4);
            AddRibbon(mach5);
            AddRibbon(mach6);
            AddRibbon(mach7);
            AddRibbon(mach8);
            //
            // Contracts
            Ribbon contracts1 = new Ribbon(_RP+"Contracts1", new ContractsAchievement(5, 61));
            Ribbon contracts2 = new Ribbon(_RP+"Contracts2", new ContractsAchievement(10, 62), contracts1);
            Ribbon contracts3 = new Ribbon(_RP+"Contracts3", new ContractsAchievement(20, 63), contracts2);
            Ribbon contracts4 = new Ribbon(_RP+"Contracts4", new ContractsAchievement(40, 64), contracts3);
            Ribbon contracts5 = new Ribbon(_RP+"Contracts5", new ContractsAchievement(60, 65), contracts4);
            AddRibbon(contracts1);
            AddRibbon(contracts2);
            AddRibbon(contracts3);
            AddRibbon(contracts4);
            AddRibbon(contracts5);
            //
            // Contract Prestige
            Ribbon significantContract = new Ribbon(_RP+"SignificantContract", new ContractPrestigeAchievement(Contracts.Contract.ContractPrestige.Significant, 68));
            Ribbon exceptionalContract = new Ribbon(_RP + "ExceptionalContract", new ContractPrestigeAchievement(Contracts.Contract.ContractPrestige.Exceptional, 69), significantContract);
            AddRibbon(significantContract);
            AddRibbon(exceptionalContract);
            //
            // Lost And Found
            // (not working)
            //AddRibbon(new Ribbon(_RP + "LostAndFound", new LostAndFoundAchievement(99)));
            //
            // Research/Science
            Ribbon research1 = new Ribbon(_RP + "Research1", new ResearchAchievement(1, 10, 201));
            Ribbon research2 = new Ribbon(_RP + "Research2", new ResearchAchievement(2, 50, 202), research1);
            Ribbon research3 = new Ribbon(_RP + "Research3", new ResearchAchievement(3, 100, 203), research2);
            Ribbon research4 = new Ribbon(_RP + "Research4", new ResearchAchievement(4, 150, 204), research3);
            Ribbon research5 = new Ribbon(_RP + "Research5", new ResearchAchievement(5, 200, 205), research4);
            Ribbon research6 = new Ribbon(_RP + "Research6", new ResearchAchievement(6, 400, 206), research5);
            Ribbon research7 = new Ribbon(_RP + "Research7", new ResearchAchievement(7, 600, 207), research6);
            Ribbon research8 = new Ribbon(_RP + "Research8", new ResearchAchievement(8, 1000, 208), research7);
            Ribbon research9 = new Ribbon(_RP + "Research9", new ResearchAchievement(9, 1500, 209), research8);
            Ribbon research10 = new Ribbon(_RP + "Research10", new ResearchAchievement(10, 2000, 210), research9);
            AddRibbon(research1);
            AddRibbon(research2);
            AddRibbon(research3);
            AddRibbon(research4);
            AddRibbon(research5);
            AddRibbon(research6);
            AddRibbon(research7);
            AddRibbon(research8);
            AddRibbon(research9);
            AddRibbon(research10);
            //
            // Specialists
            AddRibbon(this.ServiceOperations = new Ribbon(_RP+"ServiceOperations", new PilotServiceAchievement(12)));
            AddRibbon(this.ServiceEngineer   = new Ribbon(_RP+"ServiceEngineer", new EngineerServiceAchievement(11)));
            AddRibbon(this.ServiceScientist  = new Ribbon(_RP+"ServiceScientist", new ScientistServiceAchievement(10)));
            //
            // Passenger Transport
            Ribbon transport1 = new Ribbon(_RP + "PassengerTransport1", new PassengerTransportAchievement(1, 110));
            Ribbon transport2 = new Ribbon(_RP + "PassengerTransport2", new PassengerTransportAchievement(2, 111), transport1);
            Ribbon transport3 = new Ribbon(_RP + "PassengerTransport3", new PassengerTransportAchievement(3, 112), transport2);
            Ribbon transport4 = new Ribbon(_RP + "PassengerTransport4", new PassengerTransportAchievement(4, 113), transport3);
            Ribbon transport5 = new Ribbon(_RP + "PassengerTransport5", new PassengerTransportAchievement(5, 114), transport4);
            AddRibbon(transport1);
            AddRibbon(transport2);
            AddRibbon(transport3);
            AddRibbon(transport4);
            AddRibbon(transport5);
            //
            //
            // Records
            AddRibbon(new Ribbon(_RP + "DistanceRecord", new DistanceRecordAchievement(551)));
            AddRibbon(new Ribbon(_RP + "SpeedRecord", new SpeedRecordAchievement(552)));
            AddRibbon(new Ribbon(_RP + "DepthRecord", new DepthRecordAchievement(553)));
            AddRibbon(new Ribbon(_RP + "AltitudeRecord", new AltitudeRecordAchievement(554)));
            //
            // easter eggs
            AddRibbon(new Ribbon(_RP+"XM2014A", new XMas2014Achievement(2)));
            AddRibbon(new Ribbon(_RP + "XM", new DateofYearAchievement(24,12,26,12,"X-mas","Awarded for any kind of duty on xmas",1)));
            AddRibbon(new Ribbon(_RP + "July4", new DateofYearAchievement(4,7,4,7,"4th July","Awarded for any kind of duty on 4th of July",3)));
            AddRibbon(new Ribbon(_RP + "Anniversary", new DateofYearAchievement(27, 4, 27, 4, "Anniversary", "Awarded for any kind of duty on any anniversary of the kerbal space program", 4)));
            //
            // dont know how to detect yet
            // Achievement missionAbort = new MissionAbortedAchievement(55);
            // AddRibbon(new Ribbon(_RP+"MissionAborted", missionAbort));

            // special ribbons for direct award
            //
            // Grand Tour
            this.GrandTourRibbon = new Ribbon(_RP+"GrandTour", new GrandTourAchievement(9999, false));
            //this.FirstGrandTourRibbon = new Ribbon(_RP+"FirstGrandTour", new GrandTourAchievement(55101, true), this.GrandTourRibbon);
            AddRibbon(this.GrandTourRibbon);
            //AddRibbon(this.FirstGrandTourRibbon);
            // Jool Tour
            CelestialBody jool = Utils.GetCelestialBody("Jool");
            if(jool!=null)
            {
               this.JoolTourRibbon = new Ribbon(_RP + "JoolTour", new JoolTourAchievement(mapper.GetBasePrestige(jool) + 98, false));
               AddRibbon(this.JoolTourRibbon);
            }

            Sort();

            // just for debugging
            //Persistence.WriteSupersedeChain(this);

            Log.Info("ribbon pool created");
         }

         private void CreateCustomRibbons()
         {
            Log.Info("creating custom ribbons");
            // custom ribbons provided by nothke
            CreateCustomRibbon(0, "Diamond", "Diamond", "The highest honor awarded for exceptional courage, unselfishness and valor");
            CreateCustomRibbon(1, "InterSidera", "Inter Sidera", "\"Among the Stars\" - A commemorative ribbon for fallen kerbonauts");
            CreateCustomRibbon(2, "Kerbalkind", "Kerbalkind", "Honorary retirement award for service to Kerbalkind");
            // --------------- 3: not working
            CreateCustomRibbon(4, "Station", "Station", "custom station ribbon");
            CreateCustomRibbon(5, "Spaceplane", "Spaceplane", "custom spaceplane ribbon");
            CreateCustomRibbon(6, "CertifiedBadass", "Certified Badass", "Awarded for ludicrous, near-impossible and brave endeavor");
            // custom ribbons provided by SmarterThanMe
            CreateCustomRibbon(21, "STM01", "Test Pilot", "Awarded for courage in flying in experimental craft");
            CreateCustomRibbon(22, "STM02", "Expeditionary Command", "Awarded for being in command of a significant expedition, station or base");
            CreateCustomRibbon(23, "STM03", "Mission Command", "Awarded for being in command of a small scale mission");
            CreateCustomRibbon(24, "STM04", "Chief Scientist", "Awarded for being a Lead Scientist on a significant expedition, or a mission with a major scientific task", this.ServiceScientist);
            CreateCustomRibbon(25, "STM05", "Chief Engineering", "Awarded for being the Lead Engineer on a significant expedition or mission with a major engineering task", this.ServiceEngineer);
            CreateCustomRibbon(26, "STM06", "Space Search & Rescue", "Awarded for being involved in a search and rescue mission in space");
            CreateCustomRibbon(27, "STM07", "Wings", "Awarded for piloting a plane in atmosphere");
            CreateCustomRibbon(28, "STM08", "Space Wings", "Awarded for piloting a spaceplane in and out of atmosphere");
            CreateCustomRibbon(29, "STM09", "Chief Operations", "Awarded for being the lead officer in charge of operations on a significant expedition or mission with a major piloting task or series of tasks", this.ServiceOperations);
            CreateCustomRibbon(30, "STM10", "Arrow", ""); 
            CreateCustomRibbon(31, "STM11", "Qualified Scientist", "Awarded for having the necessary skills and knowledge, and completing the space mission training program");
            CreateCustomRibbon(32, "STM12", "Qualified Operations", "Awarded for having the necessary skills and knowledge, and completing the space mission training program");
            CreateCustomRibbon(33, "STM13", "Qualified Engineering", "Awarded for having the necessary skills and knowledge, and completing the space mission training program");
            CreateCustomRibbon(34, "STM14", "Specialist Scientist", "Awarded for developing and demonstrating specialist aptitude in field activities for the Kerbal Space Program", 31);
            CreateCustomRibbon(35, "STM15", "Specialist Operations", "Awarded for developing and demonstrating specialist aptitude in field activities for the Kerbal Space Program", 32);
            CreateCustomRibbon(36, "STM16", "Specialist Engineering", "Awarded for developing and demonstrating specialist aptitude in field activities for the Kerbal Space Program", 33);
            CreateCustomRibbon(37, "STM17", "Senior Scientist", "Awarded for leadership, significant experience and outstanding technical aptitude in field activities for the Kerbal Space Program", 34);
            CreateCustomRibbon(38, "STM18", "Senior Operations", "Awarded for leadership, significant experience and outstanding technical aptitude in field activities for the Kerbal Space Program", 35);
            CreateCustomRibbon(39, "STM19", "Senior Engineering", "Awarded for leadership, significant experience and outstanding technical aptitude in field activities for the Kerbal Space Program", 36);
            CreateCustomRibbon(40, "STM20", "STM20", "no description");
            CreateCustomRibbon(41, "STM21", "STM21", "no description");
            CreateCustomRibbon(42, "STM22", "Repair In Danger", "Awarded for courage demonstrated in engaging in repair activities in dangerous circumstances");
            CreateCustomRibbon(43, "STM23", "Rover Specialist", "Awarded for having developed skills and expertise as a driver of a land vehicle");
            CreateCustomRibbon(44, "STM24", "EVA Specialist", "Awarded for having developed skills and expertise in conducting and overseeing EVA activities");
            CreateCustomRibbon(45, "STM25", "Apprentice Chef", "no description");
            CreateCustomRibbon(46, "STM26", "Chef de Partie ", "no description", 45);
            CreateCustomRibbon(47, "STM27", "Sous Chef", "no description", 46);
            CreateCustomRibbon(48, "STM28", "Chef de Cuisine", "no description", 47);    

            // custom ribbons provided by helldiver
            CreateCustomRibbon(70, "Helldiver01", "Bronze Heli Pilot", "no description");
            CreateCustomRibbon(71, "Helldiver02", "Silver Heli Pilot", "no description", 70);
            CreateCustomRibbon(72, "Helldiver03", "Bronze S25 Mission Specialist", "no description", 71);
            CreateCustomRibbon(73, "Helldiver04", "Silver S25 Mission Specialist", "no description", 72);
            CreateCustomRibbon(74, "Helldiver05", "Bronze KSO Mission Specialist", "no description");
            CreateCustomRibbon(75, "Helldiver06", "Silver KSO Mission Specialist", "no description", 74);
            CreateCustomRibbon(76, "Helldiver07", "Bronze Shuttle Pilot", "no description");
            CreateCustomRibbon(77, "Helldiver08", "Silver Shuttle Pilot", "no description", 76);
            // custom ribbons provided by Wyrmshadow
            CreateCustomRibbon(80, "Nation01", "United Kerbdom", "");
            CreateCustomRibbon(81, "Nation02", "Kovjet Coprorative", "");
            CreateCustomRibbon(82, "Nation03", "Republic of Kinesa", "");
            CreateCustomRibbon(83, "Nation04", "The Neutral Nation", "");
            CreateCustomRibbon(84, "Nation05", "KSA", "");
            CreateCustomRibbon(85, "Nation06", "Kryades", "");
            CreateCustomRibbon(86, "Nation07", "KSA United", "");
            CreateCustomRibbon(87, "Nation08", "Kerman Empire", "");
            CreateCustomRibbon(88, "Nation09", "Kanada", "");
            CreateCustomRibbon(89, "Nation10", "Kitaly", "");
            CreateCustomRibbon(90, "Nation11", "Mexika", "");
            CreateCustomRibbon(91, "Nation12", "Brasilika", "");
            CreateCustomRibbon(92, "Nation13", "Kapan", "");
            CreateCustomRibbon(93, "Nation14", "Koland", "");
            CreateCustomRibbon(94, "Nation15", "United Kerbalkind", "");

            // generic custom ribbons
            int CUSTOM_BASE_INDEX = 100;
            for (int i = 0; i < 20; i++)
            {
               CustomAchievement achievement = new CustomAchievement(CUSTOM_BASE_INDEX + i, -2000 + i);
               int nr = i + 1;
               String ss = nr.ToString("00");
               achievement.SetName(ss + " Custom");
               achievement.SetDescription(ss + " Custom");
               Ribbon ribbon = new Ribbon(_RP + "Custom" + ss, achievement);
               AddCustomRibbon(CUSTOM_BASE_INDEX + i,ribbon);
            }

            // custom ribbon packs
            Log.Info("scanning for ribbon packs...");
            ScanForRibbonPacks(Constants.GAMEDATA_PATH);

            Log.Info("custom ribbons created (" + customRibbons.Count + " custom ribbons)");
         }

         public Ribbon CreateCustomRibbon(int index, String filename, String name, String text, Ribbon supersede = null)
         {
            Log.Detail("creating custom ribbon " + name + " (#" + index + ")");
            CustomAchievement achievement = new CustomAchievement(index, -1000 + index);
            Ribbon ribbon = new Ribbon(_RP+filename, achievement, supersede);
            achievement.SetName(name);
            achievement.SetDescription(text);
            AddCustomRibbon(index, ribbon);
            return ribbon;
         }


         public Ribbon CreateCustomRibbon(int index, String filename, String name, String text, int supersedeNr )
         {
            Log.Detail("creating custom ribbon " + name + " (#" + index + ")");
            CustomAchievement achievement = new CustomAchievement(index, -1000 + index);
            Ribbon supersede;
            try
            {
               supersede = customMap[supersedeNr];            
            }
            catch(KeyNotFoundException)
            {
               supersede = null;
            }
            Ribbon ribbon = new Ribbon(_RP+filename, achievement, supersede);
            achievement.SetName(name);
            achievement.SetDescription(text);
            AddCustomRibbon(index, ribbon);
            return ribbon;
         }

         public List<Ribbon> GetCustomRibbons()
         {
            return customRibbons;
         }

         public void ScanForRibbonPacks(String basefolder)
         {
            if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("scanning folder " + basefolder + " for ribbon packs");
            try
            {
               foreach (String folder in Directory.GetDirectories(basefolder))
               {
                  String filename = folder + "/"+FILENAME_RIBBONPACK;
                  if (File.Exists(filename))
                  {
                     Log.Info("custom ribbon pack found in " + folder);
                     RibbonPack pack = new RibbonPack(filename);
                     // adding ribbons of Ribbon Pack
                     foreach (Ribbon ribbon in pack)
                     {
                        // cast is safe
                        CustomAchievement achievement = (CustomAchievement)ribbon.GetAchievement();
                        int index = achievement.GetIndex();
                        AddCustomRibbon(index, ribbon);
                     }
                  }
                  ScanForRibbonPacks(folder);
               }
            }
            catch (System.Exception e)
            {
               Log.Error("failed to scan for custom ribbon packs ("+e.GetType()+":"+e.Message+")");
            }
         }

         private void OnGameStateCreated(Game game)
         {
            // we won't load ribbons twice
            if (ribbonsCreated) return;
            // create ribbons
            CreateRibbons();
            CreateCustomRibbons();
            //
            Log.Detail("ribbon pool is ready");
            foreach(Callback callback in OnRibbonPoolReady)
            {
               callback();
            }
            // and guard this
            ribbonsCreated = true;

            // and log all ribbons
            dumpToLog();
         }

         private void dumpToLog()
         {
            List<Ribbon> all = new List<Ribbon>(this);

            all.Sort(
               delegate(Ribbon left, Ribbon right)
               {
                  if (left.GetAchievement().prestige < right.GetAchievement().prestige) return -1;
                  if (left.GetAchievement().prestige > right.GetAchievement().prestige) return 1;
                  return 0; 
               });

            if (Log.IsLogable(Log.LEVEL.DETAIL))
            {
               int lastPrestige = int.MinValue;
               Log.Detail("list of all ribbons:");
               foreach(Ribbon ribbon in all)
               {
                  int prestige = ribbon.GetAchievement().prestige;
                  //
                  // check for multiple prestiges
                  string warn;
                  if(prestige==lastPrestige)
                  {
                     warn = " [WARNING: prestige used multiple times]";
                  }
                  else
                  {
                     warn = "";
                  }
                  lastPrestige = prestige;
                  //
                  // and log it
                  Log.Detail(prestige + " ribbon "+ribbon.GetName()+" (code "+ribbon.GetCode()+") "+warn);
               }
            }
         }

         public bool IsReady()
         {
            return ribbonsCreated;
         }

         public Ribbon RegisterExternalRibbon(String code, String pathToRibbonTexture, String name, String description, bool first = false, int prestige = 0)
         {
            Log.Info("adding external ribbon " + name + " (code "+code+") ");
            Achievement achievement = new ExternalAchievement(code, name, prestige, first, description);
            Ribbon ribbon = new Ribbon(pathToRibbonTexture, achievement);
            externalRibbons.Add(ribbon);
            Add(ribbon);
            return ribbon;
         }

         public Ribbon RegisterCustomRibbon(int id, String pathToRibbonTexture, String name, String description, int prestige = 0)
         {
            Log.Info("adding external custom ribbon " + name + " (id " + id + ") ");
            if(id<=CUSTOM_RIBBON_BASE)
            {
               Log.Error("illegal custom ribbon id (has to be greater than "+CUSTOM_RIBBON_BASE+")");
               return null;
            }
            CustomAchievement achievement = new CustomAchievement(id, prestige);
            Ribbon ribbon = new Ribbon(pathToRibbonTexture, achievement);
            achievement.SetName(name);
            achievement.SetDescription(description);
            AddCustomRibbon(id, ribbon); 
            return ribbon;
         }
      }
   }
}
