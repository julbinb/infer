open! IStd
module F = Format
module AbstractValue = PulseAbstractValue

(** A precise path condition that accounts for over-approximate (unknown) variables *)
type t [@@deriving compare, equal, yojson_of]

val empty : t

val unsupported : string -> t

val add_ox_var : AbstractValue.t -> t -> t

val add_ux_condition : Exp.t -> t -> t

val pp : F.formatter -> t -> unit
