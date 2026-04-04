open Ast
open Value

let rec interpret_expression (env : Value.t Util.Environment.t) (expr : expr) :
    Value.t =
  (* à modifier *)
  ignore (env, expr, interpret_expression);
  (match func_of_built_in Print with
  | Func_built_in f -> f
  | _ -> failwith "impossible")
    (String "Au Boulot !")

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
