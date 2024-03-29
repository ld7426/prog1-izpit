(* 1.naloga *)

(* a *)
let pravokotni a b c = (a*a +b*b = c*c) || (b*b + c*c = a*a) || (a*a + c*c = b*b)

(* b *)

let rec geometrijsko a q n =
match n with
| 0 -> []
| k -> a :: (geometrijsko (a*q) q (k-1))

(* c *)

let premesaj (a, b, (c, d, e)) = (c, d, (a, e, c))

(* d *)

let odberi seznam indeksi = 
let arrayseznam = Array.of_list seznam in
let rec odberiarr arrayseznam1 indeksi1=
match indeksi1 with
| [] -> []
| h :: tail -> arrayseznam1.(h) :: odberiarr arrayseznam1 tail (* indeksiranje v arrayu je O(1), ponovimo ga n-krat, prav tako je O(1) izračun glave in repa v listu *)
in 
odberiarr arrayseznam indeksi


(* Da preverim, da je cerka linearno - če jaz za desetkrat povečam input se za približno 15krat poveča čas, kar ni čisto linearno, je pa blizu..., zgleda celo bolj kot n*logn, ne vem zakaj *) 
let stopaj_odberi n =
let randomseznam k = List.init k (fun _ -> Random.int k) in
let randomindeksi l=  List.sort compare @@ List.init l (fun _ -> Random.int l) in
let zacetek = Sys.time() in
let y = odberi (randomseznam n) (randomindeksi n) in
let konec = Sys.time() in
(List.nth y 1, konec-.zacetek)
