namespace KerbalRenamer
{
    internal static class KerbalRenamer
    {
        static Random hash;

        static string seed
        {
            get
            {
                string s = "CrewCount: " + HighLogic.CurrentGame?.CrewRoster?.Count;

                if (Settings.useGameSeed)
                    s += "GameSeed: " + HighLogic.CurrentGame?.Seed;

                if (Settings.useGameMode)
                    s += "GameMode: " + HighLogic.CurrentGame?.Mode;

                return s;
            }
        }

        internal static void Rename(ProtoCrewMember kerbal)
        {
            // Don't change custom kerbals
            if (!kerbal.name.EndsWith(" Kerman")) return;

            // First 4 Veterans
            if (CustomKerbals.Veteran(kerbal)) return;

            int index = HighLogic.CurrentGame.CrewRoster.Count;

            if (Settings.preserveOriginals)
            {
                // Developers First
                if (CustomKerbals.Custom(kerbal, index - 4)) return;
            }
            else
            {
                // Originals First
                if (CustomKerbals.Original(kerbal, index - 4)) return;
            }

            // GENERATE RANDOM KERBAL
            if (Settings.generateStats || Settings.generateFirstNames || Settings.generateLastNames)
            {
                // Get the hash for this Kerbal
                hash = new Random(seed);

                // GENERATE STATS
                if (Settings.generateStats && kerbal?.type == ProtoCrewMember.KerbalType.Applicant)
                {
                    Debug.Log("KerbalRenamer.Rename", "Generating Stats");

                    // generate some new stats
                    kerbal.stupidity = 1 - hash.Get(useBellCurveMethod: Settings.useBellCurveMethod);
                    kerbal.courage = hash.Get(useBellCurveMethod: Settings.useBellCurveMethod);
                    kerbal.isBadass = (hash.Get() < Settings.badassPercent);

                    float rand = hash.Get(to: 3);
                    if (rand < 1)
                    {
                        KerbalRoster.SetExperienceTrait(kerbal, "Pilot");
                    }
                    else if (rand < 2)
                    {
                        KerbalRoster.SetExperienceTrait(kerbal, "Engineer");
                    }
                    else
                    {
                        KerbalRoster.SetExperienceTrait(kerbal, "Scientist");
                    }

                    if (hash.Get() < Settings.femalePercent)
                    {
                        kerbal.gender = ProtoCrewMember.Gender.Female;
                    }
                    else
                    {
                        kerbal.gender = ProtoCrewMember.Gender.Male;
                    }
                }

                // GENERATE NAME
                if (Settings.generateFirstNames || Settings.generateLastNames)
                {
                    Debug.Log("KerbalRenamer.Rename", "Generating Full Name");

                    string fullName = "";
                    int count = 0;

                    while (fullName.Length == 0 || HighLogic.CurrentGame.CrewRoster[fullName] != null)
                    {
                        fullName = getFullName(kerbal);

                        if (count++ > 50) return;
                    }

                    Debug.Log("KerbalRenamer.Rename", "Generated Full Name = " + fullName);

                    kerbal.ChangeName(fullName);
                }
            }
        }

        static string getFullName(ProtoCrewMember c)
        {
            string firstName = "";
            string lastName = "";
            Culture parent = Settings.cultures[1];
            int cultureRand = hash % 20;
            if (cultureRand == 0)
            {
                parent = Settings.cultures[0];
            }


            // First Name
            Debug.Log("KerbalRenamer.Rename", "Generating First Name");

            if (Settings.generateFirstNames)
            {
                if (c.gender == ProtoCrewMember.Gender.Female)
                {
                    if (parent.fnames1.Length > 0)
                    {
                        firstName += parent.fnames1[hash % parent.fnames1.Length];
                    }
                    if (parent.fnames2.Length > 0)
                    {
                        firstName += parent.fnames2[hash % parent.fnames2.Length];
                    }
                    if (parent.fnames3.Length > 0)
                    {
                        firstName += parent.fnames3[hash % parent.fnames3.Length];
                    }
                }
                else
                {
                    if (parent.mnames1.Length > 0)
                    {
                        firstName += parent.mnames1[hash % parent.mnames1.Length];
                    }
                    if (parent.mnames2.Length > 0)
                    {
                        firstName += parent.mnames2[hash % parent.mnames2.Length];
                    }
                    if (parent.mnames3.Length > 0)
                    {
                        firstName += parent.mnames3[hash % parent.mnames3.Length];
                    }
                }
            }
            else
            {
                firstName = c.name.Replace(" Kerman", "");
            }

            Debug.Log("KerbalRenamer.Rename", "Generated First Name = " + firstName);


            // Last Name
            Debug.Log("KerbalRenamer.Rename", "Generating Last Name");

            if (Settings.generateLastNames)
            {
                if (parent.femaleSurnamesExist && c.gender == ProtoCrewMember.Gender.Female)
                {
                    if (parent.flnames1.Length > 0)
                    {
                        lastName += parent.flnames1[hash % parent.flnames1.Length];
                    }
                    if (parent.flnames2.Length > 0)
                    {
                        lastName += parent.flnames2[hash % parent.flnames2.Length];
                    }
                    if (parent.flnames3.Length > 0)
                    {
                        lastName += parent.flnames3[hash % parent.flnames3.Length];
                    }
                }
                else
                {
                    if (parent.lnames1.Length > 0)
                    {
                        lastName += parent.lnames1[hash % parent.lnames1.Length];
                    }
                    if (parent.lnames2.Length > 0)
                    {
                        lastName += parent.lnames2[hash % parent.lnames2.Length];
                    }
                    if (parent.lnames3.Length > 0)
                    {
                        lastName += parent.lnames3[hash % parent.lnames3.Length];
                    }
                }
            }
            else
            {
                lastName = "Kerman";
            }

            Debug.Log("KerbalRenamer.Rename", "Generated First Name = " + firstName);

            if (parent.cultureName.Length > 0)
            {
                c.flightLog.AddEntryUnique(new FlightLog.Entry(0, Settings.cultureDescriptor, parent.cultureName));
            }


            // Suffixes
            string fullName = firstName + " " + lastName;

            if (Settings.useSuffixes && HighLogic.CurrentGame.CrewRoster[fullName] != null)
            {
                Debug.Log("KerbalRenamer.Rename", "Adding Suffix");

                int? n = Settings.suffixes?.Length;

                for (int i = 0; i < n; i++)
                {
                    string finalName = fullName + Settings.suffixes[i];

                    if (HighLogic.CurrentGame.CrewRoster[finalName] == null)
                        return finalName;
                }
            }

            return fullName;
        }
    }
}
