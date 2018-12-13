using UnityEngine;


namespace KerbalRenamer
{
    [KSPAddon(KSPAddon.Startup.MainMenu, true)]
    internal class EventTracker : MonoBehaviour
    {
        void Awake()
        {
            DontDestroyOnLoad(this);
            GameEvents.onKerbalAdded.Add(new EventData<ProtoCrewMember>.OnEvent(OnKerbalAdded));
        }

        void OnKerbalAdded(ProtoCrewMember kerbal)
        {
            KerbalRenamer.Rename(kerbal);
        }
    }
}
