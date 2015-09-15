type t = private Ojs.t

val t_to_js : t -> Ojs.t
val t_of_js : Ojs.t -> t

val make : Dom.canvas_element -> t
[@@js.new "Isomer.Canvas"]

val clear : t -> unit
[@@js.call]

val path : t -> Isomer_point.t list -> Isomer_color.t -> unit
[@@js.call]
