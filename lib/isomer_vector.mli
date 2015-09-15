type t = private Ojs.t

val t_to_js : t -> Ojs.t

val t_of_js : Ojs.t -> t

val make : float -> float -> float -> t
[@@js.new "Isomer.Vector"]

val magnitude : t -> float
[@@js.call]

val normalize : t -> t
[@@js.call]

val from_two_points : Isomer_point.t -> Isomer_point.t -> t
[@@js.global "Isomer.Vector.fromTwoPoints"]

val cross_product : t -> t -> t
[@@js.global "Isomer.Vector.crossProduct"]

val dot_product : t -> t -> t
[@@js.global "Isomer.Vector.dotProduct"]
