namespace KerbalRenamer
{
    internal class ProtoCustomVeteran
    {
        internal string name;
        internal ProtoCrewMember.Gender gender;
        internal string trait = "Pilot";
        internal bool isBadass;
        internal float courage;
        internal float stupidity;

        internal ProtoCustomVeteran(ConfigNode config)
        {
            name = config.GetValue("name");
            gender = (ProtoCrewMember.Gender)ConfigNode.ParseEnum(typeof(ProtoCrewMember.Gender), config.GetValue("gender"));
            trait = config.GetValue("trait");
            isBadass = bool.Parse(config.GetValue("isBadass"));
            courage = float.Parse(config.GetValue("courage"));
            stupidity = float.Parse(config.GetValue("stupidity"));
        }
    }

    internal static class CustomKerbals
    {
        // First 4 Veteran Names
        internal static bool Veteran(ProtoCrewMember kerbal)
        {
            switch (kerbal.name)
            {
                case "Jebediah Kerman":
                    return Veteran(kerbal, 0);
                case "Bill Kerman":
                    return Veteran(kerbal, 1);
                case "Bob Kerman":
                    return Veteran(kerbal, 2);
                case "Valentina Kerman":
                    return Veteran(kerbal, 3);
                default:
                    return false;
            }
        }

        // First 4 Veteran Kerbals
        static bool Veteran(ProtoCrewMember kerbal, int index)
        {
            if (Settings.preserveOriginals)
            {
                return Original(kerbal, index);
            }
            else
            {
                return Custom(kerbal, index);
            }
        }

        // Original Veterans
        internal static bool Original(ProtoCrewMember kerbal, int index)
        {
            switch (index)
            {
                case 0:
                    kerbal.UpdateTo("Jebediah " + Settings.cultures[0].DefaultLastName(ProtoCrewMember.Gender.Male), ProtoCrewMember.Gender.Male, "Pilot", Settings.preserveOriginals, true, 0.5f, 0.5f);
                    return true;
                case 1:
                    kerbal.UpdateTo("Bob " + Settings.cultures[0].DefaultLastName(ProtoCrewMember.Gender.Male), ProtoCrewMember.Gender.Male, "Scientist", Settings.preserveOriginals, false, 0.3f, 0.1f);
                    return true;
                case 2:
                    kerbal.UpdateTo("Bill " + Settings.cultures[0].DefaultLastName(ProtoCrewMember.Gender.Male), ProtoCrewMember.Gender.Male, "Engineer", Settings.preserveOriginals, false, 0.5f, 0.8f);
                    return true;
                case 3:
                    kerbal.UpdateTo("Valentina " + Settings.cultures[0].DefaultLastName(ProtoCrewMember.Gender.Female), ProtoCrewMember.Gender.Female, "Pilot", Settings.preserveOriginals, true, 0.55f, 0.4f);
                    return true;
            }

            if (Settings.preserveOriginals)
                return Custom(kerbal, index - 4);

            return false;
        }

        // GPP Developers
        internal static bool Custom(ProtoCrewMember kerbal, int index)
        {
            if (Settings.CustomVeterans.Count > index)
            {
                ProtoCustomVeteran custom = Settings.CustomVeterans[index];

                kerbal.UpdateTo(custom.name, custom.gender, custom.trait, !Settings.preserveOriginals, custom.isBadass, custom.courage, custom.stupidity);
                return true;
            }

            if (!Settings.preserveOriginals)
                return Original(kerbal, index - Settings.CustomVeterans.Count);

            return false;
        }
    }
}
