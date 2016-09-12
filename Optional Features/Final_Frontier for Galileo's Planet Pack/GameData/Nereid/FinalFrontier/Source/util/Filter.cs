using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Nereid
{
   namespace FinalFrontier
   {
      public interface Filter<T>
      {
         bool Accept(T x);
      }
   }
}
