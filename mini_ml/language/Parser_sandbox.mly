%{
    open Ast
%}

%start <Ast.t> main

%%

main:
e = expr EOF { [(false,"result",e)] } 
(*The construct { [(false,"result",e)] } in the Parser_sandbox.mly file is a semantic action 
in the Menhir parser that wraps the parsed expression e into the AST representation of a mini-ML 
program.

Based on the AST definitions in ast.mli:

A mini-ML program (Ast.t) is a list of top-level requests (req list).
Each request (req) is a tuple (bool * string * expr), representing a let-binding where:
bool indicates if it's recursive (true) or not (false).
string is the variable name being bound.
expr is the expression being assigned.
Here, { [(false,"result",e)] } creates a program with a single, non-recursive let-binding 
that assigns the parsed expression e to a variable named "result". This allows the sandbox parser 
to treat any valid expression as a complete program for testing or evaluation purposes.*)


expr:
| e = simple_expr { e }
| FUN x = ID ARROW e = expr { Fun(x,e,Annotation.create $loc) } (*Ham ẩn danh dạng : fun x -> e *)
| e1 = app_expr e2 = simple_expr { App(e1,e2,Annotation.create $loc) }  (*Dấu = dùng để gán giá trị cho biến*)
 (*Các cụm như Fun(x,e,Annotation.create $loc) hoặc App(f,e,Annotation.create $loc) được 
 sử dụng để tạo ra các biểu thức hàm và ứng dụng hàm trong AST*)
 (*Và lấy ví dụ với dấu "=":
    Khi ta có một cụm với cú pháp FUN x = ID ARROW e = expr { Fun(x,e,Annotation.create $loc) },
    nó sẽ được hiểu là một hàm ẩn danh có tên x, với thân hàm là biểu thức e. Cụm này sẽ được 
    chuyển thành một node trong AST có dạng Fun(x,e,Annotation.create $loc), trong đó x là tên biến, 
    e là biểu thức thân hàm, và Annotation.create $loc là thông tin vị trí trong mã nguồn để hỗ trợ
 *)
simple_expr:
| i = INT { Cst_i(i,Annotation.create $loc) }
| f = built_in { Cst_func(f,Annotation.create $loc) }
| x = ID { Var(x,Annotation.create $loc) }
| L_PAR e = expr R_PAR { e }

app_expr:
| f = simple_expr { f }
| f = app_expr e = simple_expr { App(f,e,Annotation.create $loc)} 

%inline binop:
| ADD   { Add }


%inline built_in:
| L_PAR b = binop R_PAR { b }
| NEG   { UMin }