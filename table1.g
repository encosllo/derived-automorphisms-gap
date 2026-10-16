# Table 1 and the remarks after it
#
# For the 28 groups of Table 1: DAut(G) = 1, |Z(G)|, the structure of
# Z(G), the invariants of G/G', and whether Z(G) <= G' cap Phi(G); by Theorem A
# this holds except for C2 and C2 x A5, which have a direct factor C2.
# The list itself is produced by theorems.g (orders <= 200 except 128
# and 192) and order192.g; there are no groups of order 128 in it by
# Corollary 3.4.
T := [[1,1],[2,1],[24,12],[54,8],[60,5],[72,40],[72,41],[96,64],[96,204],
      [96,227],[108,15],[120,5],[120,34],[120,35],[144,182],[150,5],[160,234],
      [168,42],[168,43],[192,184],[192,185],[192,955],[192,956],[192,1021],
      [192,1022],[192,1024],[200,43],[200,44]];
for p in T do
  G := SmallGroup(p[1], p[2]); Zc := Centre(G); Gp := DerivedSubgroup(G);
  Print(p, " ", StructureDescription(G), " |DAut|=", Size(Data(G).DA),
        " Z=", StructureDescription(Zc), " G/G'=", AbelianInvariants(G),
        " Z<=G'nPhi:", IsSubgroup(Intersection(Gp, FrattiniSubgroup(G)), Zc), "\n");
od;
Print("FINAL\n");
QUIT;
