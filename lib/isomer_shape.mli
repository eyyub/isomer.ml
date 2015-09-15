type t = private Ojs.t

val t_to_js : t -> Ojs.t
val t_of_js : Ojs.t -> t

val make : Isomer_path.t list -> t
[@@js.new "Isomer.Shape"]

val push : t -> Isomer_path.t -> unit
[@@js.call]

val translate : t -> float -> float -> float -> t
[@@js.call]

val rotate_x : t -> ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) -> float -> t
[@@js.call]

val rotate_y : t -> ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) -> float -> t
[@@js.call]

val rotate_z : t -> ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) -> float -> t
[@@js.call]

val scale : t -> ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
            float -> float -> float -> t
[@@js.call]

val ordered_paths : t -> Isomer_path.t list
[@@js.call]

val extrude : Isomer_path.t -> int -> t
[@@js.global "Isomer.Shape.extrude"]

module Prism : sig
  val make : ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
             float -> float -> float -> t
  [@@js.global "Isomer.Shape.Prism"]
end

module Pyramid : sig
  val make : ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
             float -> float -> float -> t
  [@@js.global "Isomer.Shape.Pyramid"]
end

module Cylinder : sig
  val make : ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
             ?vertices:int -> float -> int -> t
  [@@js.global "Isomer.Shape.Cylinder"]
end
