# Remark 8.3
#
# Groups of order <= 100 (except 64 and 96) with DAut(G) <> 1 attaining
# the bound |DAut(G)| = |D(G)|^d(G) of Theorem 8.1.  Expected: only
# SmallGroup(72,15).
for n in Difference([2..100], [64, 96]) do
  for i in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, i);
    r := Data(G);
    d := Length(MinimalGeneratingSet(G));
    if Size(r.DA) = Size(r.D)^d and Size(r.DA) > 1 then
      Print([n, i], " ", StructureDescription(G), " |Z|=", Size(r.Z), " |DAut|=", Size(r.DA),
            " |D|=", Size(r.D), " d=", d, " D<=Phi:", IsSubgroup(FrattiniSubgroup(G), r.D), "\n");
    fi;
  od;
od;
Print("FINAL\n");
QUIT;
