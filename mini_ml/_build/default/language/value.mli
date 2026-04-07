(** Module containing the definition of values manipulated by the language. Akin
    to an abstract machine. *)

(** Type of values being manipulated by a mini-ml program. *)
type t =
  | Int of int
  | Bool of bool
  | String of string
  | Unit
  | Func_built_in of (t -> t)
  | Func of t Util.Environment.t * string * Ast.expr
  | List of t list

val pp : Format.formatter -> t -> unit
(** Pretty-printer for a {!t} *)

val func_of_built_in : Ast.built_in -> t
(** Function that defines the value corresponding to a built-in function*)
