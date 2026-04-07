🎯 Mục đích chính

visualiser.ml tạo ra executable visualiser.out, dùng để:

👉 Hiển thị các bước phân tích cú pháp (parsing)

Các trạng thái của automaton (Menhir)
Các bước shift / reduce
Cách input được phân tích thành AST

Vd : thien@DESKTOP-ENGQKK1:/mnt/c/Users/thien/Downloads/mini_ml$ ./visualiser.out -from-stdin "let x = (100)"

Cú pháp đúng để test với visualiser.out:

./visualiser.out  "./examples/correct/simple_syntax/fibo.mml"

Parser_sandbox.mly có ghi chú thích của các hàm để hiểu hơn về projeet

test.mly is used to test 4.1 Paser simple exo 5
(*menhir --interpret --interpret-show-cst test.mly to visualize the parse tree *)
(*menhir --explain test.mly to see the parsing table *)


Để tạo ra AST `App (App (Cst_func Add) (Cst_i 1)) (Cst_i 2)`, input từ bàn phím cần phải là:

```
(+) 1 2
```

### Giải thích cách parser xử lý:

1. **Parse `(+)`**:
   - Lexer: `L_PAR`, `ADD`, `R_PAR`
   - Parser khớp quy tắc `built_in -> L_PAR b=binop R_PAR`:
     - `binop` khớp `ADD` → `Add` (thay `{ Add }`)
   - Result: `Cst_func(Add, Annotation.create $loc)`

2. **Parse `1`**:
   - Lexer: `INT(1)`
   - Parser khớp quy tắc `simple_expr -> INT`:
     - Result: `Cst_i(1, Annotation.create $loc)`

3. **Parse `(+) 1`** (Application lần 1):
   - Parser khớp quy tắc `expr -> e1=app_expr e2=simple_expr`:
     - `e1 = app_expr` khớp `Cst_func(Add, ...)` (từ bước 1)
     - `e2 = simple_expr` khớp `Cst_i(1, ...)` (từ bước 2)
   - Result: `App(Cst_func(Add, ...), Cst_i(1, ...), Annotation.create $loc)`

4. **Parse `2`**:
   - Lexer: `INT(2)`
   - Parser khớp `simple_expr -> INT`:
     - Result: `Cst_i(2, Annotation.create $loc)`

5. **Parse `(+) 1 2`** (Application lần 2):
   - Parser khớp quy tắc `expr -> e1=app_expr e2=simple_expr`:
     - `e1 = app_expr` khớp `App(...)` (từ bước 3)
     - `e2 = simple_expr` khớp `Cst_i(2, ...)` (từ bước 4)
   - Result: `App(App(Cst_func(Add, ...), Cst_i(1, ...)), Cst_i(2, ...), Annotation.create $loc)`

### Tóm lại:
Input bàn phím: **`(+) 1 2`**
- Dấu ngoặc `(+)` được parser nhận ra là built-in function `Add`.
- Space giữa `1` và `2` tạo ra hai application riêng biệt → nested `App` nodes.

Nếu muốn test, bạn có thể chạy chương trình với input `(+) 1 2` và xem output AST!

