# Theorem 6.11, Corollaries 6.12 and 6.13
#
# |DAut(K^n)|, |D(K^n)| and whether DAut(K^n) <= Inn(K^n), for dihedral
# groups D_{2m} (m odd), Frobenius groups C_p : C_d, A_4 and S_3.
# Expected: |DAut(D_{2m}^n)| = m^n phi(m), |DAut((C_p:C_d)^n)| = p^n (p-1),
# DAut(A_4^n) = inner automorphisms induced by (A_4^n)' (order 4^n),
# DAut(S_3^n) = Inn induced by D(S_3^n), of order 2 * 3^n.
K := fail;
cases := [[DihedralGroup(10), [2,3]], [DihedralGroup(14), [2,3]],
          [DihedralGroup(18), [2]], [SmallGroup(21,1), [2,3]],
          [SmallGroup(20,3), [2,3]], [SmallGroup(55,1), [2]],
          [SmallGroup(39,1), [2]], [AlternatingGroup(4), [2,3]],
          [SymmetricGroup(3), [1,2,3,4]]];
for c in cases do
  K := c[1];
  for n in c[2] do
    G := DirectProduct(List([1..n], i -> K));
    r := Data(G);
    Print(StructureDescription(K), " n=", n, " |DAut|=", Size(r.DA), " |D|=", Size(r.D),
          " DAut<=Inn:", IsSubgroup(r.Inn, r.DA), "\n");
  od;
od;
Print("FINAL\n");
QUIT;
