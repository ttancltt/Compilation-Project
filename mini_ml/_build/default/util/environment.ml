type 'a t = (string, 'a ref) Hashtbl.t (*Bảng băm chứa các biến và giá trị của chúng, ví dụ : (x, ref 5) 
ref có nghĩa là một tham chiếu đến một giá trị cho phép thay đổi giá trị của biến string  *)

let new_environment : unit -> 'a t = fun () -> Hashtbl.create 10 (*Hàm tạo môi trường mới trả về một một hàm băm mới rỗng kích thước 10 *)

let copy (env : 'a t) : 'a t = (*Hàm này cho phép sao chép một môi trường *)
  let copy = Hashtbl.copy env in
  Hashtbl.iter (fun name value -> Hashtbl.replace copy name (ref !value)) env;
  copy

let add (env : 'a t) var typ = Hashtbl.add env var (ref typ) (*Hàm này thêm một biến mới vào môi trường, với tên biến và kiểu của nó được truyền vào *)
let remove (env : 'a t) var = Hashtbl.remove env var (*Hàm này xóa một biến khỏi môi trường, với tên biến được truyền vào *)
let get_ref (env : 'a t) var = Hashtbl.find_opt env var (*Hàm này tìm kiếm một biến trong môi trường và trả về một tham chiếu đến giá trị của nó nếu tìm thấy, hoặc None nếu không tìm thấy *)
let get (env : 'a t) var = Option.map (fun a -> !a) (get_ref env var)

let pp_environment printer fmt (env : 'a t) =
  Format.fprintf fmt "< ";
  Hashtbl.iter
    (fun name value -> Format.fprintf fmt "%s : %a; @," name printer !value)
    env;
  Format.fprintf fmt ">"

let map env func = Hashtbl.iter (fun _ b -> b := func !b) env
