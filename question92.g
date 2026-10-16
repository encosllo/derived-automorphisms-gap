# Remarks before Question 9.2
#
# Compare DAut(K^2) with P(K^2) (automorphisms inducing a power
# automorphism on (K^2)') for
#   (a) every nonabelian group K of order <= 31,
#   (b) every centerless group K of order 32..40,
#   (c) K = SmallGroup(32,i), i = 6, 7, 8, where the equality fails.
# For each K the output is [|DAut|, |P|, P <= DAut, |D|] for K and for K^2.
Line := function(K)
  Print(IdSmallGroup(K), " ", StructureDescription(K), " |Z|=", Size(Centre(K)),
        " K:", TestPow(K), " K^2:", TestPow(DirectProduct(K, K)), "\n");
end;
Print("(a) nonabelian K of order <= 31\n");
for n in [6..31] do for i in [1..NrSmallGroups(n)] do
  K := SmallGroup(n, i);
  if not IsAbelian(K) then Line(K); fi;
od; od;
Print("(b) centerless K of order 32..40\n");
for n in [32..40] do for i in [1..NrSmallGroups(n)] do
  K := SmallGroup(n, i);
  if not IsAbelian(K) and Size(Centre(K)) = 1 then Line(K); fi;
od; od;
Print("(c) SmallGroup(32,i), i = 6, 7, 8\n");
for i in [6, 7, 8] do Line(SmallGroup(32, i)); od;
Print("FINAL\n");
QUIT;
