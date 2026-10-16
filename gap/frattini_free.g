# Section 5 (Frattini-free groups)
#
# For every group G with Phi(G) = 1 of order <= 120 (except 64 and 96),
# write G = Z x H with Z = Z(G) and Z(H) = 1, and test
#   Theorem C       |DAut(G)| = |Hom(H/H', Z)| |Aut(Z)| |DAut(H)|
#   Theorem 5.3     the characterization of DAut(G) = 1
#   Corollary 5.4   DAut(G) = Aut_cent(G)  <=>  D(G) = Z(G)  <=>  DAut(H) = 1
#   Theorem 5.5     the characterization of DAut(G) = PAut(G)
#   Cooper          PAut(G) <= Aut_cent(G)
bad := []; cnt := 0;
for n in Difference([1..120], [64, 96]) do
  for i in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, i);
    if Size(FrattiniSubgroup(G)) <> 1 then continue; fi;
    cnt := cnt + 1;
    Zc := Centre(G);
    H := ComplementClassesRepresentatives(G, Zc)[1];
    rG := Data(G); rH := Data(H);
    HH := H/DerivedSubgroup(H);
    if HomSize(HH, Zc) * Size(AutomorphismGroup(Zc)) * Size(rH.DA) <> Size(rG.DA) then
      Add(bad, [n, i, "C"]); fi;
    t := Size(rH.DA) = 1 and (Size(Zc) = 1 or (Size(Zc) = 2 and IsOddInt(Size(HH))));
    if t <> (Size(rG.DA) = 1) then Add(bad, [n, i, "5.3"]); fi;
    if (rG.DA = rG.AC) <> (Size(rH.DA) = 1) or (rG.D = Zc) <> (Size(rH.DA) = 1) then
      Add(bad, [n, i, "5.4"]); fi;
    PA := PAutOf(rG);
    c := Size(rH.DA) = 1 and IsCyclic(Zc) and Gcd(Size(HH), Size(Zc)) = 1 and
         ForAll(PrimeDivisors(Gcd(Size(H), Size(Zc))), p -> p = 2);
    if c <> (PA = rG.DA) then Add(bad, [n, i, "5.5"]); fi;
    if not IsSubgroup(rG.AC, PA) then Add(bad, [n, i, "Cooper"]); fi;
  od;
od;
Print("Frattini-free groups tested: ", cnt, ", bad = ", bad, "\nFINAL\n");
QUIT;
