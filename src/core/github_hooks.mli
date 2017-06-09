module Repo : sig
  type t = string * string

  module Set : Set.S with type elt = t
end

module type CONFIGURATION = sig
  module Log : Logs.LOG
  val secret_prefix : string
  val tls_config : (int -> Conduit_lwt_unix.server_tls_config) option
end

module type TIME = sig
  type t
  val min : t
  val now : unit -> t
end

module type HOOKS = sig
  type t

  val create : Github.Token.t -> Uri.t -> t

  val run : t -> unit Lwt.t

  val repos : t -> Repo.Set.t

  val watch : t -> ?events:Github_t.event_type list -> Repo.t -> unit Lwt.t

  val events : t -> (Repo.t * Github_t.event_hook_constr) list

  val clear : t -> unit

  val wait : t -> unit Lwt.t
end

module Make : functor (Time : TIME) (Conf : CONFIGURATION) -> HOOKS
