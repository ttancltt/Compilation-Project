open Ast
open Value

let rec interpret_expression (env : Value.t Util.Environment.t) (expr : expr) : Value.t = (*Base on ast.ml *)
  match expr with
  | Cst_i (n, _) -> Int n
  | Cst_b (b, _) -> Bool b
  | Cst_str (s, _) -> String s
  | Nil _ -> List []
  | Unit _ -> Unit
  | Cst_func (b, _) -> func_of_built_in b

  | Var (x, _) ->
      begin match Util.Environment.get env x with
      | Some v -> v
      | None -> failwith ("Unbound variable: " ^ x)
      end

  | IfThenElse (c, t, e, _) ->
      begin match interpret_expression env c with
      | Bool true -> interpret_expression env t
      | Bool false -> interpret_expression env e
      | _ -> failwith "if: condition must be boolean"
      end

  | Ignore (e1, e2, _) ->
      let _ = interpret_expression env e1 in
      interpret_expression env e2

  | Fun (x, body, _) ->
      let env_copy = Util.Environment.copy env in
      Func (env_copy, x, body)

  | App (e1, e2, _) ->
      let v1 = interpret_expression env e1 in
      let v2 = interpret_expression env e2 in
      begin match v1 with
      | Func (env_closure, x, body) ->
          let env' = Util.Environment.copy env_closure in
          Util.Environment.add env' x v2;
          interpret_expression env' body

      | Func_built_in f ->
          f v2

      | _ -> failwith "application of a non-function"
      end

  | Let (is_rec, name, e1, e2, _) ->
      if is_rec then (
        (* let rec name = e1 in e2 *)
        let dummy = ref Unit in
        Util.Environment.add env name !dummy;
        let v1 = interpret_expression env e1 in
        dummy := v1;
        Util.Environment.add env name v1;
        interpret_expression env e2
      ) else (
        let v1 = interpret_expression env e1 in
        Util.Environment.add env name v1;
        interpret_expression env e2
      )



let interpret_program (env : Value.t Util.Environment.t) (prg : req list) : unit
    =
  List.iter
    (fun (r, name, expr) ->
      let v = interpret_expression env expr in
      (if r then
         match v with
         | Func (tau, _, _) -> Util.Environment.add tau name v
         | _ -> ());
      Util.Environment.add env name v;
      Format.printf "Computed %s = %a@," name Value.pp v)
    prg
