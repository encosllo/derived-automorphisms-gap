# Common functions for the computations in
#   L. Gong, Y. Yan, E. Cosme Llopez, "Derived automorphisms of finite groups".
# Load this file before any of the other scripts:  gap -q lib.g <script>.g
#
# Notation (as in the paper):
#   D(G)     derived norm: intersection of the normalizers N_G(H') , H <= G
#   DAut(G)  automorphisms leaving H' invariant for every H <= G
#

# Second centre Z_2(G).
Z2of := function(G)
  local nat;
  nat := NaturalHomomorphismByNormalSubgroup(G, Centre(G));
  return PreImage(nat, Centre(Image(nat)));
end;

# The set of all derived subgroups H' of subgroups H <= G.
DerSubs := function(G)
  local L, cls, K, x;
  L := [];
  for cls in ConjugacyClassesSubgroups(G) do
    K := DerivedSubgroup(Representative(cls));
    for x in RightTransversal(G, Normalizer(G, K)) do
      AddSet(L, K^x);
    od;
  od;
  return L;
end;

# Derived norm D(G), given the list L = DerSubs(G).
DNorm := function(G, L)
  return Intersection(List(L, K -> Normalizer(G, K)));
end;

# Record with the main data of G.  Automorphism groups are represented by
# the permutation group P = Image(iso), iso : Aut(G) -> P.
#   DA   DAut(G)                     Inn  Inn(G)
#   AC   Aut_cent(G) = C_P(Inn)      CD   C_Aut(G)(G'), automorphisms fixing G'
#   D    D(G)    Z  Z(G)    Z2  Z_2(G)    L  DerSubs(G)
Data := function(G)
  local A, iso, P, L, hom, DA, Inn, AC, CD, Gp, homG;
  L := DerSubs(G);
  A := AutomorphismGroup(G);
  iso := IsomorphismPermGroup(A);
  P := Image(iso);
  hom := ActionHomomorphism(P, L,
           function(K, p) return Image(PreImagesRepresentative(iso, p), K); end);
  DA := Kernel(hom);
  Inn := Image(iso, InnerAutomorphismsAutomorphismGroup(A));
  AC := Centralizer(P, Inn);
  Gp := DerivedSubgroup(G);
  homG := ActionHomomorphism(P, AsList(Gp),
            function(g, p) return Image(PreImagesRepresentative(iso, p), g); end);
  CD := Kernel(homG);
  return rec(G := G, L := L, A := A, iso := iso, P := P, DA := DA, AC := AC,
             Inn := Inn, CD := CD, D := DNorm(G, L), Z := Centre(G),
             Z2 := Z2of(G));
end;

# Displacement property: x^-1 alpha(x) lies in D(G) for alpha in DAut(G).
Displacement := function(r)
  local a, alpha, x;
  for a in GeneratorsOfGroup(r.DA) do
    alpha := PreImagesRepresentative(r.iso, a);
    for x in GeneratorsOfGroup(r.G) do
      if not x^-1 * Image(alpha, x) in r.D then return false; fi;
    od;
  od;
  return true;
end;

# The group P(G) of automorphisms inducing a power automorphism on G'
# (i.e. preserving every cyclic subgroup of G'), as a subgroup of r.P.
PowOnDer := function(r)
  local Gp, cyc, hom;
  Gp := DerivedSubgroup(r.G);
  cyc := Set(List(AsList(Gp), g -> Subgroup(Gp, [g])));
  hom := ActionHomomorphism(r.P, cyc,
           function(K, p) return Image(PreImagesRepresentative(r.iso, p), K); end);
  return Kernel(hom);
end;

# PAut(G): automorphisms preserving every cyclic subgroup of G.
PAutOf := function(r)
  local cyc, hom;
  cyc := Set(List(AsList(r.G), g -> Subgroup(r.G, [g])));
  hom := ActionHomomorphism(r.P, cyc,
           function(K, p) return Image(PreImagesRepresentative(r.iso, p), K); end);
  return Kernel(hom);
end;

# |Hom(A, B)| for finite abelian groups A, B.
HomSize := function(A, B)
  local a, b, s;
  s := 1;
  for a in AbelianInvariants(A) do
    for b in AbelianInvariants(B) do s := s * Gcd(a, b); od;
  od;
  return s;
end;
