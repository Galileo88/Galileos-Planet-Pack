using System.Linq;
using UnityEngine;
using System.Collections.Generic;
using System;
using Random = UnityEngine.Random;


namespace gpp
{
    /// <summary>
    /// Loads and stores the settings for the GPP Kerbal Renamer
    /// </summary>
    [KSPAddon(KSPAddon.Startup.MainMenu, true)]
    internal class KerbalRenamerSettings : MonoBehaviour
    {
        internal static float badassPercent = 0.05f;
        internal static float femalePercent = 0.5f;
        internal static bool useBellCurveMethod = true;
        internal static bool dontInsultMe = true;
        internal static bool preserveOriginals = true;
        internal static bool generateNewStats = true;
        internal static string cultureDescriptor = "";
        internal static Culture[] cultures = { };

        void Start()
        {
            // Load all KERBALRENAMER nodes
            ConfigNode data = null;
            foreach (ConfigNode node in GameDatabase.Instance.GetConfigNodes("KERBALRENAMER"))
            {
                data = node;
            }
            if (data == null)
            {
                Debug.Log("KerbalRenamer: No config file found, thanks for playing.");
                return;
            }

            // Set badassPercent
            if (data.HasValue("badassPercent"))
            {
                float ftemp = 0.0f;
                if (float.TryParse(data.GetValue("badassPercent"), out ftemp))
                {
                    badassPercent = ftemp;
                }
            }

            // Set femalePercent
            if (data.HasValue("femalePercent"))
            {
                float ftemp = 0.0f;
                if (float.TryParse(data.GetValue("femalePercent"), out ftemp))
                {
                    femalePercent = ftemp;
                }
            }

            // Set useBellCurveMethod
            if (data.HasValue("useBellCurveMethod"))
            {
                bool btemp = true;
                if (bool.TryParse(data.GetValue("useBellCurveMethod"), out btemp))
                {
                    useBellCurveMethod = btemp;
                }
            }

            // Set dontInsultMe
            if (data.HasValue("dontInsultMe"))
            {
                bool btemp = true;
                if (bool.TryParse(data.GetValue("dontInsultMe"), out btemp))
                {
                    dontInsultMe = btemp;
                }
            }

            // Set preserveOriginals
            if (data.HasValue("preserveOriginals"))
            {
                bool btemp = true;
                if (bool.TryParse(data.GetValue("preserveOriginals"), out btemp))
                {
                    preserveOriginals = btemp;
                }
            }

            // Set generateNewStats
            if (data.HasValue("generateNewStats"))
            {
                bool btemp = true;
                if (bool.TryParse(data.GetValue("generateNewStats"), out btemp))
                {
                    generateNewStats = btemp;
                }
            }

            // Set culture stuff
            if (data.HasValue("cultureDescriptor"))
            {
                cultureDescriptor = data.GetValue("cultureDescriptor");
            }
            ConfigNode[] cultureclub = data.GetNodes("Culture");

            List<Culture> ctemp = new List<Culture>();
            for (int i = 0; i < cultureclub.Length; i++)
            {
                Culture c = new Culture(cultureclub[i]);
                ctemp.Add(c);
            }
            cultures = ctemp.ToArray();
        }
    }

    /// <summary>
    /// GPP Kerbal Renamer
    /// <para>Changes the names of all Kerbals following the settings found in "KERBALRENAMER" nodes.</para>
    /// </summary>
    [KSPAddon(KSPAddon.Startup.MainMenu, true)]
    public class KerbalRenamer : MonoBehaviour
    {
        internal static string[] originalNames = new string[] { "Jebediah Kerman", "Bill Kerman", "Bob Kerman", "Valentina Kerman" };

        void Awake()
        {
            DontDestroyOnLoad(this);

            // Add the custom OnKerbalAdded to the stock one
            GameEvents.onKerbalAdded.Add(new EventData<ProtoCrewMember>.OnEvent(OnKerbalAdded));
        }

