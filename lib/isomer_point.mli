type t = private Ojs.t

val t_to_js : t -> Ojs.t
val t_of_js : Ojs.t -> t

val make : float -> float -> float -> t
[@@js.new "Isomer.Point"]

val default_origin : t
[@@js.global "Isomer.Point.ORIGIN"]

val translate : t -> float -> float -> float -> t
[@@js.call]

val scale : t -> ?origin:(t [@js.default default_origin]) -> float -> float -> float -> t
[@@js.call]

val rotate_x : t -> ?origin:(t [@js.default default_origin]) -> float -> t
[@@js.call]

val rotate_y : t -> ?origin:(t [@js.default default_origin]) -> float -> t
[@@js.call]

val rotate_z : t -> ?origin:(t [@js.default default_origin]) -> float -> t
[@@js.call]

val depth : t -> float
[@@js.call]

val distance : t -> t -> float
[@@js.global "Isomer.Point.distance"]
