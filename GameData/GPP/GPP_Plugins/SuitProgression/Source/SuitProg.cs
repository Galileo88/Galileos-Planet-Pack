using System;
using System.Linq;
using UnityEngine;
namespace SuitProg
{
	[KSPAddon(KSPAddon.Startup.AllGameScenes, false)]//KSPAddon.Startup.AllGameScenes means that the plugin will exist across all scenes ecept for the main menu
	public class SuitProg : MonoBehaviour
	{
		public void Start()//start happens the first time the scene is loaded
		{
			SetMaxTemp.run();//call the run program
		}
	}
	class SetMaxTemp
	{
		public static void run()
		{
			Debug.Log("SuitProg: run SetMaxTemp");
			try//this code is in a try catch in case something strange is going on (no EVA parts) becuase uncaught exceptions = bad
			{
				var evaParts = PartLoader.LoadedPartsList.Where(p => p.name.Equals("kerbalEVA") || p.name.Equals("kerbalEVAfemale"));
				//makes a list called evaParts and looks through all loaded parts for the 2 EVA parts and adds them to the lsit
				foreach (var evaPart in evaParts)//calls editMaxHeat on each part in the list
				{
					EditMaxHeat(evaPart);
				}
			}
			catch (Exception ex)//in case there's a problem (not sure if needed but in TAC code and no reason to remove it)
			{
				Debug.LogError("SuitProg: Failed to edit EVA max temp.\n" + ex.Message + "\n" + ex.StackTrace);
			}
		}
		static void EditMaxHeat(AvailablePart part)//not sure what AvailiblePart is but part of TAC code and it just works
		{
			Part prefabPart = part.partPrefab;//takes the AvailablePart and calls its prefabPart which lets you edit it (I think...again this is from TAC)
			//ScenarioUpgradeableFacilities.GetFacilityLevel(SpaceCenterFacility.AstronautComplex) checks the AC level: returns 0,.5,1 for levels 1,2,3
			prefabPart.maxTemp = 800 + 800 * ScenarioUpgradeableFacilities.GetFacilityLevel(SpaceCenterFacility.AstronautComplex);//base of 800 + 0, 400 or 800
			prefabPart.skinMaxTemp = 800 + 800 * ScenarioUpgradeableFacilities.GetFacilityLevel(SpaceCenterFacility.AstronautComplex);
			Debug.Log("SuitProg: AC level = " + ScenarioUpgradeableFacilities.GetFacilityLevel(SpaceCenterFacility.AstronautComplex));
			Debug.Log("SuitProg: maxTemp set to " + prefabPart.maxTemp);
			Debug.Log("SuitProg: skinMaxTemp set to " + prefabPart.skinMaxTemp);
		}
	}
}