        void OnKerbalAdded(ProtoCrewMember kerbal)
        {
            // Don't change custom kerbals
            if (!kerbal.name.EndsWith("Kerman")) return;

            // Don't change the 4 original veterans stats, just rename them.
            if (originalNames.Contains(kerbal.name))
            {
                FixVeteran(kerbal);
                return;
            }

            // This Part will generate a new Kerbal followint the defined KerbalRenamerSettings
            Random.InitState(DateTime.Now.Millisecond * kerbal.name.GetHashCode());

            if (KerbalRenamerSettings.generateNewStats)
            {
                if (kerbal.type == ProtoCrewMember.KerbalType.Applicant)
                {
                    // Make sure all custom kerbals exist
                    for (int i = 0; i < KerbalCrewFixer.customKerbals.Length; i++)
                    {
                        if (HighLogic.CurrentGame.CrewRoster[KerbalCrewFixer.customKerbals[i]] == null)
                        {
                            KerbalCrewFixer.SetCustomKerbal(kerbal, KerbalCrewFixer.customKerbals[i]);
                            return;
                        }
                    }

                    // generate some new stats
                    kerbal.stupidity = rollStupidity();
                    kerbal.courage = rollCourage();
                    kerbal.isBadass = (Random.Range(0.0f, 1.0f) < KerbalRenamerSettings.badassPercent);

                    float rand = Random.Range(0.0f, 1.0f);
                    if (rand < 0.33f)
                    {
                        KerbalRoster.SetExperienceTrait(kerbal, "Pilot");
                    }
                    else if (rand < 0.66f)
                    {
                        KerbalRoster.SetExperienceTrait(kerbal, "Engineer");
                    }
                    else
                    {
                        KerbalRoster.SetExperienceTrait(kerbal, "Scientist");
                    }

                    if (Random.Range(0.0f, 1.0f) < KerbalRenamerSettings.femalePercent)
                    {
                        kerbal.gender = ProtoCrewMember.Gender.Female;
                    }
                    else
                    {
                        kerbal.gender = ProtoCrewMember.Gender.Male;
                    }
                }
            }

            string name = "";
            int index = 0;
            while (name.Length == 0 || HighLogic.CurrentGame.CrewRoster[name] != null)
            {
                name = getName(kerbal);

                index++; if (index > 50) return;
            }

            kerbal.ChangeName(name);
        }

        internal static void FixVeteran(ProtoCrewMember kerbal)
        {
            if (KerbalRenamerSettings.preserveOriginals)
            {
                kerbal.ChangeName(kerbal.name.Replace("Kerman", "Gaelan"));
            }
            else
            {
                if (kerbal.name == "Jebediah Kerman")
                {
                    kerbal.ChangeName("Galileo Gaelan");
                }
                if (kerbal.name == "Bill Kerman")
                {
                    kerbal.ChangeName("Jade Gaelan");
                }
                if (kerbal.name == "Bob Kerman")
                {
                    kerbal.ChangeName("Bobert Gaelan");
                }
                if (kerbal.name == "Valentina Kerman")
                {
                    kerbal.ChangeName("Poody Gaelan");
                }
            }
        }

        internal static string getName(ProtoCrewMember c)
        {
            string firstName = "";
            string lastName = "";
            Culture parent = KerbalRenamerSettings.cultures[1];
            int cultureRand = Random.Range(0, 19);
            if (cultureRand == 0)
            {
                parent = KerbalRenamerSettings.cultures[0];
            }
            if (c.gender == ProtoCrewMember.Gender.Female)
            {
                if (parent.fnames1.Length > 0)
                {
                    firstName += parent.fnames1[Random.Range(0, parent.fnames1.Length)];
                }
                if (parent.fnames2.Length > 0)
                {
                    firstName += parent.fnames2[Random.Range(0, parent.fnames2.Length)];
                }
                if (parent.fnames3.Length > 0)
                {
                    firstName += parent.fnames3[Random.Range(0, parent.fnames3.Length)];
                }
            }
            else
            {
                if (parent.mnames1.Length > 0)
                {
                    firstName += parent.mnames1[Random.Range(0, parent.mnames1.Length)];
                }
                if (parent.mnames2.Length > 0)
                {
                    firstName += parent.mnames2[Random.Range(0, parent.mnames2.Length)];
                }
                if (parent.mnames3.Length > 0)
                {
                    firstName += parent.mnames3[Random.Range(0, parent.mnames3.Length)];
                }
            }
            if (parent.femaleSurnamesExist && c.gender == ProtoCrewMember.Gender.Female)
            {
                if (parent.flnames1.Length > 0)
                {
                    lastName += parent.flnames1[Random.Range(0, parent.flnames1.Length)];
                }
                if (parent.flnames2.Length > 0)
                {
                    lastName += parent.flnames2[Random.Range(0, parent.flnames2.Length)];
                }
                if (parent.flnames3.Length > 0)
                {
                    lastName += parent.flnames3[Random.Range(0, parent.flnames3.Length)];
                }
            }
            else
            {
                if (parent.lnames1.Length > 0)
                {
                    lastName += parent.lnames1[Random.Range(0, parent.lnames1.Length)];
                }
                if (parent.lnames2.Length > 0)
                {
                    lastName += parent.lnames2[Random.Range(0, parent.lnames2.Length)];
                }
                if (parent.lnames3.Length > 0)
                {
                    lastName += parent.lnames3[Random.Range(0, parent.lnames3.Length)];
                }
            }
            if (lastName.Length > 0)
            {
                if (firstName.Length > 0)
                {
                    if (parent.cultureName.Length > 0)
                    {
                        c.flightLog.AddEntryUnique(new FlightLog.Entry(0, KerbalRenamerSettings.cultureDescriptor, parent.cultureName));
                    }
                    return firstName + " " + lastName;
                }
                else
                {
                    if (parent.cultureName.Length > 0)
                    {
                        c.flightLog.AddEntryUnique(new FlightLog.Entry(0, KerbalRenamerSettings.cultureDescriptor, parent.cultureName));
                    }
                    return lastName;
                }
            }
            else
            {
                // 0 length names should be handled elsewhere.
                return firstName;
            }
        }

