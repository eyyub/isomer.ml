type t = private Ojs.t

val t_to_js : t -> Ojs.t
val t_of_js : Ojs.t -> t

val make : Isomer_point.t list -> t
[@@js.new "Isomer.Path"]

val push : t -> Isomer_point.t -> unit
[@@js.call]

val reverse : t -> t
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

val depth : t -> float
[@@js.call]

module Rectangle : sig
  val make : ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
             int -> int -> t
  [@@js.global "Isomer.Path.Rectangle"]
end

module Circle : sig
  val make : ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
             ?vertices:int -> float -> t
  [@@js.global "Isomer.Path.Circle"]
end

module Star : sig
  val make : ?origin:(Isomer_point.t [@js.default Isomer_point.default_origin]) ->
             float -> float -> int -> t
  [@@js.global "Isomer.Path.Star"]
end
