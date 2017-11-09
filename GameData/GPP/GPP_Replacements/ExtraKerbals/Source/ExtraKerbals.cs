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
            Transform bill = kerbals.GetChild(0);
            Transform bob = kerbals.GetChild(1);
            Transform jeb = kerbals.GetChild(2);
            Transform val = kerbals.GetChild(3);

            // Adjust size
            val.localScale *= 1.1f;

            // Sigma Gaelan
            sigma = Instantiate(val?.gameObject);
            sigma.transform.SetParent(val.transform.parent);
            sigma.transform.localPosition = (Quaternion.AngleAxis(2.5f, Vector3.up) * val.transform.localPosition) * 1.1f;
            sigma.transform.localScale = val.transform.localScale;
            sigma.transform.Rotate(Vector3.forward, 180);
            sigma.transform.position += new Vector3(2, 0, 0.75f);

            // Raging Gaelan
            raging = Instantiate(bob?.gameObject);
            raging.transform.SetParent(val.transform.parent);
            raging.transform.localPosition = (Quaternion.AngleAxis(-10f, Vector3.up) * val.transform.localPosition) * 0.73f;
            raging.transform.localScale = val.transform.localScale;
            raging.transform.Rotate(Vector3.up, 280);
            raging.transform.position += new Vector3(-0.5f, 0, 1.5f);

            // Bobbers
            Clone(sigma.GetComponent<Bobber>(), jeb.GetComponent<Bobber>());
            Clone(raging.GetComponent<Bobber>(), bill.GetComponent<Bobber>());
        }

        void Clone(Bobber clone, Bobber original)
        {
            clone.ofs1 = original.ofs1;
            clone.ofs2 = original.ofs2;
            clone.ofs3 = original.ofs3;
            clone.seed = original.seed;
            clone.val1 = original.val1;
            clone.val2 = original.val2;
            clone.val3 = original.val3;
        }
    }
}
