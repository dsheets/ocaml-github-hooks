
module Time = struct
  type t = float

  let min = 0.
  let now = Unix.gettimeofday
end

module Make(Conf : Github_hooks.CONFIGURATION) = Github_hooks.Make(Time)(Conf)