Read [](file:///c%3A/Users/thien/Downloads/Compilation-Project/mini_ml/README.md#1-1), lines 1 to 50

Read [](file:///c%3A/Users/thien/Downloads/Compilation-Project/mini_ml/README.md#51-51), lines 51 to 65

Mini-ML là một ngôn ngữ lập trình nhỏ gọn, lấy cảm hứng từ OCaml, hỗ trợ hai cú pháp chính để dễ dàng parsing và testing:

### 1. **Cú pháp chính của mini-ML**:
Mini-ML hỗ trợ **hai dạng cú pháp** (syntax) để phù hợp với các parser khác nhau:
- **Simple Syntax** (ít keyword, dùng prefix cho operators – dùng trong `Parser_calc.mly` và `Parser_simple.mly`): 
  - Phù hợp cho parsing cơ bản, operators như `+` được viết dưới dạng `(+)` (function application).
  - Ví dụ: `(+) 1 2` thay vì `1 + 2`.
- **Extended Syntax** (giống OCaml, dùng infix operators – dùng trong `Parser.mly`):
  - Phù hợp cho code tự nhiên hơn, với `let`, `if`, `fun`, infix `+`, `::`, etc.
  - Ví dụ: `1 + 2`, `let x = 1 in x + 2`, `if true then 1 else 2`.

**Các thành phần cú pháp chung**:
- **Constants**: Số nguyên (`1`), boolean (`true`/`false`), string (`"hello"`), unit (`()`), list rỗng (`[]`).
- **Variables**: Tên biến (`x`, `y`, `fibo`).
- **Expressions**:
  - Số học: `1 + 2` (extended) hoặc `(+) 1 2` (simple).
  - Functions: `fun x -> x + 1` (extended) hoặc `fun x -> (+) x 1` (simple).
  - Let bindings: `let x = 1 in x + 2` (cả hai).
  - If-then-else: `if true then 1 else 2`.
  - Lists: `[1; 2; 3]`, `1 :: [2]`, `hd [1]`, `tl [1]`.
  - Built-ins: `(+)`, `(-)`, `(*)`, `(=)`, `(<)`, `print`, `neg`, etc.
- **Programs**: Danh sách let-bindings (top-level), ví dụ: `let x = 1 let y = x + 2`.

### 2. **Ví dụ phương trình đơn giản: `1 + 2`**
Tôi chọn ví dụ **simple syntax** với input `"(+) 1 2"` (tương đương `1 + 2`), vì parser calc dùng cú pháp này và đã có ví dụ trước. Nếu dùng extended syntax, input sẽ là `"1 + 2"` và parser sẽ xử lý infix trực tiếp.

Dưới đây là **từng bước lexer và parser xử lý** input `"(+) 1 2"` (simple syntax). Giả sử dùng `Parser_calc.mly` (không có infix precedence, chỉ left-associative application).

#### **Bước 1: Lexer (Lexer.mll) – Tokenization**
Lexer đọc input và chuyển thành stream of tokens (loại bỏ whitespace/comments).
- Input: `"(+) 1 2"`
- Xử lý:
  - `"("` → Token `L_PAR`
  - `"+"` → Token `ADD` (từ quy tắc `| "+" { ADD }`)
  - `")"` → Token `R_PAR`
  - `" "` (space) → Bỏ qua (từ quy tắc `| [' ' '\t' '\r'] { token lexbuf }`)
  - `"1"` → Token `INT(1)` (từ quy tắc `| digit+ { INT(int_of_string (Lexing.lexeme lexbuf)) }` – giả sử có quy tắc này)
  - `" "` → Bỏ qua
  - `"2"` → Token `INT(2)`
  - End of input → Token `EOF` (tự động)
- **Kết quả stream tokens**: `[L_PAR, ADD, R_PAR, INT(1), INT(2), EOF]`

#### **Bước 2: Parser (Parser_calc.mly) – Xây dựng AST**
Parser dùng grammar rules để khớp tokens và tạo AST. Dùng shift-reduce automaton (có thể visualize với `./visualiser.out`).
- **Quy tắc chính** (từ `Parser_calc.mly`):
  - `main: expr EOF { [(false,"result",e)] }` (wrap expression thành program).
  - `expr: | e=simple_expr { e } | FUN x=ID ARROW e=expr { Fun(x,e,Annotation.create $loc) } | e1=app_expr e2=simple_expr { App(e1,e2,Annotation.create $loc) }`
  - `simple_expr: | i=INT { Cst_i(i,Annotation.create $loc) } | f=built_in { Cst_func(f,Annotation.create $loc) } | ...`
  - `app_expr: | f=simple_expr { f } | f=app_expr e=simple_expr { App(f,e,Annotation.create $loc) }`
  - `built_in: | L_PAR b=binop R_PAR { b } | ...`
  - `binop: | ADD { Add }`

- **Xử lý từng bước parsing** (shift/reduce):
  1. **Parse `(+)` (built-in function)**:
     - Shift: `L_PAR`, `ADD`, `R_PAR`.
     - Reduce: Khớp `built_in → L_PAR binop R_PAR` (với `binop → ADD` → `Add`).
     - Semantic action: `{ Cst_func(Add, Annotation.create $loc) }`
     - Kết quả: `Cst_func(Add, annotation)` (AST node cho function `+`).

  2. **Parse `1` (integer)**:
     - Shift: `INT(1)`.
     - Reduce: Khớp `simple_expr → INT` → `Cst_i(1, Annotation.create $loc)`.
     - Kết quả: `Cst_i(1, annotation)`.

  3. **Parse `(+) 1` (application lần 1)**:
     - Shift: Tokens từ bước 1 và 2.
     - Reduce: Khớp `expr → e1=app_expr e2=simple_expr` (với `e1=app_expr` = `Cst_func(Add)`, `e2=simple_expr` = `Cst_i(1)`).
     - Semantic action: `{ App(e1, e2, Annotation.create $loc) }`
     - Kết quả: `App(Cst_func(Add, ...), Cst_i(1, ...), annotation)` (AST: apply `+` to `1`).

  4. **Parse `2` (integer)**:
     - Shift: `INT(2)`.
     - Reduce: Khớp `simple_expr → INT` → `Cst_i(2, Annotation.create $loc)`.
     - Kết quả: `Cst_i(2, annotation)`.

  5. **Parse `(+) 1 2` (application lần 2)**:
     - Shift: Tokens từ bước 3 và 4.
     - Reduce: Khớp `expr → e1=app_expr e2=simple_expr` (với `e1=app_expr` = `App(...)` từ bước 3, `e2=simple_expr` = `Cst_i(2)`).
     - Semantic action: `{ App(e1, e2, Annotation.create $loc) }`
     - Kết quả: `App(App(Cst_func(Add, ...), Cst_i(1, ...)), Cst_i(2, ...), annotation)` (AST đầy đủ: `((+) 1) 2`).

  6. **Wrap thành program**:
     - Shift: `EOF`.
     - Reduce: Khớp `main → expr EOF` → `{ [(false,"result",e)] }`.
     - Kết quả: `[(false, "result", App(...))]` (program với let-binding `result = ((+) 1) 2`).

- **AST cuối cùng**: `App(App(Cst_func Add, Cst_i 1), Cst_i 2)` (tương đương `1 + 2` khi evaluate).

### Tóm lại:
- **Input bàn phím**: `"(+) 1 2"` (simple syntax).
- **Lexer**: Tạo tokens từ input.
- **Parser**: Build AST qua shift/reduce, tạo nested `App` nodes cho application.
- Để test thực tế, chạy `./visualiser.out -from-stdin "(+) 1 2"` để xem automaton và AST!

Nếu muốn ví dụ extended syntax (như `"1 + 2"` với infix), hoặc ví dụ phức tạp hơn (như `let x = 1 + 2`), cho tôi biết nhé! 😊