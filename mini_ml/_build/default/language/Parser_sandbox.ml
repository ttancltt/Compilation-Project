
(* This generated code requires the following version of MenhirLib: *)

let () =
  MenhirLib.StaticVersion.require_20260209

module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = Tokens.token
  
end

include MenhirBasics

# 1 "language/Parser_sandbox.mly"
  
    open Ast

# 26 "language/Parser_sandbox.ml"

module Tables = struct
  
  include MenhirBasics
  
  let semantic_action =
    [|
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = f;
          MenhirLib.EngineTypes.startp = _startpos_f_;
          MenhirLib.EngineTypes.endp = _endpos_f_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let f : (Ast.expr) = Obj.magic f in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_f_ in
        let _endpos = _endpos_f_ in
        let _v : (Ast.expr) = 
# 46 "language/Parser_sandbox.mly"
                  ( f )
# 50 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = f;
            MenhirLib.EngineTypes.startp = _startpos_f_;
            MenhirLib.EngineTypes.endp = _endpos_f_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let e : (Ast.expr) = Obj.magic e in
        let f : (Ast.expr) = Obj.magic f in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_f_ in
        let _endpos = _endpos_e_ in
        let _v =
          let _endpos = _endpos_e_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 47 "language/Parser_sandbox.mly"
                               ( App(f,e,Annotation.create _loc))
# 86 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let e : (Ast.expr) = Obj.magic e in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e_ in
        let _endpos = _endpos_e_ in
        let _v : (Ast.expr) = 
# 28 "language/Parser_sandbox.mly"
                  ( e )
# 112 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _;
              MenhirLib.EngineTypes.semv = x;
              MenhirLib.EngineTypes.startp = _startpos_x_;
              MenhirLib.EngineTypes.endp = _endpos_x_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let e : (Ast.expr) = Obj.magic e in
        let _3 : unit = Obj.magic _3 in
        let x : 
# 22 "language/Tokens.mly"
       (string)
# 153 "language/Parser_sandbox.ml"
         = Obj.magic x in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e_ in
        let _v =
          let _endpos = _endpos_e_ in
          let _startpos = _startpos__1_ in
          let _loc = (_startpos, _endpos) in
          (
# 29 "language/Parser_sandbox.mly"
                            ( Fun(x,e,Annotation.create _loc) )
# 166 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = e2;
          MenhirLib.EngineTypes.startp = _startpos_e2_;
          MenhirLib.EngineTypes.endp = _endpos_e2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = e1;
            MenhirLib.EngineTypes.startp = _startpos_e1_;
            MenhirLib.EngineTypes.endp = _endpos_e1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let e2 : (Ast.expr) = Obj.magic e2 in
        let e1 : (Ast.expr) = Obj.magic e1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e1_ in
        let _endpos = _endpos_e2_ in
        let _v =
          let _endpos = _endpos_e2_ in
          let _startpos = _startpos_e1_ in
          let _loc = (_startpos, _endpos) in
          (
# 30 "language/Parser_sandbox.mly"
                                 ( App(e1,e2,Annotation.create _loc) )
# 203 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let e : (Ast.expr) = Obj.magic e in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_e_ in
        let _endpos = _endpos__2_ in
        let _v : (Ast.t) = 
# 10 "language/Parser_sandbox.mly"
             ( [(false,"result",e)] )
# 236 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = i;
          MenhirLib.EngineTypes.startp = _startpos_i_;
          MenhirLib.EngineTypes.endp = _endpos_i_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let i : 
# 24 "language/Tokens.mly"
       (int)
# 257 "language/Parser_sandbox.ml"
         = Obj.magic i in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_i_ in
        let _endpos = _endpos_i_ in
        let _v =
          let _endpos = _endpos_i_ in
          let _startpos = _startpos_i_ in
          let _loc = (_startpos, _endpos) in
          (
# 40 "language/Parser_sandbox.mly"
          ( Cst_i(i,Annotation.create _loc) )
# 269 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _1_inlined1;
            MenhirLib.EngineTypes.startp = _startpos__1_inlined1_;
            MenhirLib.EngineTypes.endp = _endpos__1_inlined1_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let _1_inlined1 : unit = Obj.magic _1_inlined1 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v =
          let f =
            let b = 
# 50 "language/Parser_sandbox.mly"
        ( Add )
# 311 "language/Parser_sandbox.ml"
             in
            
# 54 "language/Parser_sandbox.mly"
                        ( b )
# 316 "language/Parser_sandbox.ml"
            
          in
          let (_endpos_f_, _startpos_f_) = (_endpos__3_, _startpos__1_) in
          let _endpos = _endpos_f_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 41 "language/Parser_sandbox.mly"
               ( Cst_func(f,Annotation.create _loc) )
# 326 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = _1_inlined1;
            MenhirLib.EngineTypes.startp = _startpos__1_inlined1_;
            MenhirLib.EngineTypes.endp = _endpos__1_inlined1_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let _1_inlined1 : unit = Obj.magic _1_inlined1 in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v =
          let f =
            let b = 
# 51 "language/Parser_sandbox.mly"
        ( Pow )
# 368 "language/Parser_sandbox.ml"
             in
            
# 54 "language/Parser_sandbox.mly"
                        ( b )
# 373 "language/Parser_sandbox.ml"
            
          in
          let (_endpos_f_, _startpos_f_) = (_endpos__3_, _startpos__1_) in
          let _endpos = _endpos_f_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 41 "language/Parser_sandbox.mly"
               ( Cst_func(f,Annotation.create _loc) )
# 383 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v =
          let f = 
# 55 "language/Parser_sandbox.mly"
        ( UMin )
# 410 "language/Parser_sandbox.ml"
           in
          let (_endpos_f_, _startpos_f_) = (_endpos__1_, _startpos__1_) in
          let _endpos = _endpos_f_ in
          let _startpos = _startpos_f_ in
          let _loc = (_startpos, _endpos) in
          (
# 41 "language/Parser_sandbox.mly"
               ( Cst_func(f,Annotation.create _loc) )
# 419 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 
# 22 "language/Tokens.mly"
       (string)
# 441 "language/Parser_sandbox.ml"
         = Obj.magic x in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v =
          let _endpos = _endpos_x_ in
          let _startpos = _startpos_x_ in
          let _loc = (_startpos, _endpos) in
          (
# 42 "language/Parser_sandbox.mly"
         ( Var(x,Annotation.create _loc) )
# 453 "language/Parser_sandbox.ml"
           : (Ast.expr))
        in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _;
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _;
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let e : (Ast.expr) = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _endpos__0_ = _menhir_stack.MenhirLib.EngineTypes.endp in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : (Ast.expr) = 
# 43 "language/Parser_sandbox.mly"
                       ( e )
# 493 "language/Parser_sandbox.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
    |]
  
  let terminal_count =
    41
  
  let token2terminal : token -> int =
    fun _tok ->
      match _tok with
      | Tokens.THEN ->
          1
      | Tokens.TAIL ->
          2
      | Tokens.SUB ->
          3
      | Tokens.STRING _ ->
          4
      | Tokens.SEMICOLON ->
          5
      | Tokens.R_SQ ->
          6
      | Tokens.R_PAR ->
          7
      | Tokens.REC ->
          8
      | Tokens.PRINT ->
          9
      | Tokens.POW ->
          10
      | Tokens.OR ->
          11
      | Tokens.NOT ->
          12
      | Tokens.NEQ ->
          13
      | Tokens.NEG ->
          14
      | Tokens.MUL ->
          15
      | Tokens.MOD ->
          16
      | Tokens.L_SQ ->
          17
      | Tokens.L_PAR ->
          18
      | Tokens.LT ->
          19
      | Tokens.LET ->
          20
      | Tokens.LEQ ->
          21
      | Tokens.INT _ ->
          22
      | Tokens.IN ->
          23
      | Tokens.IF ->
          24
      | Tokens.ID _ ->
          25
      | Tokens.HEAD ->
          26
      | Tokens.GT ->
          27
      | Tokens.GEQ ->
          28
      | Tokens.FUN ->
          29
      | Tokens.EQ ->
          30
      | Tokens.EOF ->
          31
      | Tokens.ELSE ->
          32
      | Tokens.DIV ->
          33
      | Tokens.CONCAT ->
          34
      | Tokens.CAT ->
          35
      | Tokens.BOOL _ ->
          36
      | Tokens.ARROW ->
          37
      | Tokens.APPEND ->
          38
      | Tokens.AND ->
          39
      | Tokens.ADD ->
          40
  
  let error_terminal =
    0
  
  let token2value : token -> Obj.t =
    fun _tok ->
      match _tok with
      | Tokens.THEN ->
          Obj.repr ()
      | Tokens.TAIL ->
          Obj.repr ()
      | Tokens.SUB ->
          Obj.repr ()
      | Tokens.STRING _v ->
          Obj.repr (_v : 
# 23 "language/Tokens.mly"
       (string)
# 607 "language/Parser_sandbox.ml"
          )
      | Tokens.SEMICOLON ->
          Obj.repr ()
      | Tokens.R_SQ ->
          Obj.repr ()
      | Tokens.R_PAR ->
          Obj.repr ()
      | Tokens.REC ->
          Obj.repr ()
      | Tokens.PRINT ->
          Obj.repr ()
      | Tokens.POW ->
          Obj.repr ()
      | Tokens.OR ->
          Obj.repr ()
      | Tokens.NOT ->
          Obj.repr ()
      | Tokens.NEQ ->
          Obj.repr ()
      | Tokens.NEG ->
          Obj.repr ()
      | Tokens.MUL ->
          Obj.repr ()
      | Tokens.MOD ->
          Obj.repr ()
      | Tokens.L_SQ ->
          Obj.repr ()
      | Tokens.L_PAR ->
          Obj.repr ()
      | Tokens.LT ->
          Obj.repr ()
      | Tokens.LET ->
          Obj.repr ()
      | Tokens.LEQ ->
          Obj.repr ()
      | Tokens.INT _v ->
          Obj.repr (_v : 
# 24 "language/Tokens.mly"
       (int)
# 647 "language/Parser_sandbox.ml"
          )
      | Tokens.IN ->
          Obj.repr ()
      | Tokens.IF ->
          Obj.repr ()
      | Tokens.ID _v ->
          Obj.repr (_v : 
# 22 "language/Tokens.mly"
       (string)
# 657 "language/Parser_sandbox.ml"
          )
      | Tokens.HEAD ->
          Obj.repr ()
      | Tokens.GT ->
          Obj.repr ()
      | Tokens.GEQ ->
          Obj.repr ()
      | Tokens.FUN ->
          Obj.repr ()
      | Tokens.EQ ->
          Obj.repr ()
      | Tokens.EOF ->
          Obj.repr ()
      | Tokens.ELSE ->
          Obj.repr ()
      | Tokens.DIV ->
          Obj.repr ()
      | Tokens.CONCAT ->
          Obj.repr ()
      | Tokens.CAT ->
          Obj.repr ()
      | Tokens.BOOL _v ->
          Obj.repr (_v : 
# 25 "language/Tokens.mly"
       (bool)
# 683 "language/Parser_sandbox.ml"
          )
      | Tokens.ARROW ->
          Obj.repr ()
      | Tokens.APPEND ->
          Obj.repr ()
      | Tokens.AND ->
          Obj.repr ()
      | Tokens.ADD ->
          Obj.repr ()
  
  let default_reduction =
    "\011\000\168\192\000\005\000\t\r\016p"
  
  let[@inline] default_reduction =
    fun i ->
      MenhirLib.PackedIntArray.get4 default_reduction i
  
  let error =
    "\000\002\"D\000\000\000\000\000\000\000\b\136\145\000  \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\004\000\001\017\"\000\000@\136\144@\000\000\000\000\000\000\000\"$\000\000\b\017\018\b\000\004\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\000\000\000"
  
  let[@inline] error =
    fun i ->
      MenhirLib.PackedIntArray.get1 error i
  
  let[@inline] error =
    fun i j ->
      error (41 * i + j)
  
  let start =
    1
  
  let action_displacement =
    "\021\000\021\018\000\000\000%5\021\011\000\021\t\r\000\003\000\0005\000"
  
  let[@inline] action_displacement =
    fun i ->
      MenhirLib.PackedIntArray.get8 action_displacement i
  
  let action_data =
    "\014>\r\021\006SF\"\n\005\t&\022\005\t\026\018\005\t\030\005\t\000\000\000\000\r\021\000\000:"
  
  let[@inline] action_data =
    fun i ->
      MenhirLib.PackedIntArray.get8 action_data i
  
  let[@inline] action =
    fun i j ->
      let k = MenhirLib.RowDisplacementDecode.decode (action_displacement i) in
      action_data (k + j)
  
  let lhs =
    "\004C3!\017\017\016"
  
  let[@inline] lhs =
    fun i ->
      MenhirLib.PackedIntArray.get4 lhs i
  
  let goto_displacement =
    "0\224\000\000\006\000\128\000\000\000\000"
  
  let[@inline] goto_displacement =
    fun i ->
      MenhirLib.PackedIntArray.get4 goto_displacement i
  
  let goto_data =
    "\011\019\020\r\011\014\012\r\011\000\017\r"
  
  let[@inline] goto_data =
    fun i ->
      MenhirLib.PackedIntArray.get8 goto_data i
  
  let[@inline] goto =
    fun i j ->
      let k = MenhirLib.RowDisplacementDecode.decode (goto_displacement i) in
      goto_data (k + j)
  
  let trace =
    None
  
end

module MenhirInterpreter = struct
  
  module ET = MenhirLib.TableInterpreter.MakeEngineTable (Tables)
  
  module TI = MenhirLib.Engine.Make (ET)
  
  include TI
  
  module Symbols = struct
    
    type 'a terminal = 'a Tokens.MenhirInterpreter.terminal
    
    type _ nonterminal = 
      | N_simple_expr : (Ast.expr) nonterminal
      | N_main : (Ast.t) nonterminal
      | N_expr : (Ast.expr) nonterminal
      | N_app_expr : (Ast.expr) nonterminal
    
  end
  
  include Symbols
  
  include MenhirLib.InspectionTableInterpreter.Make (Tables) (struct
    
    include TI
    
    include Symbols
    
    include MenhirLib.InspectionTableInterpreter.Symbols (Symbols)
    
    let terminal =
      fun t ->
        match t with
        | 0 ->
            X (T Tokens.MenhirInterpreter.T_error)
        | 1 ->
            X (T Tokens.MenhirInterpreter.T_THEN)
        | 2 ->
            X (T Tokens.MenhirInterpreter.T_TAIL)
        | 3 ->
            X (T Tokens.MenhirInterpreter.T_SUB)
        | 4 ->
            X (T Tokens.MenhirInterpreter.T_STRING)
        | 5 ->
            X (T Tokens.MenhirInterpreter.T_SEMICOLON)
        | 6 ->
            X (T Tokens.MenhirInterpreter.T_R_SQ)
        | 7 ->
            X (T Tokens.MenhirInterpreter.T_R_PAR)
        | 8 ->
            X (T Tokens.MenhirInterpreter.T_REC)
        | 9 ->
            X (T Tokens.MenhirInterpreter.T_PRINT)
        | 10 ->
            X (T Tokens.MenhirInterpreter.T_POW)
        | 11 ->
            X (T Tokens.MenhirInterpreter.T_OR)
        | 12 ->
            X (T Tokens.MenhirInterpreter.T_NOT)
        | 13 ->
            X (T Tokens.MenhirInterpreter.T_NEQ)
        | 14 ->
            X (T Tokens.MenhirInterpreter.T_NEG)
        | 15 ->
            X (T Tokens.MenhirInterpreter.T_MUL)
        | 16 ->
            X (T Tokens.MenhirInterpreter.T_MOD)
        | 17 ->
            X (T Tokens.MenhirInterpreter.T_L_SQ)
        | 18 ->
            X (T Tokens.MenhirInterpreter.T_L_PAR)
        | 19 ->
            X (T Tokens.MenhirInterpreter.T_LT)
        | 20 ->
            X (T Tokens.MenhirInterpreter.T_LET)
        | 21 ->
            X (T Tokens.MenhirInterpreter.T_LEQ)
        | 22 ->
            X (T Tokens.MenhirInterpreter.T_INT)
        | 23 ->
            X (T Tokens.MenhirInterpreter.T_IN)
        | 24 ->
            X (T Tokens.MenhirInterpreter.T_IF)
        | 25 ->
            X (T Tokens.MenhirInterpreter.T_ID)
        | 26 ->
            X (T Tokens.MenhirInterpreter.T_HEAD)
        | 27 ->
            X (T Tokens.MenhirInterpreter.T_GT)
        | 28 ->
            X (T Tokens.MenhirInterpreter.T_GEQ)
        | 29 ->
            X (T Tokens.MenhirInterpreter.T_FUN)
        | 30 ->
            X (T Tokens.MenhirInterpreter.T_EQ)
        | 31 ->
            X (T Tokens.MenhirInterpreter.T_EOF)
        | 32 ->
            X (T Tokens.MenhirInterpreter.T_ELSE)
        | 33 ->
            X (T Tokens.MenhirInterpreter.T_DIV)
        | 34 ->
            X (T Tokens.MenhirInterpreter.T_CONCAT)
        | 35 ->
            X (T Tokens.MenhirInterpreter.T_CAT)
        | 36 ->
            X (T Tokens.MenhirInterpreter.T_BOOL)
        | 37 ->
            X (T Tokens.MenhirInterpreter.T_ARROW)
        | 38 ->
            X (T Tokens.MenhirInterpreter.T_APPEND)
        | 39 ->
            X (T Tokens.MenhirInterpreter.T_AND)
        | 40 ->
            X (T Tokens.MenhirInterpreter.T_ADD)
        | _ ->
            assert false
    
    let nonterminal =
      fun nt ->
        match nt with
        | 4 ->
            X (N N_app_expr)
        | 3 ->
            X (N N_expr)
        | 2 ->
            X (N N_main)
        | 1 ->
            X (N N_simple_expr)
        | _ ->
            assert false
    
    let lr0_incoming =
      "\000\030&\022\016.4<4L\003\007\t\003R\016\007\016\005\007@"
    
    let[@inline] lr0_incoming =
      fun i ->
        MenhirLib.PackedIntArray.get8 lr0_incoming i
    
    let rhs_data =
      "\005\003\t\003\003<4L\007\t\003\007@.&R\016&\022\016\0304&\007\016"
    
    let[@inline] rhs_data =
      fun i ->
        MenhirLib.PackedIntArray.get8 rhs_data i
    
    let rhs_entry =
      "\000\001\002\004\005\t\011\r\014\017\020\021\022\025"
    
    let[@inline] rhs_entry =
      fun i ->
        MenhirLib.PackedIntArray.get8 rhs_entry i
    
    let[@inline] rhs =
      fun i ->
        MenhirLib.LinearizedArray.read_row_via rhs_data rhs_entry i
    
    let lr0_core =
      "\000\001\002\003\004\005\006\007\b\t\n\011\012\r\014\015\016\017\018\019\020"
    
    let[@inline] lr0_core =
      fun i ->
        MenhirLib.PackedIntArray.get8 lr0_core i
    
    let lr0_items_data =
      "\000\000(\0010\001$\001 \001$\002$\003\028\001,\001\016\001\016\002\016\003\012\001\004\001\016\004\020\001\b\001\020\002\b\002 \002 \0030\0020\003\000\001\024\001\024\002"
    
    let[@inline] lr0_items_data =
      fun i ->
        MenhirLib.PackedIntArray.get16 lr0_items_data i
    
    let lr0_items_entry =
      "\000\001\002\005\006\007\b\t\n\011\012\014\015\017\019\020\021\022\023\024\025\026"
    
    let[@inline] lr0_items_entry =
      fun i ->
        MenhirLib.PackedIntArray.get8 lr0_items_entry i
    
    let[@inline] lr0_items =
      fun i ->
        MenhirLib.LinearizedArray.read_row_via lr0_items_data lr0_items_entry i
    
    let nullable =
      "\000"
    
    let[@inline] nullable =
      fun i ->
        MenhirLib.PackedIntArray.get1 nullable i
    
    let first =
      "\000\002\"D\000\000\001\017 \000\000\000\136\145\000\000\000DH\128\000\000\"$\000\000"
    
    let[@inline] first =
      fun i ->
        MenhirLib.PackedIntArray.get1 first i
    
    let[@inline] first =
      fun i j ->
        first (41 * i + j)
    
  end) (ET) (TI)
  
end

let main =
  fun lexer lexbuf : ((Ast.t)) ->
    Obj.magic (MenhirInterpreter.entry `Legacy 0 lexer lexbuf)

module Incremental = struct
  
  let main =
    fun initial_position : ((Ast.t) MenhirInterpreter.checkpoint) ->
      Obj.magic (MenhirInterpreter.start 0 initial_position)
  
end
