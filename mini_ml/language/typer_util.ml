open Type_system
open Ast

exception Constraint_error of type_lang * type_lang
exception Typing_error of Util.Position.t * string

module Counter = struct
  type t = int ref

  let create () = ref 0

  let get_fresh counter =
    let res = !counter in
    counter := !counter + 1;
    res
end

let type_of_built_in (built_in : built_in) =
  match built_in with
  | Add | Sub | Mul | Pow | Div | Mod ->
      TFunc ([], TInt, TFunc ([], TInt, TInt))
  | And | Or -> TFunc ([], TBool, TFunc ([], TBool, TBool))
  | Eq | Neq | Lt | Gt | Leq | Geq ->
      let a = 0 in
      TFunc ([ a ], TUniv a, TFunc ([ a ], TUniv a, TBool))
  | Concat -> TFunc ([], TString, TFunc ([], TString, TString))
  | Cat ->
      let a = 0 in
      TFunc ([ a ], TUniv a, TFunc ([ a ], TList ([ a ], TUniv a), TList ([ a ], TUniv a)))
  | Append ->
      let a = 0 in
      TFunc ([ a ], TList ([ a ], TUniv a), TFunc ([ a ], TList ([ a ], TUniv a), TList ([ a ], TUniv a)))
  | UMin -> TFunc ([], TInt, TInt)
  | Not -> TFunc ([], TBool, TBool)
  | Head ->
      let a = 0 in
      TFunc ([ a ], TList ([ a ], TUniv a), TUniv a)
  | Tail ->
      let a = 0 in
      TFunc ([ a ], TList ([ a ], TUniv a), TList ([ a ], TUniv a))
  | Print ->
      let a = 0 in
      TFunc ([ a ], TUniv a, TUnit)

let occurs_in_type univ t =
  let rec aux = function
    | TFunc (_, a, r) -> aux a || aux r
    | TList (_, t) -> aux t
    | TUniv n -> n = univ
    | _ -> false
  in
  aux t

let rec solve_constraints constraints =
  match constraints with
  | [] -> []
  | (t1, t2) :: rest when t1 = t2 -> solve_constraints rest
  | (TUniv n, t) :: rest
  | (t, TUniv n) :: rest ->
      if occurs_in_type n t then raise (Constraint_error (TUniv n, t))
      else
        let rest = List.map (substitute_constraint n t) rest in
        let subst = solve_constraints rest in
        (n, t) :: subst
  | (TFunc (g1, a1, r1), TFunc (g2, a2, r2)) :: rest ->
      solve_constraints ((a1, a2) :: (r1, r2) :: rest)
  | (TList (_, t1), TList (_, t2)) :: rest ->
      solve_constraints ((t1, t2) :: rest)
  | (t1, t2) :: _ -> raise (Constraint_error (t1, t2))

let instantiate (counter : Counter.t) (type_lang : type_lang) : type_lang =
  let rec aux = function
    | TFunc (generic, arg, res) ->
        let arg = aux arg in
        let res = aux res in
        let subst =
          List.map
            (fun univ -> (univ, TUniv (Counter.get_fresh counter)))
            generic
        in
        let arg = Type_system.apply_subst_in_type subst arg in
        let res = Type_system.apply_subst_in_type subst res in
        TFunc ([], arg, res)
    | TList (generic, t) ->
        let t = aux t in
        let subst =
          List.map
            (fun univ -> (univ, TUniv (Counter.get_fresh counter)))
            generic
        in
        let t = Type_system.apply_subst_in_type subst t in
        TList ([], t)
    | other -> other
  in
  aux type_lang
