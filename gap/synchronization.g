# Exploratory search related to Theorem 6.11
#
# For centerless K with A = K' abelian and C_K(A) = A, Theorem 6.11(1)
# shows that the common restriction beta of a derived automorphism of K^n
# lies in Z(R(K)) cap R_D(K).  For each such beta that is not a power map,
# we look for a subgroup <w, (k,l)> of K^2, w in A^2, whose derived
# subgroup is not invariant under sigma x sigma (sigma|_A = beta).
#
# Output per group: [|R(K)|, |R_D(K)|, |Z(R(K)) cap R_D(K)|, then either
# "none" (no non-power candidates) or the number of candidates and how
# many survive the test].
#
# Usage:  gap -q -c 'nmax:=120;;' gap/lib.g gap/synchronization.g
#         gap -q -c 'GROUPS:=[[294,9]];;' gap/lib.g gap/synchronization.g
IsPowerOnA := function(A, f)
  local e, r;
  e := Exponent(A);
  for r in PrimeResidues(e) do
    if ForAll(GeneratorsOfGroup(A), a -> Image(f, a) = a^r) then return true; fi;
  od;
  return e = 1;
end;
Check := function(K)
  local A, r, iso, P, res, RA, RD, ZR, cand, bad, s, G2, e1, e2, pi, sg, w, g, H, D, ok, T, pairs, Aelts, s2, sdat;
  A := DerivedSubgroup(K);
  r := Data(K); iso := r.iso;
  res := function(p) local f; f := PreImagesRepresentative(iso, p);
    return GroupHomomorphismByImages(A, A, GeneratorsOfGroup(A), List(GeneratorsOfGroup(A), a -> Image(f, a))); end;
  RA := Group(List(GeneratorsOfGroup(r.P), res), IdentityMapping(A));
  RD := Group(Concatenation([IdentityMapping(A)], List(GeneratorsOfGroup(r.DA), res)));
  ZR := Intersection(Centre(RA), RD);
  cand := Filtered(AsList(ZR), f -> not IsPowerOnA(A, f));
  if cand = [] then return [Size(RA), Size(RD), Size(ZR), "none"]; fi;
  G2 := DirectProduct(K, K); e1 := Embedding(G2, 1); e2 := Embedding(G2, 2);
  T := RightTransversal(K, A);
  Aelts := AsList(A);
  bad := [];
  for s in cand do
    sdat := First(AsList(r.DA), p -> res(p) = s);
    sg := PreImagesRepresentative(iso, sdat);
    s2 := function(x) return Image(e1, Image(sg, Image(Projection(G2,1), x))) * Image(e2, Image(sg, Image(Projection(G2,2), x))); end;
    ok := false;
    for g in List(Cartesian(T, T), p -> Image(e1, p[1]) * Image(e2, p[2])) do
      for w in Cartesian(Aelts, Aelts) do
        H := Subgroup(G2, [Image(e1, w[1]) * Image(e2, w[2]), g]);
        D := DerivedSubgroup(H);
        if Subgroup(G2, List(GeneratorsOfGroup(D), s2)) <> D then ok := true; break; fi;
      od;
      if ok then break; fi;
    od;
    if not ok then Add(bad, s); fi;
  od;
  return [Size(RA), Size(RD), Size(ZR), Length(cand), "surviving:", Length(bad)];
end;
if not IsBound(GROUPS) then GROUPS := "all"; fi;
if not IsBound(nmax) then nmax := 120; fi;
Suitable := function(K)
  local A;
  if Size(Centre(K)) > 1 then return false; fi;
  A := DerivedSubgroup(K);
  return IsAbelian(A) and Centralizer(K, A) = A;
end;
if GROUPS = "all" then
  GROUPS := [];
  for n in [6..nmax] do
    if IsPrimePowerInt(n) then continue; fi;
    for i in [1..NrSmallGroups(n)] do
      if Suitable(SmallGroup(n, i)) then Add(GROUPS, [n, i]); fi;
    od;
  od;
fi;
for p in GROUPS do
  K := SmallGroup(p[1], p[2]);
  Print(p, " A=", StructureDescription(DerivedSubgroup(K)), " ", Check(K), "\n");
od;
Print("FINAL\n");
QUIT;