        float rollCourage()
        {
            if (KerbalRenamerSettings.useBellCurveMethod)
            {
                float retval = -0.05f;
                for (int i = 0; i < 6; i++)
                {
                    retval += Random.Range(0.01f, 0.21f);
                }
                return retval;
            }
            else
            {
                return Random.Range(0.0f, 1.0f);
            }
        }

        float rollStupidity()
        {
            if (KerbalRenamerSettings.useBellCurveMethod)
            {
                float retval = -0.05f;
                int end = 6;
                if (KerbalRenamerSettings.dontInsultMe) { end = 4; }
                for (int i = 0; i < end; i++)
                {
                    retval += Random.Range(0.01f, 0.21f);
                }
                if (retval < 0.001f) { retval = 0.001f; }
                return retval;
            }
            else
            {
                return Random.Range(0.0f, 1.0f);
            }
        }
    }

    /// <summary>
    /// Changes the names of the four stock veterans if they are already in the roster
    /// </summary>
    [KSPAddon(KSPAddon.Startup.SpaceCentre, false)]
    class KerbalCrewFixer : MonoBehaviour
    {
        internal static string[] customKerbals = new string[] { "Galileo Gaelan", "Bobert Gaelan", "Jade Gaelan", "Poody Gaelan", "Sigma Gaelan", "Raging Gaelan", "Jebediah Gaelan", "Bill Gaelan", "Bob Gaelan", "Valentina Gaelan" };

