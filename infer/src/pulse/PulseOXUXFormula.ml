open! IStd
module F = Format
module AbstractValue = PulseAbstractValue

type oxux_elem =
  | OXVar of AbstractValue.t
  | UXCond of Exp.t
[@@deriving compare, equal, yojson_of]

type t =
  | OXUXFormula of oxux_elem list
  | OXUXUnsupported of string
[@@deriving compare, equal, yojson_of]

let fmap f = function
  | OXUXFormula elems ->
      OXUXFormula (f elems)
  | OXUXUnsupported reason ->
      OXUXUnsupported reason

let empty = OXUXFormula []

let unsupported reason = OXUXUnsupported reason

let add_ox_var var = 
  fmap (fun elems -> OXVar var :: elems)

let add_ux_condition condition = 
  fmap (fun elems -> UXCond condition :: elems)

let pp f = function 
  | OXUXFormula elems ->
      let pp_item f = function
        | OXVar v ->
            F.fprintf f "OXV(%a)" AbstractValue.pp v
        | UXCond c ->
            F.fprintf f "UXC(%a)" Exp.pp c
      in
      F.fprintf f "OXUXFormula" ;
      PrettyPrintable.pp_collection ~pp_item f elems
  | OXUXUnsupported reason -> 
      F.fprintf f "unsupportedOXUX(%s)" reason