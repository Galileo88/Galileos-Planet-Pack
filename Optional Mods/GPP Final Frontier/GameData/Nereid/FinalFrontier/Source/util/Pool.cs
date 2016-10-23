using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Nereid
{
   namespace FinalFrontier
   {
      abstract class Pool<T>  : IEnumerable<T>
      {
         private readonly List<T> pool = new List<T>();
         private readonly Dictionary<String, T> map = new Dictionary<String, T>();

         protected abstract String CodeOf(T x);

         protected void Add(T x)
         {
            String code = CodeOf(x);
            try
            {
               Log.Detail("adding object " + x + " (" + code + ") to pool ("+x.GetType()+")");
               pool.Add(x);
               map.Add(code, x);
               Log.Trace(pool.Count + " objects in pool");
            }
            catch
            {
               Log.Error("code '" + code + " not unique ' in " + GetType());
               throw;
            }

         }

         public System.Collections.IEnumerator GetEnumerator()
         {
            return pool.GetEnumerator();
         }

         IEnumerator<T> IEnumerable<T>.GetEnumerator()
         {
            return pool.GetEnumerator();
         }

         protected void Clear()
         {
            Log.Detail("emtying pool");
            pool.Clear();
            map.Clear();
         }

         public int Count()
         {
            return pool.Count;
         }

         public Boolean Contains(T x)
         {

            return GetElementForCode(CodeOf(x)) != null;
         }

         public T GetElementForCode(String code)
         {
            try
            {
               if (Log.IsLogable(Log.LEVEL.TRACE)) Log.Trace("get element for code " + code);
               return map[code];
            }
            catch (KeyNotFoundException)
            {
               Log.Detail("no element for code " + code + " found in pool ("+GetType()+")");
               return default(T);
            }
         }

         public void Sort()
         {
            pool.Sort();
         }
      }



   }
}
