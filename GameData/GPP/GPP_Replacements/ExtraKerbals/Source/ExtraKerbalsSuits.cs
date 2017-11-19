using UnityEngine;
using SigmaReplacements;
using SigmaReplacements.Suits;
using Gender = ProtoCrewMember.Gender;
using Type = ProtoCrewMember.KerbalType;
using Roster = ProtoCrewMember.RosterStatus;


namespace ExtraKerbals
{
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    class ExtraKerbalsSuits : MonoBehaviour
    {
        void Start()
        {
            // Sigma Gaelan
            GameObject sigma = ExtraKerbals.sigma;

            if (sigma?.GetComponent<UIKerbalMenu>() == null)
                sigma.AddComponent<UIKerbalMenu>();

            UIKerbalMenu UIsigma = sigma.GetComponent<UIKerbalMenu>();
            UIsigma.crewMember = new CrewMember(Type.Crew, Roster.Assigned, "Sigma Gaelan", Gender.Female, "Scientist", true, false, 0.1f, 0.1f, 0);

            if (sigma?.GetComponent<CustomSuit>() == null)
                sigma.AddComponent<CustomSuit>();


            // Raging Gaelan
            GameObject raging = ExtraKerbals.raging;

            if (raging?.GetComponent<UIKerbalMenu>() == null)
                raging.AddComponent<UIKerbalMenu>();

            UIKerbalMenu UIraging = raging.GetComponent<UIKerbalMenu>();
            UIraging.crewMember = new CrewMember(Type.Crew, Roster.Assigned, "Raging Gaelan", Gender.Male, "Engineer", true, false, 0.25f, 0.5f, 0);

            if (raging?.GetComponent<CustomSuit>() == null)
                raging.AddComponent<CustomSuit>();
        }
    }
}
