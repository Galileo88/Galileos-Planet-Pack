using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      class Promoter
      {

         private bool IsQualifiedByMissionCount(ProtoCrewMember kerbal)
         {
            HallOfFameEntry entry = HallOfFame.Instance().GetEntry(kerbal);
            if (entry == null) return false;
            if (entry.MissionsFlown < 50) return false;
            return true;
         }


         public void Promote(ProtoCrewMember kerbal)
         {
            kerbal.isBadass = true;
         }

         public void PromoteIfEligible(ProtoCrewMember kerbal)
         {
            if(IsQualifiedByMissionCount(kerbal))
            {
               Promote(kerbal);
            }
         }
      }
   }
}
