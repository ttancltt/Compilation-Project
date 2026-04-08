open Ast
open Typer_util

let annotate expr typ =
  Annotation.set_type (Ast.get_expr_annotation expr) typ;
  typ

let fresh_type counter = TUniv (Counter.get_fresh counter)

let rec type_expr (counter : Counter.t) (env : type_lang Util.Environment.t)
    (expr : expr) : type_lang * (type_lang * type_lang) list =
  match expr with
  | Cst_i (_, ann) -> annotate expr TInt, []
  | Cst_b (_, ann) -> annotate expr TBool, []
  | Cst_str (_, ann) -> annotate expr TString, []
  | Cst_func (builtin, ann) ->
      let typ = type_of_built_in builtin in
      annotate expr typ, []
  | Nil ann ->
      let a = Counter.get_fresh counter in
      let typ = TList ([ a ], TUniv a) in
      Annotation.set_type ann typ;
      typ, []
  | Unit ann -> annotate expr TUnit, []
  | Var (name, ann) ->
      (match Util.Environment.get env name with
      | Some typ -> annotate expr typ, []
      | None ->
          raise
            (Typing_error
               (Annotation.get_pos ann, "unbound variable " ^ name)))
  | IfThenElse (cond, th, el, ann) ->
      let t_cond, c_cond = type_expr counter env cond in
      let t_th, c_th = type_expr counter env th in
      let t_el, c_el = type_expr counter env el in
      let result = fresh_type counter in
      let constraints =
        (t_cond, TBool)
        :: (t_th, result) :: (t_el, result) :: c_cond @ c_th @ c_el
      in
      annotate expr result, constraints
  | App (e1, e2, ann) ->
      let t1, c1 = type_expr counter env e1 in
      let t2, c2 = type_expr counter env e2 in
      let result = fresh_type counter in
      let constraints =
        (t1, TFunc ([], t2, result)) :: c1 @ c2
      in
      annotate expr result, constraints
  | Fun (param, body, ann) ->
      let arg_type = fresh_type counter in
      Util.Environment.add env param arg_type;
      let body_type, body_constraints = type_expr counter env body in
      Util.Environment.remove env param;
      let typ = TFunc ([], arg_type, body_type) in
      annotate expr typ, body_constraints
  | Let (recursive, name, e1, e2, ann) ->
      if recursive then
        let placeholder = fresh_type counter in
        Util.Environment.add env name placeholder;
        let t1, c1 = type_expr counter env e1 in
        Util.Environment.add env name t1;
        let t2, c2 = type_expr counter env e2 in
        Util.Environment.remove env name;
        Util.Environment.remove env name;
        annotate expr t2, c1 @ c2
      else
        let t1, c1 = type_expr counter env e1 in
        Util.Environment.add env name t1;
        let t2, c2 = type_expr counter env e2 in
        Util.Environment.remove env name;
        annotate expr t2, c1 @ c2
  | Ignore (e1, e2, ann) ->
      let _, c1 = type_expr counter env e1 in
      let t2, c2 = type_expr counter env e2 in
      annotate expr t2, c1 @ c2
