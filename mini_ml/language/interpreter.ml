open Ast
open Value

let rec interpret_expression (env : Value.t Util.Environment.t) (expr : expr) : Value.t =
  match expr with
  (* 1. Constantes et fonctions de base *)
  | Cst_i (i, _) -> Int i
  | Cst_b (b, _) -> Bool b
  | Cst_str (s, _) -> String s
  | Cst_func (f, _) -> func_of_built_in f
  | Nil _ -> List []
  | Unit _ -> Unit

  (* 2. Accès aux variables *)
  | Var (x, _) -> 
      begin match Util.Environment.get env x with 
      | Some v -> v
      | None -> failwith ("Erreur : la variable '" ^ x ^ "' n'est pas définie.")
      end

  (* 3. Structure de contrôle (Paresseux : on n'évalue que la branche prise) *)
  | IfThenElse (test, e2, e3, _) ->
      begin match interpret_expression env test with
      | Bool true -> interpret_expression env e2
      | Bool false -> interpret_expression env e3
      | _ -> failwith "Erreur : la condition du 'if' doit être un booléen."
      end

  (* 4. Séquencement *)
  | Ignore (e1, e2, _) ->
      let _ = interpret_expression env e1 in (* Évalué pour l'effet de bord *)
      interpret_expression env e2

  (* 5. Définition de fonction (Clôture) *)
  | Fun (x, body, _) ->
      (* IMPORTANT : On copie l'environnement actuel pour la clôture *)
      Func (Util.Environment.copy env, x, body)

  (* 6. Application de fonction *)
  | App (e1, e2, _) ->
      (* Sujet : L'argument (e2) est évalué AVANT la fonction (e1) *)
      let v_arg = interpret_expression env e2 in 
      let v_func = interpret_expression env e1 in
      begin match v_func with
      | Func (closure_env, x, body) ->
          (* On crée un nouvel environnement à partir de la clôture *)
          let local_env = Util.Environment.copy closure_env in
          Util.Environment.add local_env x v_arg;
          interpret_expression local_env body
      | Func_built_in f -> f v_arg
      | _ -> failwith "Erreur : tentative d'appel sur une valeur non-fonctionnelle."
      end

  (* 7. Liaison locale (Let / Let rec) *)
  | Let (is_rec, x, e1, e2, _) ->
      let v1 = interpret_expression env e1 in
      
      (* Si récursif, on injecte v1 dans sa propre clôture *)
      if is_rec then begin
        match v1 with
        | Func (closure_env, _, _) -> 
            Util.Environment.add closure_env x v1
        | _ -> () (* Seules les fonctions peuvent être récursives ici *)
      end;

      (* Ajout dans l'environnement courant pour évaluer e2 *)
      Util.Environment.add env x v1;
      let result = interpret_expression env e2 in
      
      (* IMPORTANT : On retire la variable après l'évaluation pour respecter la portée *)
      Util.Environment.remove env x;
      result

(* Interpréteur de requêtes top-level *)
let interpret_program (env : Value.t Util.Environment.t) (prg : req list) : unit =
  List.iter
    (fun (is_rec, name, expr) ->
      let v = interpret_expression env expr in
      if is_rec then (
         match v with
         | Func (closure_env, _, _) -> Util.Environment.add closure_env name v
         | _ -> ()
      );
      Util.Environment.add env name v;
      Format.printf "Computed %s = %a@," name Value.pp v)
    prg