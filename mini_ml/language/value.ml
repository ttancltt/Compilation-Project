open Ast

type t = (*Definition de la type des valeurs*)
  | Int of int
  | Bool of bool
  | String of string
  | Unit
  | Func_built_in of (t -> t)
  | Func of t Util.Environment.t * string * expr
  | List of t list

let rec pp_no_func_env fmt = function (*This function prints a value without its environment *)
  | Int i -> Format.fprintf fmt "%d" i
  | Bool b -> Format.fprintf fmt "%b" b
  | String s -> Format.fprintf fmt "%s" s
  | Unit -> Format.fprintf fmt "()"
  | Func_built_in _ -> Format.fprintf fmt "<fun>"
  | Func (_, n, e) ->
      Format.fprintf fmt "<...> fun %s -> %a" n (pp_expr true false) e
  | List l ->
      Format.fprintf fmt "[";
      List.iteri
        (fun i e ->
          Format.fprintf fmt "%s%a" (if i = 0 then "" else ";") pp_no_func_env e)
        l;
      Format.fprintf fmt "]"

let rec pp fmt = function (*This function prints a value with its environment *)
  | Func (env, n, e) ->
      Format.fprintf fmt "@[<h>%a@] fun %s -> %a"
        (Util.Environment.pp_environment pp_no_func_env)
        env n (pp_expr true false) e
  | List l ->
      Format.fprintf fmt "[";
      List.iteri
        (fun i e -> Format.fprintf fmt "%s%a" (if i = 0 then "" else ";") pp e)
        l;
      Format.fprintf fmt "]"
  | expr -> pp_no_func_env fmt expr

let func_of_built_in = function (*This function converts a built-in function to a value of type t *)
  | Add ->
      Func_built_in
        (function
        | Int v1 ->
            Func_built_in
              (function
              | Int v2 -> Int (v1 + v2)
              | _ -> failwith "second argument of Add is not an integer")
        | _ -> failwith "first argument of Add is not an integer")
  | Sub ->
      Func_built_in
        (function
        | Int v1 ->
            Func_built_in
              (function
              | Int v2 -> Int (v1 - v2)
              | _ -> failwith "second argument of Sub is not an integer")
        | _ -> failwith "first argument of Sub is not an integer")
  | Mul ->
      Func_built_in
        (function
        | Int v1 ->
            Func_built_in
              (function
              | Int v2 -> Int (v1 * v2)
              | _ -> failwith "second argument of Mul is not an integer")
        | _ -> failwith "first argument of Mul is not an integer")
  | Div ->
      Func_built_in
        (function
        | Int v1 ->
            Func_built_in
              (function
              | Int v2 -> Int (v1 / v2)
              | _ -> failwith "second argument of Div is not an integer")
        | _ -> failwith "first argument of Div is not an integer")
  | Mod ->
      Func_built_in
        (function
        | Int v1 ->
            Func_built_in
              (function
              | Int v2 -> Int (v1 mod v2)
              | _ -> failwith "second argument of Mod is not an integer")
        | _ -> failwith "first argument of Mod is not an integer")
  | And ->
      Func_built_in
        (function
        | Bool v1 ->
            Func_built_in
              (function
              | Bool v2 -> Bool (v1 && v2)
              | _ -> failwith "second argument of And is not a bool")
        | _ -> failwith "first argument of And is not a bool")
  | Or ->
      Func_built_in
        (function
        | Bool v1 ->
            Func_built_in
              (function
              | Bool v2 -> Bool (v1 || v2)
              | _ -> failwith "second argument of Or is not a bool")
        | _ -> failwith "first argument of Or is not a bool")
  | Eq -> Func_built_in (fun v1 -> Func_built_in (fun v2 -> Bool (v1 = v2)))
  | Neq -> Func_built_in (fun v1 -> Func_built_in (fun v2 -> Bool (v1 <> v2)))
  | Lt -> Func_built_in (fun v1 -> Func_built_in (fun v2 -> Bool (v1 < v2)))
  | Gt -> Func_built_in (fun v1 -> Func_built_in (fun v2 -> Bool (v1 > v2)))
  | Leq -> Func_built_in (fun v1 -> Func_built_in (fun v2 -> Bool (v1 <= v2)))
  | Geq -> Func_built_in (fun v1 -> Func_built_in (fun v2 -> Bool (v1 >= v2)))
  | Concat ->
      Func_built_in
        (function
        | String v1 ->
            Func_built_in
              (function
              | String v2 -> String (v1 ^ v2)
              | _ -> failwith "second argument of Concat is not a string")
        | _ -> failwith "first argument of Concat is not a string")
  | Cat ->
      Func_built_in
        (fun v1 ->
          Func_built_in
            (function
            | List v2 -> List (v1 :: v2)
            | _ -> failwith "second argument of Cat is not a list"))
  | Append ->
      Func_built_in
        (function
        | List v1 ->
            Func_built_in
              (function
              | List v2 -> List (v1 @ v2)
              | _ -> failwith "second argument of Append is not a list")
        | _ -> failwith "first argument of Append is not a list")
  | UMin ->
      Func_built_in
        (function
        | Int v -> Int (-v)
        | _ -> failwith "argument of UMin is not an integer")
  | Not ->
      Func_built_in
        (function
        | Bool v -> Bool (not v)
        | _ -> failwith "argument of Not is not a bool")
  | Head ->
      Func_built_in
        (function
        | List v -> List.hd v
        | _ -> failwith "argument of Head is not a list")
  | Tail ->
      Func_built_in
        (function
        | List v -> List (List.tl v)
        | _ -> failwith "argument of Tail is not a list")
  | Print ->
      Func_built_in
        (fun v ->
          (match v with
          | String s -> Format.printf "%s" (Scanf.unescaped s)
          | _ -> Format.printf "%a" pp v);
          Unit)
