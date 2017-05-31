GPP_Secondary is a setup package designed to easily enable GPP to operate as a secondary system. It is not a complete package and requires you to add the final bits unique to your primary star system mod.

Other primary system mods no longer need to:
* Add a star and call it Ciro.
* Reparent GPP planets.
* Remove KSC from Gael.
* Re-add the stock planets. 

The only required bit on your part is to insert this in your mod and fill its fields.

@Kopernicus:AFTER[GPP_Secondary]
{
	@Body[Ciro]
	{
		@Properties
		{
			@sphereOfInfluence = 
			@hillSphere = 
		}
		%Orbit
		{
			%referenceBody = 
			%inclination = 
			%eccentricity = 
			%semiMajorAxis = 
			%longitudeOfAscendingNode = 
			%argumentOfPeriapsis = 
			%meanAnomalyAtEpoch = 
			%epoch = 
			%color = 
		}
	}
}