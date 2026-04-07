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