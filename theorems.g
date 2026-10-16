# Consistency checks over the SmallGroups library
#
# For every group G with nmin <= |G| <= nmax and |G| not in skip, compute D(G) and DAut(G)
# and test the general results of the paper:
#   Lemma 2.2       Aut_cent(G) <= C_Aut(G)(G') <= DAut(G), Z_2(G) <= D(G),
#                   |DAut(G) cap Inn(G)| = |D(G) : Z(G)|, displacement
#   Theorem 2.9     D = Z  =>  DAut = Aut_cent;
#                   DAut = Aut_cent  =>  D = Z_2 and C_Aut(G') = Aut_cent
#   [LS, Th. 5.3]   D(G) = 1  <=>  C_G(G') = 1
#   Prop. 7.8       Z(G') = 1  =>  D(G) = Z(G)
#   Theorem 7.2     D(G) = G  =>  G' nilpotent of class <= 2;
#                   DAut = Aut  =>  D(G) = G;  D(G) soluble
#   Theorem 8.1     |DAut(G)| <= |D(G)|^d(G), with divisibility if D <= Phi
# It also lists the groups with DAut(G) = 1 (Table 1).
#
# A line "FAIL <tag> [n, i]" is printed for every failure (there are none).
# Usage:  gap -q -c 'nmin:=1;; nmax:=100;; skip:=[];;' lib.g theorems.g
if not IsBound(skip) then skip := []; fi;
ORDERS := Difference([nmin..nmax], skip);
triv := []; bad := [];
Fail := function(x) Add(bad, x); Print("FAIL ", x[3], " ", x{[1,2]}, "\n"); end;
for n in ORDERS do
  for i in [1..NrSmallGroups(n)] do
    G := SmallGroup(n, i);
    r := Data(G);
    dA := Size(r.DA); D := r.D; Zc := r.Z; Z2 := r.Z2; Gp := DerivedSubgroup(G);
    if dA = 1 then Add(triv, [n, i, StructureDescription(G)]); fi;
    # Lemma 2.2
    if not (IsSubgroup(r.CD, r.AC) and IsSubgroup(r.DA, r.CD) and IsSubgroup(D, Z2)) then
      Fail([n, i, "2.2"]); fi;
    if Size(Intersection(r.DA, r.Inn)) <> Size(D)/Size(Zc) then Fail([n, i, "2.2(Inn)"]); fi;
    if not Displacement(r) then Fail([n, i, "displacement"]); fi;
    # Theorem 2.9
    if D = Zc and r.DA <> r.AC then Fail([n, i, "2.9(1)"]); fi;
    if r.DA = r.AC and not (D = Z2 and r.CD = r.AC) then Fail([n, i, "2.9(2)"]); fi;
    # Results of Li and Shen used in the paper; Proposition 7.8
    if (Size(Centralizer(G, Gp)) = 1) <> (Size(D) = 1) then Fail([n, i, "LS 5.3"]); fi;
    if Size(Centre(Gp)) = 1 and D <> Zc then Fail([n, i, "7.8"]); fi;
    if D = G and (not IsNilpotentGroup(Gp) or NilpotencyClassOfGroup(Gp) > 2) then
      Fail([n, i, "7.2"]); fi;
    if not IsSolvableGroup(D) then Fail([n, i, "D soluble"]); fi;
    if r.DA = r.P and D <> G then Fail([n, i, "7.2(DAut=Aut)"]); fi;
    # Theorem 8.1
    d := Length(MinimalGeneratingSet(G));
    if dA > Size(D)^d then Fail([n, i, "8.1"]); fi;
    if IsSubgroup(FrattiniSubgroup(G), D) and (Size(D)^d mod dA <> 0) then
      Fail([n, i, "8.1(div)"]); fi;
  od;
  Print("order ", n, " done\n");
od;
Print("DAUT1 ", triv, "\nFAILURES ", Length(bad), "\nFINAL\n");
QUIT;
