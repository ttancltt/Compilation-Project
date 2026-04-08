%{
    open Ast
%}

%nonassoc IN ELSE ARROW
%left SEMICOLON
%left OR
%left AND
%left EQ NEQ LT GT LEQ GEQ
%left CONCAT
%right CAT APPEND
%left ADD SUB
%left MUL DIV MOD
%nonassoc UMINUS

%start <Ast.t> main

%%

main:
| l = req_list EOF { l }

req_list:
| r = req l = req_list { r::l }
| r = req { [r] }

req:
| LET name = ID args = list(ID) EQ e = expr 
    { let body = List.fold_right (fun x acc -> Fun(x, acc, Annotation.create $loc)) args e in
      (false, name, body) }
| LET REC name = ID args = list(ID) EQ e = expr 
    { let body = List.fold_right (fun x acc -> Fun(x, acc, Annotation.create $loc)) args e in
      (true, name, body) }

expr:
| e = if_expr { e }

if_expr:
| IF test = expr THEN th = expr ELSE el = expr { IfThenElse(test,th,el,Annotation.create $loc) }
| e = let_expr { e }

let_expr:
| LET x = ID args = list(ID) EQ e1 = expr IN e2 = expr 
    { let body = List.fold_right (fun a acc -> Fun(a, acc, Annotation.create $loc)) args e1 in
      Let(false, x, body, e2, Annotation.create $loc) }
| LET REC x = ID args = list(ID) EQ e1 = expr IN e2 = expr 
    { let body = List.fold_right (fun a acc -> Fun(a, acc, Annotation.create $loc)) args e1 in
      Let(true, x, body, e2, Annotation.create $loc) }
| e = fun_expr { e }

fun_expr:
| FUN x = ID ARROW e = expr { Fun(x,e,Annotation.create $loc) }
| e = seq_expr { e }

seq_expr:
| e1 = seq_expr SEMICOLON e2 = expr { Ignore(e1,e2,Annotation.create $loc) }
| e = or_expr { e }

or_expr:
| e1 = or_expr OR e2 = and_expr { App(App(Cst_func (Or, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = and_expr { e }

and_expr:
| e1 = and_expr AND e2 = cmp_expr { App(App(Cst_func (And, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = cmp_expr { e }

cmp_expr:
| e1 = cmp_expr op = cmp_binop e2 = concat_expr { App(App(Cst_func (op, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = concat_expr { e }

concat_expr:
| e1 = concat_expr CONCAT e2 = list_expr { App(App(Cst_func (Concat, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = list_expr { e }

list_expr:
| e1 = add_expr op = list_binop e2 = list_expr { App(App(Cst_func (op, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = add_expr { e }

add_expr:
| e1 = add_expr ADD e2 = mul_expr { App(App(Cst_func (Add, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e1 = add_expr SUB e2 = mul_expr { App(App(Cst_func (Sub, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = mul_expr { e }

mul_expr:
| e1 = mul_expr MUL e2 = unary_expr { App(App(Cst_func (Mul, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e1 = mul_expr DIV e2 = unary_expr { App(App(Cst_func (Div, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e1 = mul_expr MOD e2 = unary_expr { App(App(Cst_func (Mod, Annotation.create $loc), e2, Annotation.create $loc), e1, Annotation.create $loc) }
| e = unary_expr { e }

unary_expr:
| SUB e = unary_expr %prec UMINUS { App(Cst_func (UMin, Annotation.create $loc), e, Annotation.create $loc) }
| e = app_expr { e }

app_expr:
| f = app_expr a = simple_expr { App(f,a,Annotation.create $loc) }
| f = simple_expr { f }

simple_expr:
| i = INT { Cst_i(i,Annotation.create $loc) }
| b = BOOL { Cst_b(b,Annotation.create $loc) }
| s = STRING { Cst_str(s,Annotation.create $loc) }
| f = built_in { Cst_func(f,Annotation.create $loc) }
| L_PAR R_PAR { Unit(Annotation.create $loc) }
| L_SQ R_SQ { Nil(Annotation.create $loc) }
| L_SQ l = separated_list(SEMICOLON, expr) R_SQ 
    { List.fold_right (fun x acc -> App(App(Cst_func (Cat, Annotation.create $loc), acc, Annotation.create $loc), x, Annotation.create $loc)) l (Nil(Annotation.create $loc)) }
| x = ID { Var(x,Annotation.create $loc) }
| L_PAR e = expr R_PAR { e }

%inline cmp_binop:
| EQ   { Eq }
| NEQ  { Neq }
| LT   { Lt }
| GT   { Gt }
| LEQ  { Leq }
| GEQ  { Geq }

%inline list_binop:
| CAT    { Cat }
| APPEND { Append }

%inline binop:
| ADD   { Add }
| SUB   { Sub }
| MUL   { Mul }
| DIV   { Div }
| MOD   { Mod }
| AND   { And }
| OR    { Or }
| EQ   { Eq }
| NEQ   { Neq }
| LT    { Lt }
| GT    { Gt }
| LEQ   { Leq }
| GEQ   { Geq }
| CONCAT { Concat }
| CAT   { Cat }
| APPEND { Append }

%inline built_in:
| L_PAR b = binop R_PAR { b }
| NEG   { UMin }
| NOT   { Not }
| HEAD  { Head }
| TAIL  { Tail }
| PRINT { Print }
