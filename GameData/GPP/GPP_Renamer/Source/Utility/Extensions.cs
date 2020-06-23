﻿using System.Reflection;
using System.Collections.Generic;


namespace KerbalRenamer
{
    internal static class Extensions
    {
        internal static bool SetFromString(this bool value, string s)
        {
            if (bool.TryParse(s, out bool v))
                value = v;

            return value;
        }

        internal static float SetFromString(this float value, string s)
        {
            if (float.TryParse(s, out float v))
                value = v;

            return value;
        }

        internal static string[] SetFromString(this string[] array, ConfigNode node)
        {
            string[] values = node?.GetValues("suffix");
            if (values?.Length > 0)
                array = values;

            return array;
        }

        internal static void NewName(this ProtoCrewMember kerbal, string newName)
        {
            switch (kerbal.name)
            {
                case "Jebediah Kerman":
                case "Bill Kerman":
                case "Bob Kerman":
                case "Valentina Kerman":
                    VeteranRenamer.veteransToRename = VeteranRenamer.veteransToRename ?? new Dictionary<ProtoCrewMember, string>();
                    VeteranRenamer.veteransToRename.Add(kerbal, newName);
                    return;
            }

            FieldInfo _name = typeof(ProtoCrewMember).GetFields(BindingFlags.NonPublic | BindingFlags.Instance)?[0];

            if (_name != null)
            {
                _name.SetValue(kerbal, newName);
            }
        }

        internal static void UpdateTo(this ProtoCrewMember kerbal, string name, ProtoCrewMember.Gender gender, string trait, bool veteran, bool isBadass, float courage, float stupidity)
        {
            kerbal.NewName(name);
            kerbal.gender = gender;
            kerbal.type = veteran ? ProtoCrewMember.KerbalType.Crew : ProtoCrewMember.KerbalType.Applicant;
            KerbalRoster.SetExperienceTrait(kerbal, trait);
            kerbal.veteran = veteran;
            kerbal.isBadass = isBadass;
            kerbal.courage = courage;
            kerbal.stupidity = stupidity;
            if (HighLogic.CurrentGame != null && HighLogic.CurrentGame.Mode != Game.Modes.CAREER)
            {
                kerbal.experienceLevel = 5;
                kerbal.experience = 99999;
            }
        }
    }
}
