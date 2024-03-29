type element = Variable of char | Constant of char
type result = element list

(* Seznam pravil podamo s pari, ki spremenljivkam priredijo sliko  *)
(* Za vse preslikave bomo predpostavili, da so enolične *)
type rules = (char * result) list
type l_tree = Node of element * l_tree list option

let example0 =
  Node
    ( Variable 'A',
      Some
        [
          Node
            ( Variable 'A',
              Some [ Node (Variable 'A', None); Node (Variable 'B', None) ] );
          Node (Variable 'B', Some [ Node (Variable 'A', None) ]);
        ] )

let rules0 = [ ('A', [ Variable 'A'; Variable 'B' ]); ('B', [ Variable 'A' ]) ]

let example1 =
  Node
    ( Variable '0',
      Some
        [
          Node (Variable '1', None);
          Node (Constant '[', None);
          Node (Variable '0', None);
          Node (Constant ']', None);
          Node (Variable '0', None);
        ] )

let rules1 =
  [
    ('1', [ Variable '1'; Variable '1' ]);
    ( '0',
      [ Variable '1'; Constant '['; Variable '0'; Constant ']'; Constant '0' ]
    );
  ]

(* 2. a) *)

let sestej (bool1, int1, int3) (bool2, int2, int4) = (bool1 && bool2, int1 + int2, int3 + int4)

let preveri (bool1, int1, int3) (bool2, int2, int4) = (bool1 && bool2 && ((max int1 int2) = min int3 int4), max int1 int2, min int3 int4)

let rec globina_ldrevo (ldrevo : l_tree)=
match ldrevo with
| Node (_, Some []) -> (false, -1, -1)
| Node (_, None) -> (true, 0, 0)
| Node (_, Some [head]) -> sestej (true, 1, 1) (globina_ldrevo head)
| Node (ele, Some (head :: tail)) -> preveri (sestej (true, 1, 1) (globina_ldrevo head)) (globina_ldrevo @@ Node (ele, Some tail))

let veljavno ldrevo =
match globina_ldrevo ldrevo with
| (true, _, _) -> true
| (false, _, _) -> false


(* 2. b) *)

let rec preslikaj rules x =
match x with
| Variable a -> preslikajpomozni rules a
| Constant b -> [b]

and preslikajpomozni rulesa aa =
match rulesa with
| (aa, seznam) :: tail -> seznam
| (_, _) :: tail ->  preslikajpomozni tail aa
| [] -> []

(* najprej sem narobe razumel in je ta spodnja koda bla ..., zgornja pa ne deluje
let rec preslikaj rules x =
match x with
| Variable a -> preslikajpomozni rules x
| Constant b -> [b]

and preslikajpomozni rulesa aa =
match rulesa with
| (y, seznam) :: tail when (List.mem aa seznam) -> [y]
| (_, _) :: tail ->  preslikajpomozni tail aa
| [] -> []
*)


(* 2. c) *)

let rec zadnja_vrstica ldrevo =
match ldrevo with
| Node (ele, None) -> [ele]
| Node (ele, Some [head]) -> zadnja_vrstica head
| Node (ele, Some (head::tail)) -> (zadnja_vrstica head) @ (zadnja_vrstica @@ Node (ele, Some tail))
| Node (_, Some []) -> []


(* 2. d) *)


let rec preveri_enolicna rules trenutna =
match rules with
| (x, _) :: tail -> (not (List.mem x trenutna)) && preveri_enolicna tail (x::trenutna)
| [] -> true

(* 2. e *)
