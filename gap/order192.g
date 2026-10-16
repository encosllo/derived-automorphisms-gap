# Groups of order 192 with DAut(G) = 1 (Table 1)
#
# DAut(G) is computed only for the groups satisfying the necessary
# conditions Z_2(G) = Z(G) and gcd(|G/G'|, |Z(G)|) in {1, 2} of
# Theorem 3.2 and Corollary 3.3 (nilpotent groups are excluded by
# Corollary 3.4).
cnt := 0;
for i in [1..NrSmallGroups(192)] do
  G := SmallGroup(192, i);
  if IsNilpotentGroup(G) then continue; fi;
  Zc := Centre(G);
  if Size(Z2of(G)) <> Size(Zc) then continue; fi;
  if not Gcd(Size(G)/Size(DerivedSubgroup(G)), Size(Zc)) in [1, 2] then continue; fi;
  cnt := cnt + 1;
  if Size(Data(G).DA) = 1 then Print("DAut = 1: ", [192, i], " ", StructureDescription(G), "\n"); fi;
od;
Print("candidates: ", cnt, "\nFINAL\n");
QUIT;
