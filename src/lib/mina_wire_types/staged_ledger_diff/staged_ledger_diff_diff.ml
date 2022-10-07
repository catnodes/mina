open Utils

module Types = struct
  module type S = sig
    module At_most_two : sig
      module V1 : sig
        type 'a t = Zero | One of 'a option | Two of ('a * 'a option) option
      end
    end

    module Pre_diff_two : sig
      module V2 : sig
        type ('a, 'b) t =
          { completed_works : 'a list
          ; commands : 'b list
          ; coinbase : Mina_base_coinbase_fee_transfer.V1.t At_most_two.V1.t
          ; internal_command_statuses : Mina_base_transaction_status.V2.t list
          }
      end
    end
  end
end

module type Concrete = sig
  module Ft : sig
    module Stable : sig
      module V1 : sig
        type t = Mina_base_coinbase_fee_transfer.V1.t
      end
    end
  end

  module At_most_two : sig
    module V1 : sig
      type 'a t = Zero | One of 'a option | Two of ('a * 'a option) option
    end
  end

  module Pre_diff_two : sig
    module V2 : sig
      type ('a, 'b) t =
        { completed_works : 'a list
        ; commands : 'b list
        ; coinbase : Mina_base_coinbase_fee_transfer.V1.t At_most_two.V1.t
        ; internal_command_statuses : Mina_base_transaction_status.V2.t list
        }
    end
  end
end

module M = struct
  module Ft = struct
    module Stable = struct
      module V1 = struct
        type t = Mina_base_coinbase_fee_transfer.V1.t
      end
    end
  end

  module At_most_two = struct
    module V1 = struct
      type 'a t = Zero | One of 'a option | Two of ('a * 'a option) option
    end
  end

  module Pre_diff_two = struct
    module V2 = struct
      type ('a, 'b) t =
        { completed_works : 'a list
        ; commands : 'b list
        ; coinbase : Mina_base_coinbase_fee_transfer.V1.t At_most_two.V1.t
        ; internal_command_statuses : Mina_base_transaction_status.V2.t list
        }
    end
  end
end

module type Local_sig = Signature(Types).S

module Make
    (Signature : Local_sig) (F : functor (A : Concrete) -> Signature(A).S) =
  F (M)
include M
