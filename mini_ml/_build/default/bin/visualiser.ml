module Command_line = struct
  let parse_from_file = ref true

  type parser = Calc | Simple | Extended | Sandbox
  (*rajouter un autre parseur ici si nécessaire (et dans les deux fonctions suivantes).*)

  let parser_of_string = function
    | "calc" -> Calc
    | "raw" -> Simple
    | "extended" -> Extended
    | "sandbox" -> Sandbox
    | _ -> failwith "not a valid parser"

  let string_of_parser = function
    | Calc -> "calc"
    | Simple -> "raw"
    | Extended -> "extended"
    | Sandbox -> "sandbox"

  let parser = ref Extended

  let arg_spec_list =
    [
      ( "-from-stdin",
        Arg.Clear parse_from_file,
        " if present, the argument is a string to parse, otherwise it is the \
         name of the file containing the program." );
      ( "-parser",
        Arg.Symbol
          ([ "calc"; "raw"; "extended" ], fun s -> parser := parser_of_string s),
        " determines which parser is used for parsing the input. (default: "
        ^ string_of_parser !parser ^ ")" );
    ]

  let usage_msg =
    "Usage: " ^ Sys.argv.(0)
    ^ " [argument]\n\
       Parses the argument with the parser and displays the execution of the \
       parser step by step.\n\
       [argument] is either the string to parse or the filename to be analysed \
       (if [-from-stdin] is present)\n"

  let parse () =
    let res = ref None in
    Arg.parse (Arg.align arg_spec_list)
      (fun a ->
        match !res with
        | None -> res := Some a
        | Some _ -> raise (Arg.Bad "Got too many inputs"))
      usage_msg;
    match !res with
    | None ->
        Arg.usage arg_spec_list usage_msg;
        exit 0
    | Some s -> s
end

let str = Command_line.parse ()

module Language_calc_Grammar = MenhirSdk.Cmly_read.Lift (struct
  let file_content = Option.get (Language.Cmly.read "Parser_calc.cmly")
  let prefix = "CMLY" ^ MenhirSdk.Version.version
  let grammar = Marshal.from_string file_content (String.length prefix)
end)

module ProgParser_calc =
  Cairn.Parsing.MakeWithDefaultMessage
    (struct
      type value_parsed = Language.Ast.t
    end)
    (Language.Parser_calc)
    (Language.Lexer)
    (Language_calc_Grammar)

module Language_Grammar = MenhirSdk.Cmly_read.Lift (struct
  let file_content = Option.get (Language.Cmly.read "Parser.cmly")
  let prefix = "CMLY" ^ MenhirSdk.Version.version
  let grammar = Marshal.from_string file_content (String.length prefix)
end)

module ProgParser =
  Cairn.Parsing.MakeWithDefaultMessage
    (struct
      type value_parsed = Language.Ast.t
    end)
    (Language.Parser)
    (Language.Lexer)
    (Language_Grammar)

module Language_simple_Grammar = MenhirSdk.Cmly_read.Lift (struct
  let file_content = Option.get (Language.Cmly.read "Parser_simple.cmly")
  let prefix = "CMLY" ^ MenhirSdk.Version.version
  let grammar = Marshal.from_string file_content (String.length prefix)
end)

module ProgParser_simple =
  Cairn.Parsing.MakeWithDefaultMessage
    (struct
      type value_parsed = Language.Ast.t
    end)
    (Language.Parser_simple)
    (Language.Lexer)
    (Language_simple_Grammar)

(* si vous rajoutez un autre parseur, copiez les deux modules suivants et adaptez-les.*)
module Language_sandbox_Grammar = MenhirSdk.Cmly_read.Lift (struct
  let file_content = Option.get (Language.Cmly.read "Parser_sandbox.cmly")
  let prefix = "CMLY" ^ MenhirSdk.Version.version
  let grammar = Marshal.from_string file_content (String.length prefix)
end)

module ProgParser_sandbox =
  Cairn.Parsing.MakeWithDefaultMessage
    (struct
      type value_parsed = Language.Ast.t
    end)
    (Language.Parser_sandbox)
    (Language.Lexer)
    (Language_sandbox_Grammar)

let text, lexbuf =
  if !Command_line.parse_from_file then MenhirLib.LexerUtil.read str
  else (str, Lexing.from_string str)

let main =
  (match !Command_line.parser with
  | Extended -> ProgParser.parse
  | Simple -> ProgParser_simple.parse
  | Calc -> ProgParser_calc.parse
  | Sandbox ->
      ProgParser_sandbox.parse
      (* si vous rajoutez un parseur, appelez le bon module ici*))
    text lexbuf

let () =
  match main with
  | Some prg ->
      Format.printf "@[<v 0>Program parsed:@,%a@,@]"
        Language.Ast.(pp_program true false)
        prg
  | None -> Format.printf "No program obtained\n"