        void Start()
        {
            List<ProtoCrewMember> roster = HighLogic.CurrentGame.CrewRoster.ToList();

            for (int i = 0; i < roster?.Count; i++)
            {
                ProtoCrewMember kerbal = roster[i];

                if (KerbalRenamer.originalNames.Contains(kerbal.name))
                {
                    KerbalRenamer.FixVeteran(kerbal);
                }
                else if (kerbal.name.EndsWith("Kerman"))
                {
                    string name = "";
                    int index = 0;
                    while (name.Length == 0 || roster.Any(k => k.name == name))
                    {
                        name = KerbalRenamer.getName(kerbal);

                        index++; if (index > 50) return;
                    }

                    kerbal.ChangeName(name);
                }
            }

            // Add new Kerbals
            AddCustomKerbal("Galileo Gaelan", !KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Bobert Gaelan", !KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Jade Gaelan", !KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Poody Gaelan", !KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Sigma Gaelan", !KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Raging Gaelan", !KerbalRenamerSettings.preserveOriginals);

            // Add old Kerbals
            AddCustomKerbal("Jebediah Gaelan", KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Bill Gaelan", KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Bob Gaelan", KerbalRenamerSettings.preserveOriginals);
            AddCustomKerbal("Valentina Gaelan", KerbalRenamerSettings.preserveOriginals);

            OrderCrew();
        }

        void AddCustomKerbal(string name, bool veteran)
        {
            ProtoCrewMember.KerbalType type = veteran ? ProtoCrewMember.KerbalType.Crew : ProtoCrewMember.KerbalType.Applicant;

            ProtoCrewMember customVet = HighLogic.CurrentGame.CrewRoster[name];

            if (customVet == null)
            {
                if (type == ProtoCrewMember.KerbalType.Applicant)
                {
                    customVet = HighLogic.CurrentGame.CrewRoster?.Applicants?.ToList()?.FirstOrDefault(k => !customKerbals.Contains(k.name));
                }
            }

            if (customVet == null)
            {
                customVet = new ProtoCrewMember(type, name);
            }

            SetCustomKerbal(customVet, name);

            if (!HighLogic.CurrentGame.CrewRoster.Exists(name))
                HighLogic.CurrentGame.CrewRoster.AddCrewMember(customVet);
        }

        internal static void SetCustomKerbal(ProtoCrewMember kerbal, string name)
        {
            switch (name)
            {
                case "Galileo Gaelan":
                    SetCustomKerbal(kerbal, "Galileo Gaelan", ProtoCrewMember.Gender.Male, "Pilot", !KerbalRenamerSettings.preserveOriginals, true, 0.5f, 0.5f);
                    break;
                case "Bobert Gaelan":
                    SetCustomKerbal(kerbal, "Bobert Gaelan", ProtoCrewMember.Gender.Male, "Scientist", !KerbalRenamerSettings.preserveOriginals, false, 0.3f, 0.1f);
                    break;
                case "Jade Gaelan":
                    SetCustomKerbal(kerbal, "Jade Gaelan", ProtoCrewMember.Gender.Male, "Engineer", !KerbalRenamerSettings.preserveOriginals, false, 0.5f, 0.8f);
                    break;
                case "Poody Gaelan":
                    SetCustomKerbal(kerbal, "Poody Gaelan", ProtoCrewMember.Gender.Female, "Pilot", !KerbalRenamerSettings.preserveOriginals, true, 0.55f, 0.4f);
                    break;
                case "Sigma Gaelan":
                    SetCustomKerbal(kerbal, "Sigma Gaelan", ProtoCrewMember.Gender.Female, "Scientist", !KerbalRenamerSettings.preserveOriginals, false, 0.0f, 0.0f);
                    break;
                case "Raging Gaelan":
                    SetCustomKerbal(kerbal, "Raging Gaelan", ProtoCrewMember.Gender.Male, "Engineer", !KerbalRenamerSettings.preserveOriginals, false, 0.25f, 0.5f);
                    break;
                case "Jebediah Gaelan":
                    SetCustomKerbal(kerbal, "Jebediah Gaelan", ProtoCrewMember.Gender.Male, "Pilot", KerbalRenamerSettings.preserveOriginals, true, 0.5f, 0.5f);
                    break;
                case "Bill Gaelan":
                    SetCustomKerbal(kerbal, "Bill Gaelan", ProtoCrewMember.Gender.Male, "Scientist", KerbalRenamerSettings.preserveOriginals, false, 0.3f, 0.1f);
                    break;
                case "Bob Gaelan":
                    SetCustomKerbal(kerbal, "Bob Gaelan", ProtoCrewMember.Gender.Male, "Engineer", KerbalRenamerSettings.preserveOriginals, false, 0.5f, 0.8f);
                    break;
                case "Valentina Gaelan":
                    SetCustomKerbal(kerbal, "Valentina Gaelan", ProtoCrewMember.Gender.Female, "Pilot", KerbalRenamerSettings.preserveOriginals, true, 0.55f, 0.4f);
                    break;
                default:
                    return;
            }
        }

        static void SetCustomKerbal(ProtoCrewMember kerbal, string name, ProtoCrewMember.Gender gender, string trait, bool veteran, bool isBadass, float courage, float stupidity)
        {
            kerbal.ChangeName(name);
            kerbal.gender = gender;
            KerbalRoster.SetExperienceTrait(kerbal, trait);
            kerbal.veteran = veteran;
            kerbal.isBadass = isBadass;
            kerbal.courage = courage;
            kerbal.stupidity = stupidity;
            if (HighLogic.CurrentGame.Mode != Game.Modes.CAREER)
            {
                kerbal.experienceLevel = 5;
                kerbal.experience = 99999;
            }
        }

        void OrderCrew()
        {
            List<ProtoCrewMember> roster = HighLogic.CurrentGame.CrewRoster.ToList();

            for (int i = 0; i < customKerbals.Length; i++)
            {
                if (HighLogic.CurrentGame.CrewRoster[customKerbals[i]] != null)
                {
                    HighLogic.CurrentGame.CrewRoster[customKerbals[i]].ChangeName(customKerbals[i]);
                }
            }

            for (int i = 0; i < roster?.Count; i++)
            {
                if (!customKerbals.Contains(roster[i].name))
                {
                    roster[i].ChangeName(roster[i].name);
                }
            }
        }
    }

