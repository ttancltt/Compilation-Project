%{
(* On retourne juste unit *)
%}

%token FUN
%token T
%token ARROW
%token LPAREN RPAREN
%token EOF

%left APPLY

%start <unit> main
%type <unit> expr
%type <unit> simple_expr
%type <unit> app_expr

%%

main:
  expr EOF { () }

expr:
  | simple_expr                { () }
  | FUN T ARROW expr           { () }
  | app_expr simple_expr %prec APPLY { () }

simple_expr:
  | T                          { () }
  | LPAREN expr RPAREN         { () }

app_expr:
  | simple_expr                { () }
  | app_expr simple_expr       { () }

(*menhir --interpret --interpret-show-cst test.mly to visualize the parse tree *)
(*menhir --explain test.mly to see the parsing table *)