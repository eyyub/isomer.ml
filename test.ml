module Point = Isomer.Point
module Path = Isomer.Path
module Shape = Isomer.Shape
module Color = Isomer.Color

let pi = 4. *. atan 1.
let canvas = Dom.(get_element_by_id document "canvas")
let iso = Isomer.make canvas ~options:(Isomer.make_options
                                         ~origin_x:470.
                                         ~origin_y:950. ())

let make_stairs origin =
  let zigzag = Path.make [origin] in
  let stairs = Shape.make [] in
  let rec make_steps n steps =
    if n >= 10 then steps
    else (
       let step_corner =
         Point.translate origin 0.
                         (float_of_int n /. 10.)
                         (float_of_int (succ n) /. 10.)
       in
       let steps =
          Path.make Point.[
            step_corner;
            translate step_corner 1. 0. 0.;
            translate step_corner 1. 0.1 0.;
            translate step_corner 0. 0.1 0.
          ] ::
          Path.make Point.[
            step_corner;
            translate step_corner 0. 0. (-0.1);
            translate step_corner 1. 0. (-0.1);
            translate step_corner 1. 0. 0.
          ] :: steps
       in
       Path.push zigzag step_corner;
       Path.push zigzag (Point.translate step_corner 0. 0.1 0.);
       make_steps (succ n) steps
    )
  in
  let steps = make_steps 0 [] |> List.rev in
  Path.push zigzag (Point.translate origin 0. 1. 0.);
  List.iter (Shape.push stairs) steps;
  Shape.push stairs zigzag;
  Shape.push stairs (Path.translate (Path.reverse zigzag) 1. 0. 0.);
  stairs

let make_octahedron origin =
  let center = Point.translate origin 0.5 0.5 0.5 in
  let upper_triangle = Path.make Point.[
   translate origin 0. 0. 0.5;
   translate origin 0.5 0.5 1.;
   translate origin 0. 1. 0.5;
  ] in
  let lower_triangle = Path.make Point.[
    translate origin 0. 0. 0.5;
    translate origin 0. 1. 0.5;
    translate origin 0.5 0.5 0.;
  ] in
  let rec make_faces n faces =
    if n >= 4 then faces
    else (
      let faces =
         Path.rotate_z upper_triangle
            ~origin:center (float_of_int n *. pi /. 2.)
         :: Path.rotate_z lower_triangle
              ~origin:center (float_of_int n *. pi /. 2.)
         :: faces
      in
      make_faces (succ n) faces
    )
  in
  let faces = make_faces 0 [] in
  Shape.scale (Shape.make faces) ~origin:center (sqrt 2. /. 2.) (sqrt 2. /. 2.) 1.

let rec make_brand angle () = Isomer.(
  let module P = Point in
  let module S = Shape in
  let module SP = S.Pyramid in
  add iso Shape.Prism.[
    `Shape (make ~origin:(P.make 1. (-1.) 0.) 4. 5. 2.);
    `Shape (make ~origin:(P.make 0. 0. 0.) 1. 4. 1.);
    `Shape (make ~origin:(P.make (-1.) 1. 0.) 1. 3. 1.);

    `Shape (make_stairs (P.make (-1.) 0. 0.));
    `Shape (let s = make_stairs (P.make 0. 3. 1.) in
            Shape.rotate_z s ~origin:(P.make 0.5 3.5 1.) (-.pi /. 2.));

    `Shape (make ~origin:(P.make 3. 0. 2.) 2. 4. 1.);
    `Shape (make ~origin:(P.make 2. 1. 2.) 1. 3. 1.);

    `Shape (let s = make_stairs (P.make 2. 0. 2.) in
            Shape.rotate_z s ~origin:(P.make 2.5 0.5 0.) (-.pi /. 2.));

  ] (Color.make 100 100 100);

  let p = SP.make ~origin:(P.make 2. 3. 3.) 1. 1. 1. in
  add_shape iso (S.scale p ~origin:(P.make 2. 4. 3.) 0.5 0.5 0.5)
                (Color.make 180 180 0);

  let p = SP.make ~origin:(P.make 4. 3. 3.) 1. 1. 1. in
  add_shape iso (S.scale p ~origin:(P.make 5. 4. 3.) 0.5 0.5 0.5)
                (Color.make 180 0 180);

  let p = SP.make ~origin:(P.make 4. 1. 3.) 1. 1. 1. in
  add_shape iso (S.scale p ~origin:(P.make 5. 1. 3.) 0.5 0.5 0.5)
                (Color.make 0 180 180);

  let p = SP.make ~origin:(P.make 2. 1. 3.) 1. 1. 1. in
  add_shape iso (S.scale p ~origin:(P.make 2. 1. 3.) 0.5 0.5 0.5)
                (Color.make 40 180 40);

  add_shape iso (SP.make ~origin:(P.make 3. 2. 3.) 1. 1. 0.2)
                (Color.make 50 50 50);

  let s = make_octahedron (P.make 3. 2. 3.2) in
  add_shape iso (S.rotate_z s ~origin:(P.make 3.5 2.5 0.) angle)
                (Color.make 0 180 180);

  Dom.set_timeout (make_brand (angle +. pi /. 90.)) (1000. /. 60.)
)

let () = Dom.set_timeout (make_brand 0.) 0.
