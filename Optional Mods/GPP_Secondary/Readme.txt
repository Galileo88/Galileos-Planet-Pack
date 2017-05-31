GPP_Secondary is a mediator mod designed to easily and properly enable Galileo's Planet Pack to operate as a secondary system. It is technically a complete package but requires you to make just one small set of changes unique to your primary star system mod.

Primary features:
* Hide Ciro's orbit for KSS.
* Prevent replacing Kerbin World Firsts agent with Gaelean Historians Collective.
* Prevent renaming stock solar system to Ciro system.
* Remove Flight Globals so GPP sequence does not clip the sequence of another star system.
* Insert proper Ciro and Gael to end the use of filler copies of Kerbin and generic Sun.

Other star system mods no longer need to:
* Add a star and call it Ciro.
* Reparent GPP planets.
* Remove KSC from Gael.
* Re-add the stock planets. 

Ciro's SOI is 3.5E+12 (3.5 Terameters) by default so Grannus SOI does not exceed Ciro SOI at Grannus apoapsis, and Ciro's SMA is 7E+12 (7 Terameters) from the center of the universe.

The only required bit on your part is to insert the following in your mod and fill its fields.

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