    internal static class Extensions
    {
        internal static List<ProtoCrewMember> ToList(this KerbalRoster roster)
        {
            if (roster == null) return null;

            List<ProtoCrewMember> list = new List<ProtoCrewMember>();

            for (int i = 0; i < roster?.Count; i++)
            {
                list.Add(roster[i]);
            }

            return list;
        }
    }

    internal class Culture
    {
        public bool femaleSurnamesExist;
        public string cultureName = "";
        public string[] fnames1 = { };
        public string[] fnames2 = { };
        public string[] fnames3 = { };
        public string[] mnames1 = { };
        public string[] mnames2 = { };
        public string[] mnames3 = { };
        public string[] lnames1 = { };
        public string[] lnames2 = { };
        public string[] lnames3 = { };
        public string[] flnames1 = { };
        public string[] flnames2 = { };
        public string[] flnames3 = { };

        public Culture(ConfigNode node)
        {
            ConfigNode temp;
            string[] vals;
            if (node.HasValue("name"))
            {
                cultureName = node.GetValue("name");
            }
            if (node.HasNode("FFIRSTNAME1"))
            {
                temp = node.GetNode("FFIRSTNAME1");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    fnames1 = vals;
                }
            }
            if (node.HasNode("FFIRSTNAME2"))
            {
                temp = node.GetNode("FFIRSTNAME2");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    fnames2 = vals;
                }
            }
            if (node.HasNode("FFIRSTNAME3"))
            {
                temp = node.GetNode("FFIRSTNAME3");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    fnames3 = vals;
                }
            }
            if (node.HasNode("MFIRSTNAME1"))
            {
                temp = node.GetNode("MFIRSTNAME1");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    mnames1 = vals;
                }
            }
            if (node.HasNode("MFIRSTNAME2"))
            {
                temp = node.GetNode("MFIRSTNAME2");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    mnames2 = vals;
                }
            }
            if (node.HasNode("MFIRSTNAME3"))
            {
                temp = node.GetNode("MFIRSTNAME3");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    mnames3 = vals;
                }
            }
            if (node.HasNode("LASTNAME1"))
            {
                temp = node.GetNode("LASTNAME1");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    lnames1 = vals;
                }
            }
            if (node.HasNode("LASTNAME2"))
            {
                temp = node.GetNode("LASTNAME2");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    lnames2 = vals;
                }
            }
            if (node.HasNode("LASTNAME3"))
            {
                temp = node.GetNode("LASTNAME3");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    lnames3 = vals;
                }
            }
            if (node.HasNode("FLASTNAME1"))
            {
                temp = node.GetNode("FLASTNAME1");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    flnames1 = vals;
                    femaleSurnamesExist = true;
                }
            }
            if (node.HasNode("FLASTNAME2"))
            {
                temp = node.GetNode("FLASTNAME2");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    flnames2 = vals;
                    femaleSurnamesExist = true;
                }
            }
            if (node.HasNode("FLASTNAME3"))
            {
                temp = node.GetNode("FLASTNAME3");
                vals = temp.GetValues("key");
                if (vals.Length > 0)
                {
                    flnames3 = vals;
                    femaleSurnamesExist = true;
                }
            }
        }
    }

    /* I couldn't find any use for this code so I temporarily removed it
    
    [KSPAddon(KSPAddon.Startup.SpaceCentre, false)]
    public class IconChanger_SpaceCentre : IconChanger
    {
        public void Awake()
        {
            GameEvents.onGUIAstronautComplexSpawn.Add(new EventVoid.OnEvent(OnGUIAstronautComplexSpawn));
            GameEvents.onGUILaunchScreenVesselSelected.Add(new EventData<ShipTemplate>.OnEvent(OnGUILaunchScreenVesselSelected));
        }
    }

    [KSPAddon(KSPAddon.Startup.EditorAny, false)]
    public class IconChanger_EditorAny : IconChanger
    {
        public void Awake()
        {
            GameEvents.onEditorScreenChange.Add(new EventData<EditorScreen>.OnEvent(OnEditorScreenChange));
        }
    }

    public class IconChanger : MonoBehaviour
    {
        public void OnGUIAstronautComplexSpawn()
        {
            StartCoroutine(CallbackUtil.DelayedCallback(1, BuildAstronautComplex));
        }

        public void OnGUILaunchScreenVesselSelected(ShipTemplate t)
        {
            StartCoroutine(CallbackUtil.DelayedCallback(1, BuildCrewAssignmentDialogue));
        }

        public void OnEditorScreenChange(EditorScreen e)
        {
            if (e == EditorScreen.Crew)
            {
                StartCoroutine(CallbackUtil.DelayedCallback(1, BuildCrewAssignmentDialogue));
            }
        }

        public void BuildAstronautComplex()
        {
            KSP.UI.CrewListItem cic;
            KSP.UI.UIList scroll;

            UnityEngine.Object[] objs = Resources.FindObjectsOfTypeAll(typeof(KSP.UI.Screens.AstronautComplex));
            if (objs.Length < 1) { return; }
            KSP.UI.Screens.AstronautComplex complex = (KSP.UI.Screens.AstronautComplex)objs[0];
            FieldInfo[] scrolls = typeof(KSP.UI.Screens.AstronautComplex).GetFields(BindingFlags.NonPublic | BindingFlags.Instance).Where(c => c.FieldType == typeof(KSP.UI.UIList)).ToArray();

            for (int i = 0; i < scrolls.Length; i++)
            {
                scroll = (KSP.UI.UIList)scrolls[i].GetValue(complex);
                for (int j = 0; j < scroll.Count; j++)
                {
                    KSP.UI.UIListItem listItem = scroll.GetUilistItemAt(j);
                    cic = listItem.GetComponent<KSP.UI.CrewListItem>();
                    cic.AddButtonInputDelegate(new UnityAction<KSP.UI.CrewListItem.ButtonTypes, KSP.UI.CrewListItem>(RebuildAstronautComplex));
                    changeKerbalIcon(cic);
                }
            }
        }

        public void BuildCrewAssignmentDialogue()
        {
            if ((object)KSP.UI.CrewAssignmentDialog.Instance == null)
            {
                return;
            }
            KSP.UI.CrewAssignmentDialog dialogue = KSP.UI.CrewAssignmentDialog.Instance;
            KSP.UI.CrewListItem cic;

            for (int j = 0; j < dialogue.scrollListAvail.Count; j++)
            {
                KSP.UI.UIListItem listItem = dialogue.scrollListAvail.GetUilistItemAt(j);
                cic = listItem.GetComponent<KSP.UI.CrewListItem>();
                cic.AddButtonInputDelegate(new UnityAction<KSP.UI.CrewListItem.ButtonTypes, KSP.UI.CrewListItem>(RebuildCrewAssignmentDialogue));
                changeKerbalIcon(cic);
            }
            for (int j = 0; j < dialogue.scrollListCrew.Count; j++)
            {
                KSP.UI.UIListItem listItem = dialogue.scrollListCrew.GetUilistItemAt(j);
                cic = listItem.GetComponent<KSP.UI.CrewListItem>();
                if ((object)cic != null)
                {
                    cic.AddButtonInputDelegate(new UnityAction<KSP.UI.CrewListItem.ButtonTypes, KSP.UI.CrewListItem>(RebuildCrewAssignmentDialogue));
                    changeKerbalIcon(cic);
                }
            }
        }

        public void RebuildAstronautComplex(KSP.UI.CrewListItem.ButtonTypes type, KSP.UI.CrewListItem cic)
        {
            StartCoroutine(CallbackUtil.DelayedCallback(1, BuildAstronautComplex));
        }

        public void RebuildCrewAssignmentDialogue(KSP.UI.CrewListItem.ButtonTypes type, KSP.UI.CrewListItem cic)
        {
            StartCoroutine(CallbackUtil.DelayedCallback(1, BuildCrewAssignmentDialogue));
        }

        void changeKerbalIcon(KSP.UI.CrewListItem cic)
        {
            if (cic.GetCrewRef() == null)
            {
                return;
            }
            FlightLog.Entry flight = cic.GetCrewRef().flightLog.Entries.FirstOrDefault(e => e.type == KerbalRenamer.Instance.cultureDescriptor);
            if (flight != null)
            {
                FieldInfo fi = typeof(KSP.UI.CrewListItem).GetFields(BindingFlags.NonPublic | BindingFlags.Instance).FirstOrDefault(c => c.FieldType == typeof(RawImage));
                RawImage foo = (RawImage)fi.GetValue(cic);
                Culture culture = KerbalRenamer.Instance.getCultureByName(flight.target);
                if ((object)culture != null)
                {
                    foo.texture = GameDatabase.Instance.GetTexture("KerbalRenamer/Icons/" + culture.cultureName, false);
                }
            }
        }
    }
    */
}
