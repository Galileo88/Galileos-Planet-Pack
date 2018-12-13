namespace KerbalRenamer
{
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
                    kerbal.UpdateTo("Jebediah Gaelan", ProtoCrewMember.Gender.Male, "Pilot", Settings.preserveOriginals, true, 0.5f, 0.5f);
                    return true;
                case 1:
                    kerbal.UpdateTo("Bob Gaelan", ProtoCrewMember.Gender.Male, "Scientist", Settings.preserveOriginals, false, 0.3f, 0.1f);
                    return true;
                case 2:
                    kerbal.UpdateTo("Bill Gaelan", ProtoCrewMember.Gender.Male, "Engineer", Settings.preserveOriginals, false, 0.5f, 0.8f);
                    return true;
                case 3:
                    kerbal.UpdateTo("Valentina Gaelan", ProtoCrewMember.Gender.Female, "Pilot", Settings.preserveOriginals, true, 0.55f, 0.4f);
                    return true;
            }

            if (Settings.preserveOriginals)
                return Custom(kerbal, index - 4);

            return false;
        }

        // GPP Developers
        internal static bool Custom(ProtoCrewMember kerbal, int index)
        {
            switch (index)
            {
                case 0:
                    kerbal.UpdateTo("Galileo Gaelan", ProtoCrewMember.Gender.Male, "Pilot", !Settings.preserveOriginals, true, 0.5f, 0.5f);
                    return true;
                case 1:
                    kerbal.UpdateTo("Bobert Gaelan", ProtoCrewMember.Gender.Male, "Scientist", !Settings.preserveOriginals, false, 0.3f, 0.1f);
                    return true;
                case 2:
                    kerbal.UpdateTo("Jade Gaelan", ProtoCrewMember.Gender.Male, "Engineer", !Settings.preserveOriginals, false, 0.5f, 0.8f);
                    return true;
                case 3:
                    kerbal.UpdateTo("Poody Gaelan", ProtoCrewMember.Gender.Female, "Pilot", !Settings.preserveOriginals, true, 0.55f, 0.4f);
                    return true;
                case 4:
                    kerbal.UpdateTo("Sigma Gaelan", ProtoCrewMember.Gender.Female, "Scientist", !Settings.preserveOriginals, false, 0.1f, 0.1f);
                    return true;
                case 5:
                    kerbal.UpdateTo("Raging Gaelan", ProtoCrewMember.Gender.Male, "Engineer", !Settings.preserveOriginals, false, 0.25f, 0.5f);
                    return true;
            }

            if (!Settings.preserveOriginals)
                return Original(kerbal, index - 6);

            return false;
        }
    }
}
