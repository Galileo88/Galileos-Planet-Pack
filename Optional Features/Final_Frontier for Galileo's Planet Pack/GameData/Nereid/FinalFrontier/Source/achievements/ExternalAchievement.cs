using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid.FinalFrontier
{
   class ExternalAchievement : Achievement
   {
      readonly String description;

      public ExternalAchievement(String code, String name, int prestige, bool first, String description)
      : base(code, name, prestige, first )
      {
         this.description = description;
      }

      public override String GetDescription()
      {
         return description;
      }
   }
}
