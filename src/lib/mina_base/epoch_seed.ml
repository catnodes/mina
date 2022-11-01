open Core_kernel

include Data_hash.Make_full_size (struct
  let version_byte = Base58_check.Version_bytes.epoch_seed

  let description = "Epoch Seed"
end)

[%%versioned
module Stable = struct
  [@@@no_toplevel_latest_type]

  module V1 = struct
    module T = struct
      type t = (Snark_params.Tick.Field.t[@version_asserted])
      [@@deriving sexp, compare, hash]
    end

    include T

    let to_latest = Fn.id

    [%%define_from_scope to_yojson, of_yojson]

    include Comparable.Make (T)
    include Hashable.Make_binable (T)
  end
end]

let _f : unit -> (Stable.Latest.t, t) Type_equal.t = fun () -> Type_equal.T
