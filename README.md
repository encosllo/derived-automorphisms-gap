# GAP code for "Derived automorphisms of finite groups"

This repository contains the [GAP](https://www.gap-system.org) programs used for the computations
reported in

> L. Gong, Y. Yan and E. Cosme Llópez, *Derived automorphisms of finite groups*.

together with the output of the runs (`logs/`).

An automorphism of a finite group $G$ is *derived* if it leaves invariant the derived subgroup $H'$ of every
subgroup $H\le G$. Notation follows the paper: $\mathrm{DAut}(G)$ is the group of derived automorphisms,
$D(G)$ is the intersection of the normalizers of the derived subgroups of all subgroups of $G$ (the derived
norm of Li and Shen), $\mathrm{Aut}_{\mathrm{cent}}(G)$ is the group of central automorphisms, and
$\mathcal P(G)$ is the group of automorphisms inducing a power automorphism on $G'$.
Theorem and section numbers refer to the paper.

## Requirements

GAP 4.16 or later, with the SmallGroups library (included in the standard GAP distribution).
The runs in `logs/` were made with GAP 4.16.1. The shell script needs `bash` and `xargs`.

## Files

| File | Contents |
|---|---|
| `lib.g` | Common functions: the derived subgroups of all subgroups (`DerSubs`), $D(G)$ (`DNorm`), $\mathrm{DAut}(G)$, $\mathrm{Inn}(G)$, $\mathrm{Aut}_{\mathrm{cent}}(G)$, $C_{\mathrm{Aut}(G)}(G')$ and $Z_2(G)$ (`Data`), $\mathcal P(G)$ (`PowOnDer`) and the power automorphisms (`PAutOf`). Must be loaded before the other scripts. |
| `theorems.g` | Checks Lemma 2.2, Theorem 2.9, Proposition 7.8, Theorem 7.2, Theorem 8.1 and the results of Li and Shen used in the paper for every group of a range of orders. It also lists the groups with $\mathrm{DAut}(G)=1$ (Table 1) and the groups relevant to Question 9.4. |
| `order192.g` | Groups of order 192 with $\mathrm{DAut}(G)=1$ (Table 1), among those satisfying the necessary conditions of Theorem 3.2 and Corollary 3.3. |
| `table1.g` | The columns of Table 1 and the remarks after it: $\mathrm{DAut}(G)=1$, $Z(G)$, $G/G'$ and $Z(G)\le G'\cap\Phi(G)$ for the 28 groups. |
| `example48.g` | Example 4.8: builds the group $E$ of order 54 and checks its claims. |
| `frattini_free.g` | Section 5: checks Theorem C, Theorem 5.3, Corollary 5.4 and Theorem 5.5 for the Frattini-free groups of order at most 120 (except 64 and 96). |
| `example_coprime.g` | Example after Corollary 6.6: $\mathrm{DAut}(S_3\times(C_7\rtimes C_3))$. |
| `direct_powers.g` | Theorem 6.11 and Corollaries 6.12 and 6.13: $\mathrm{DAut}(K^n)$ and $D(K^n)$ for dihedral groups, Frobenius groups, $A_4$ and $S_3$. |
| `example614.g` | Example 6.14: $K=$ `SmallGroup(100,10)`. |
| `proposition616.g` | Proposition 6.16: $K=D_{14}\times(C_7\rtimes C_3)=$ `SmallGroup(294,9)`. |
| `remark83.g` | Remark 8.3: groups attaining the bound of Theorem 8.1. |
| `question92.g` | Remarks before Question 9.2: compares $\mathrm{DAut}(K^2)$ with $\mathcal P(K^2)$. |
| `synchronization.g` | Exploratory search related to Theorem 6.11 (see below). |
| `run_checks.sh` | Reproduces all the files in `logs/`. |
| `logs/` | Output of the runs. |

## Usage

`theorems.g` reads the range of orders from the variables `nmin` and `nmax`, and an optional list `skip`
of orders to omit. `synchronization.g` reads `nmax`, or a list `GROUPS` of SmallGroups identifiers.
For example:

```
gap -q -c 'nmin:=1;; nmax:=100;;' lib.g theorems.g
gap -q lib.g proposition616.g
```

To reproduce all the logs (4 parallel processes, a few hours):

```
./run_checks.sh
```

Output lines:
- `theorems.g`: `FAIL <tag> [n, i]` for every failure of a statement (there are none). The last lines list
  the groups with $\mathrm{DAut}(G)=1$ (`DAUT1`), the groups with $D(G)=Z_2(G)$,
  $C_{\mathrm{Aut}(G)}(G')=\mathrm{Aut}_{\mathrm{cent}}(G)$ and $\mathrm{DAut}(G)\ne\mathrm{Aut}_{\mathrm{cent}}(G)$
  (`Q94`), and the number of failures.
- `frattini_free.g`: the number of groups tested and the list of failures.
- The other scripts print the quantities stated in the paper.
- Every run ends with a line `FINAL`.

## Results

- **General statements** (`theorems.g`, all groups of order at most 200 except 128 and 192): no failures.
- **Table 1** (`theorems.g`, `order192.g`, `table1.g`): there are exactly 28 groups of order at most 200
  with $\mathrm{DAut}(G)=1$. There are none of order 128 (Corollary 3.4). For order 192, $\mathrm{DAut}(G)$ was
  computed for the 47 groups satisfying the necessary conditions, and 7 of them have $\mathrm{DAut}(G)=1$.
  $Z(G)\le G'\cap\Phi(G)$ holds except for $C_2$ and $C_2\times A_5$, which have a direct factor $C_2$.
- **Question 9.4** (`theorems.g`): there is no group of order at most 200, other than 128 and 192, with
  $D(G)=Z_2(G)$, $C_{\mathrm{Aut}(G)}(G')=\mathrm{Aut}_{\mathrm{cent}}(G)$ and
  $\mathrm{DAut}(G)\ne\mathrm{Aut}_{\mathrm{cent}}(G)$.
- **Section 5** (`frattini_free.g`): 284 Frattini-free groups tested, no failures.
- **Example 4.8** (`example48.g`): $E=$ `SmallGroup(54,8)`, $D(E)=Z(E)$ has order 3, $\mathrm{DAut}(E)=1$ and
  $D(E/Z(E))=E/Z(E)$.
- **Direct products and powers**: $|\mathrm{DAut}(S_3\times(C_7\rtimes C_3))|=252$
  (`example_coprime.g`); the orders of $\mathrm{DAut}(K^n)$ and $D(K^n)$ agree with Corollaries 6.12 and 6.13
  (`direct_powers.g`); for $K=$ `SmallGroup(100,10)`, $|\mathrm{DAut}(K^2)|=|\mathcal P(K^2)|=4\cdot25^2$
  (`example614.g`); for $K=$ `SmallGroup(294,9)`, $|\mathrm{DAut}(K^2)|=36\cdot49^2$ and
  $|\mathcal P(K^2)|=6\cdot49^2$ (`proposition616.g`).
- **Remark 8.3** (`remark83.g`): among the groups of order at most 100 (except 64 and 96) with
  $\mathrm{DAut}(G)\ne1$, only `SmallGroup(72,15)` attains the bound of Theorem 8.1.
- **Question 9.2** (`question92.g`): $\mathrm{DAut}(K^2)=\mathcal P(K^2)$ for the 45 nonabelian groups $K$ of
  order at most 31 and the 5 centerless groups $K$ of order 32 to 40; the equality fails for
  `SmallGroup(32,i)`, $i=6,7,8$.
- **Exploratory search** (`synchronization.g`): let $K$ be a centerless group with $A=K'$ abelian and
  $C_K(A)=A$. For every common restriction $\beta\in Z(R(K))\cap R_D(K)$ allowed by Theorem 6.11(1) that is
  not a power map, the script looks for a subgroup $\langle w,(k,l)\rangle\le K^2$, with $w\in A^2$, whose
  derived subgroup is not invariant under $\sigma\times\sigma$ ($\sigma|_A=\beta$). For all such $K$ of order
  at most 120 every candidate is eliminated. For $K=$ `SmallGroup(294,9)` none of the 30 candidates is
  eliminated, in agreement with Proposition 6.16.

## License

The code (all `.g` and `.sh` files) is released under the MIT License (see `LICENSE`).
The output of the computations in `logs/` is released under the Creative Commons Attribution 4.0
International License (CC BY 4.0; see `logs/LICENSE`).

## How to cite

Please cite the article above. Citation metadata for this code are in `CITATION.cff`.
