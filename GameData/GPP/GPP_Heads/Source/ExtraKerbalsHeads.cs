using UnityEngine;
using SigmaReplacements.Heads;
using Gender = ProtoCrewMember.Gender;
using Type = ProtoCrewMember.KerbalType;


namespace ExtraKerbals
{
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    class ExtraKerbalsHeads : MonoBehaviour
    {
        void Start()
        {
            // Sigma Gaelan
            GameObject sigma = ExtraKerbals.sigma;

            if (sigma?.GetComponent<UIKerbalMenu>() == null)
                sigma.AddComponent<UIKerbalMenu>();

            UIKerbalMenu UIsigma = sigma.GetComponent<UIKerbalMenu>();
            UIsigma.crewMember = new CrewMember(Type.Crew, "Sigma Gaelan", Gender.Female, "Scientist", true, false, 0.1f, 0.1f, 0);

            if (sigma?.GetComponent<CustomHead>() == null)
                sigma.AddComponent<CustomHead>();


            // Raging Gaelan
            GameObject raging = ExtraKerbals.raging;

            if (raging?.GetComponent<UIKerbalMenu>() == null)
                raging.AddComponent<UIKerbalMenu>();

            UIKerbalMenu UIraging = raging.GetComponent<UIKerbalMenu>();
            UIraging.crewMember = new CrewMember(Type.Crew, "Raging Gaelan", Gender.Male, "Engineer", true, false, 0.25f, 0.5f, 0);

            if (raging?.GetComponent<CustomHead>() == null)
                raging.AddComponent<CustomHead>();
        }
    }
}
