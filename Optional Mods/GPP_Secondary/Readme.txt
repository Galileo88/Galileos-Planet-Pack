GPP_Secondary is a mediator mod designed to easily and properly enable Galileo's Planet Pack to operate as a secondary system. It is technically a complete package but requires you to make just one small set of changes unique to your primary star system mod.

Other primary system mods no longer need to:
* Add a star and call it Ciro.
* Reparent GPP planets.
* Remove KSC from Gael.
* Re-add the stock planets. 

The only required bit on your part is to insert the following in your mod and fill its fields. Ciro's SOI is 3.5E+12 (3.5 Terameters) by default so Grannus does not escape when it nears its apoapsis, and its SMA is 7E+12 (7 Terameters) from the center of the universe.

@Kopernicus:NEEDS[GPP_Secondary]
{
	@Body[Ciro]
	{
		@Orbit
		{
			@referenceBody = 
			@inclination = 
			@eccentricity = 
			@semiMajorAxis = 
			@longitudeOfAscendingNode = 
			@argumentOfPeriapsis = 
			@meanAnomalyAtEpoch = 
			@epoch = 
		}
	}
}