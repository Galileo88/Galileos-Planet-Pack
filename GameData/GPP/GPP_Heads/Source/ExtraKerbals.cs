using System.Linq;
using UnityEngine;


namespace ExtraKerbals
{
    [KSPAddon(KSPAddon.Startup.MainMenu, false)]
    public class ExtraKerbals : MonoBehaviour
    {
        public static GameObject sigma = null;
        public static GameObject raging = null;

        void Start()
        {
            // The 4 original kerbals
            Transform kerbals = Resources.FindObjectsOfTypeAll<Transform>().FirstOrDefault(t => t?.name == "Kerbals" && t?.parent?.name == "OrbitScene");

            // The kerbals we want to clone
            Transform bob = kerbals.GetChild(1);
            Transform val = kerbals.GetChild(kerbals.childCount - 1);

            // Make the girls bigger and move them a bit up
            val.localScale *= 1.1f;
            val.localPosition += Vector3.up * 0.1f;


            // Sigma Gaelan
            sigma = Instantiate(val?.gameObject);
            sigma.transform.SetParent(val.parent);
            sigma.transform.localPosition = (Quaternion.AngleAxis(2.5f, Vector3.up) * val.localPosition) * 1.1f;
            sigma.transform.localScale = val.localScale;
            sigma.transform.Rotate(Vector3.forward, 180);


            // Raging Gaelan
            raging = Instantiate(bob?.gameObject);
            raging.transform.SetParent(val.parent);
            raging.transform.localPosition = (Quaternion.AngleAxis(-10f, Vector3.up) * val.localPosition) * 0.7f;
            raging.transform.localScale = val.localScale;
            raging.transform.Rotate(Vector3.up, 280);
            raging.transform.localScale *= 0.8f;
        }
    }
}
