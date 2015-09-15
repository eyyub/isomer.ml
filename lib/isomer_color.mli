type t = private Ojs.t

val t_to_js : t -> Ojs.t
val t_of_js : Ojs.t -> t

val make : ?a:int -> int -> int -> int -> t
[@@js.custom
  val make_internal : int -> int -> int -> ?a:(int [@js.default 0]) -> unit -> t
  [@@js.new "Isomer.Color"]

  let make ?a r g b = make_internal r g b ?a ()
]

val to_hex : t -> string
[@@js.call]

val hexstring_of_t : t -> string
[@@js.call "toHex"]

val lighten : t -> ?light_color:t -> int -> t
[@@js.call]

val load_hsl : t -> unit
[@@js.call "loadHSL"]

val load_rgb : t -> unit
[@@js.call "loadRGB"]
