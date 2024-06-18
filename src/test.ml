open Openai

let api_key = Sys.getenv "OPENAI_API_KEY"
let client = Client.create api_key

let llmquery (s:string) : string =
  Lwt_main.run (Chat_completion.(
  send
    client
    ~temperature:0.0
    ~model:"gpt-4o"
    ~messages:
      [ { role = `System; content = "You are an expert in logic, formal methods, constructive type theory, dependent type theory, Coq (Gallina, Ltac, Ltac2)" }
      ; { role = `User; content = s }
      ]
    ()))

let pureRun () =
  print_endline (llmquery "Write an Inductive type denoting the abstract syntax tree of C++ expressions")

(*  
let run () =
  let api_key = Sys.getenv "OPENAI_API_KEY" in
  let client = Client.create api_key in
  ignore
  @@ Lwt_main.run
  @@ Lwt.bind
       Chat_completion.(
         send
           client
           ~temperature:0.0
           ~model:"gpt-4o"
           ~messages:
             [ { role = `System; content = "You are an expert in logic, formal methods, constructive type theory, dependent type theory, Coq (Gallina, Ltac, Ltac2)" }
             ; { role = `User; content = "Write an Inductive type denoting the abstract syntax tree of C++ statements" }
             ]
           ())
       (Lwt_io.printlf "res: %s")
;;
*)
let () = pureRun ()
