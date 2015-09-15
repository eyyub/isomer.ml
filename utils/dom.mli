type t = private Ojs.t

type canvas_element = private Ojs.t

val canvas_element_to_js : canvas_element -> Ojs.t

val canvas_element_of_js : Ojs.t -> canvas_element

val document : t
[@@js.global "window.document"]

val get_element_by_id : t -> string -> canvas_element
[@@js.call]

val set_timeout : (unit -> unit) -> float -> unit
[@@js.global "window.setTimeout"]
