# Proposition 6.16
#
# K = D14 x (C7 : C3) = SmallGroup(294,9), n = 2:
# |DAut(K^2)| = 36 * 49^2 = 86436 and |P(K^2)| = 6 * 49^2 = 14406.
K := DirectProduct(DihedralGroup(14), SmallGroup(21, 1));
Print("Id(K) = ", IdSmallGroup(K), "\n");
r := Data(K);
Print("K: |Aut| = ", Size(r.P), ", |DAut| = ", Size(r.DA), "\n");
r := Data(DirectProduct(K, K));
Print("K^2: |DAut| = ", Size(r.DA), ", |P| = ", Size(PowOnDer(r)),
      ", expected ", [36*49^2, 6*49^2], "\nFINAL\n");
QUIT;
