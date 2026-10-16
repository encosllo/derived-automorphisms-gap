# Example after Corollary 6.6
#
# |DAut(S3 x (C7 : C3))| = |Aut(S3 x (C7 : C3))| = 6 * 42 = 252.
G := DirectProduct(SymmetricGroup(3), SmallGroup(21, 1));
r := Data(G);
Print("|DAut| = ", Size(r.DA), ", |Aut| = ", Size(r.P), "\nFINAL\n");
QUIT;
