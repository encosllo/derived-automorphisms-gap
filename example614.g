# Example 6.14
#
# K = SmallGroup(100,10) = (C5 x C5) : C4: DAut(K) = Aut(K) of order 400,
# |C_Aut(K)(K')| = 25, and |DAut(K^2)| = |P(K^2)| = 4 * 25^2 = 2500.
K := SmallGroup(100, 10);
r := Data(K);
Print("K: |Aut| = ", Size(r.P), ", |DAut| = ", Size(r.DA), ", |C(K)| = ", Size(r.CD), "\n");
r := Data(DirectProduct(K, K));
Print("K^2: |DAut| = ", Size(r.DA), ", |P| = ", Size(PowOnDer(r)),
      ", expected ", 4*25^2, "\nFINAL\n");
QUIT;
