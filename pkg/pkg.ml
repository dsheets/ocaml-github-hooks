#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let opams = [Pkg.opam_file ~lint_deps_excluding:None "opam"]

let () =
  Pkg.describe ~opams "github-hooks" @@ fun c ->
  Ok [
    Pkg.mllib "lib/github-hooks.mllib";
    Pkg.mllib "unix/github-hooks-unix.mllib";
    Pkg.test ~run:false "test/test_hook_server"
  ]
