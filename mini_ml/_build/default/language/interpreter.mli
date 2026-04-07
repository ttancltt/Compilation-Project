(** Module that contains an interpreter of mini-ml. *)

val interpret_expression : Value.t Util.Environment.t -> Ast.expr -> Value.t
(** Main function that computes the value associated to a mini-ml expression in
    a given environment. *)

val interpret_program : Value.t Util.Environment.t -> Ast.req list -> unit
(** Function that interprets a list of requests. *)
