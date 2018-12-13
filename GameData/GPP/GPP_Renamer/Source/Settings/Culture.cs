namespace KerbalRenamer
{
    public class Culture
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
}
