using System;


namespace KerbalRenamer
{
    internal class Random
    {
        string seed;
        int hash;

        // Get random number
        internal float Get(float from = 0, float to = 1, int cases = 1000000, bool useBellCurveMethod = false)
        {
            if (Settings.useBellCurveMethod)
            {
                float x = (hash % cases) / (float)cases;
                float y = ((1.6f * x - 2.4f) * x + 1.8f) * x;

                hash = Math.Abs(hash.ToString().GetHashCode());

                return Settings.dontInsultMe ? y * 0.8f + 0.2f : y;
            }
            else
            {
                int v = hash;

                hash = Math.Abs(hash.ToString().GetHashCode());

                return (v % cases) * (to - from) / cases + from;
            }
        }

        // new Random
        internal Random(string seed)
        {
            this.seed = seed;
            hash = Math.Abs(seed.GetHashCode());
            Debug.Log("new Random()", "seed = " + seed + ", hash = " + hash);
        }

        // (int)Random
        public static implicit operator int(Random rnd)
        {
            int v = rnd.hash;

            rnd.hash = Math.Abs(rnd.hash.ToString().GetHashCode());
            Debug.Log("(int)Random", "Current hash = " + v + ", new hash = " + rnd.hash);

            return v;
        }
    }
}
