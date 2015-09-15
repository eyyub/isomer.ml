[@@@js.stop]
module Canvas = Isomer_canvas
module Color = Isomer_color
module Path = Isomer_path
module Point = Isomer_point
module Shape = Isomer_shape
module Vector = Isomer_vector
[@@@js.start]

type t = private Ojs.t

val t_to_js : t -> Ojs.t

type options =
  {
    scale : float option;
    origin_x : float option [@js "originX"];
    origin_y : float option [@js "originY"];
    light_position : Isomer_vector.t option [@js "lightPosition"];
    light_color : Isomer_color.t option [@js "lightColor"];
  }

val make_options :
  ?scale:float ->
  ?origin_x:float ->
  ?origin_y:float ->
  ?light_position:Isomer_vector.t ->
  ?light_color:Isomer_color.t -> unit -> options
[@@js.custom
  let make_options ?scale ?origin_x ?origin_y ?light_position ?light_color () =
    {scale; origin_x; origin_y; light_position; light_color}
]

val make : ?options:options -> Dom.canvas_element -> t
[@@js.custom
  val make_internal : Dom.canvas_element -> ?options:options -> unit -> t
  [@@js.new "Isomer"]

  let make ?options canvas = make_internal canvas ?options ()
]

val set_light_position : t -> float -> float -> float -> unit
[@@js.call]

val add_path : t -> Isomer_path.t -> Isomer_color.t -> unit
[@@js.call "add"]

val add_shape : t -> Isomer_shape.t -> Isomer_color.t -> unit
[@@js.call "add"]

val add : t -> [< `Path of Isomer_path.t | `Shape of Isomer_shape.t] list ->
          Isomer_color.t -> unit
[@@js.custom
  let add o l c =
    List.iter (function 
               | `Path p -> add_path o p c
               | `Shape s -> add_shape o s c) l
]

[@@@js.implem
  module Canvas = Isomer_canvas
  module Color = Isomer_color
  module Path = Isomer_path
  module Point = Isomer_point
  module Shape = Isomer_shape
  module Vector = Isomer_vector
]
