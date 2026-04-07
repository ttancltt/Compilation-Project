%{
    open Ast
%}

/* Définition des priorités (de la plus faible à la plus forte) */
%nonassoc IN ELSE ARROW
%left SEMICOLON
%left OR
%left AND
%left EQ NEQ LT GT LEQ GEQ
%right CAT APPEND     /* Opérateurs de listes */
%left ADD SUB
%left MUL DIV MOD
%nonassoc UMINUS      /* Priorité pour le - unaire */

%start <Ast.t> main

%%

main:
| l = req_list EOF { l }

req_list:
| r = req l = req_list { r::l }
| r = req { [r] }

/* Support du sucre : let f x y = e  ==>  let f = fun x -> fun y -> e */
req:
| LET name = ID args = list(ID) EQ e = expr 
    { let body = List.fold_right (fun x acc -> Fun(x, acc, Annotation.create $loc)) args e in
      (false, name, body) }
| LET REC name = ID args = list(ID) EQ e = expr 
    { let body = List.fold_right (fun x acc -> Fun(x, acc, Annotation.create $loc)) args e in
      (true, name, body) }

expr:
| e = simple_expr { e }
/* Infixes : e1 + e2 est transformé en App(App(Cst_func Add, e1), e2) */
| e1 = expr op = binop e2 = expr 
    { App(App(Cst_func op, e1, Annotation.create $loc), e2, Annotation.create $loc) }
/* Minus unaire : -e */
| SUB e = expr %prec UMINUS 
    { App(Cst_func UMin, e, Annotation.create $loc) }
| IF test = expr THEN th = expr ELSE el = expr { IfThenElse(test,th,el,Annotation.create $loc) }
/* Let local avec arguments : let f x = e1 in e2 */
| LET x = ID args = list(ID) EQ e1 = expr IN e2 = expr 
    { let body = List.fold_right (fun a acc -> Fun(a, acc, Annotation.create $loc)) args e1 in
      Let(false, x, body, e2, Annotation.create $loc) }
| LET REC x = ID args = list(ID) EQ e1 = expr IN e2 = expr 
    { let body = List.fold_right (fun a acc -> Fun(a, acc, Annotation.create $loc)) args e1 in
      Let(true, x, body, e2, Annotation.create $loc) }
| FUN x = ID ARROW e = expr { Fun(x,e,Annotation.create $loc) }
| e1 = expr SEMICOLON e2 = expr { Ignore(e1,e2,Annotation.create $loc) }
| e1 = app_expr e2 = simple_expr { App(e1,e2,Annotation.create $loc) } 

simple_expr:
| i = INT { Cst_i(i,Annotation.create $loc) }
| b = BOOL { Cst_b(b,Annotation.create $loc) }
| s = STRING { Cst_str(s,Annotation.create $loc) }
| f = built_in { Cst_func(f,Annotation.create $loc) }
| L_PAR R_PAR { Unit(Annotation.create $loc)}
| x = ID { Var(x,Annotation.create $loc) }
| L_PAR e = expr R_PAR { e }
/* Sucre pour les listes : [1; 2; 3] */
| L_SQ l = separated_list(SEMICOLON, expr) R_SQ 
    { List.fold_right (fun x acc -> App(App(Cst_func Cat, x, Annotation.create $loc), acc, Annotation.create $loc)) l (Nil(Annotation.create $loc)) }

app_expr:
| f = simple_expr { f }
| f = app_expr e = simple_expr { App(f,e,Annotation.create $loc)} 

/* On sépare les binop pour les utiliser en infixe dans 'expr' */
%inline binop:
| ADD   { Add } | SUB   { Sub } | MUL   { Mul } | DIV   { Div } | MOD   { Mod }
| AND   { And } | OR    { Or }
| EQ    { Eq }  | NEQ   { Neq } | LT    { Lt }  | GT    { Gt }  | LEQ   { Leq } | GEQ   { Geq }
| CONCAT { Concat } | CAT { Cat } | APPEND { Append }

%inline built_in:
| L_PAR b = binop R_PAR { b }
| NEG   { UMin }
| NOT   { Not }
| HEAD  { Head }
| TAIL  { Tail }
| PRINT { Print }
