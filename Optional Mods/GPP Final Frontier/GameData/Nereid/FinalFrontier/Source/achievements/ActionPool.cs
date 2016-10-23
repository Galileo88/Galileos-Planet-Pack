using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      class ActionPool : Pool<Action>
      {

         private readonly List<Action> actions = new List<Action>();
         private readonly Dictionary<String, Action> codeMap = new Dictionary<String, Action>();

         public static readonly Action ACTION_LAUNCH   = new LaunchAction();
         public static readonly Action ACTION_DOCKING = new DockingAction();
         public static readonly Action ACTION_RECOVER = new RecoverAction();
         public static readonly Action ACTION_BOARDING = new BoardingAction();
         public static readonly EvaAction ACTION_EVA_NOATM = new EvaNoAtmosphereAction();
         public static readonly EvaAction ACTION_EVA_OXYGEN = new EvaWithOxygen();
         public static readonly EvaAction ACTION_EVA_INATM = new EvaInAtmosphereAction();
         public static readonly Action ACTION_CONTRACT = new ContractAction();
         public static readonly Action ACTION_SCIENCE = new ScienceAction();

         private static volatile ActionPool instance;
         //
         public static ActionPool Instance()
         {
            if (instance == null)
            {
               instance = new ActionPool();
               Log.Info("new action pool instance created");

            }
            return instance;
         }

         private ActionPool()
         {
            Add(ACTION_LAUNCH);
            Add(ACTION_DOCKING);
            Add(ACTION_RECOVER);
            Add(ACTION_BOARDING);
            Add(ACTION_EVA_NOATM);
            Add(ACTION_EVA_OXYGEN);
            Add(ACTION_EVA_INATM);
            Add(ACTION_CONTRACT);
            Add(ACTION_SCIENCE);
         }


         protected override string CodeOf(Action x)
         {
            return x.GetCode();
         }

         public Action GetActionForCode(String code)
         {
            return base.GetElementForCode(code);
         }
      }
   }
}
