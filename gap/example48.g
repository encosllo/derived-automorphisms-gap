# Example 4.8
#
# E = <x, y, t> of order 54 (SmallGroup(54,8)): D(E) = Z(E) of order 3,
# DAut(E) = 1 and D(E/Z(E)) = E/Z(E).
F := FreeGroup("x", "y", "t"); x := F.1;; y := F.2;; t := F.3;;
rels := [x^3, y^3, t^2, Comm(x,y)^3, Comm(Comm(x,y),x), Comm(Comm(x,y),y),
         t*x*t^-1*x, t*y*t^-1*y];
E54 := Image(IsomorphismPcGroup(F/rels));
r := Data(E54);
Q := E54/r.Z;
Print("order ", Size(E54), ", id ", IdGroup(E54), ", |DAut(E)| = ", Size(r.DA),
      ", D(E) = Z(E): ", r.D = r.Z, ", |Z(E)| = ", Size(r.Z),
      ", D(E/Z) = E/Z: ", Size(DNorm(Q, DerSubs(Q))) = Size(Q), "\nFINAL\n");
QUIT;
