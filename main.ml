(*
* @Author: adebray
* @Date:   2015-11-13 22:36:55
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-15 21:39:05
*)

type mods = {
	health : Meter.health ;
	energy : Meter.energy ;
	hygiene : Meter.hygiene ;
	happyness : Meter.happyness
	}

let init () =
	(* Sdlwm.grab_input true ; *)
	let screen = Sdlvideo.set_video_mode 530 400 [] in
	let font = Sdlttf.open_font "fonts/courier.ttf" 16 in

	let clearScreen () = Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen (214, 255, 203)) in
	let hamtaro = new Tamagotchi.hamtaro "assets/mytamabig.png" screen in
	let modList = {
		health = new Meter.health screen font ;
		energy = new Meter.energy screen font ;
		hygiene = new Meter.hygiene screen font ;
		happyness = new Meter.happyness screen font
	} in

(* 	let rec matchEvent time = function
	| Sdlevent.MOUSEBUTTONDOWN { Sdlevent.mbe_x = x_mouse ; Sdlevent.mbe_y = y_mouse } ->
		print_endline (string_of_int x_mouse)
	| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> print_endline "keydown"
	| Sdlevent.QUIT -> print_endline "bye" ; raise Exit
	| event -> print_endline (Sdlevent.string_of_event event)
 *)	let rec run time hamtaro modList =
		Sdlevent.pump () ;

		let matchEvent time = function
		| Sdlevent.MOUSEBUTTONDOWN { Sdlevent.mbe_x = x_mouse ; Sdlevent.mbe_y = y_mouse } ->
			print_endline (string_of_int x_mouse)
		| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } ->
			print_endline "bye" ; raise Exit
		| Sdlevent.QUIT ->
			print_endline "bye" ; raise Exit
		| event ->
			print_endline (Sdlevent.string_of_event event) in
		clearScreen () ;
		hamtaro#draw ;
		modList.health#draw ;
		modList.energy#draw ;
		modList.hygiene#draw ;
		modList.happyness#draw ;
		Sdlvideo.flip screen ;

		let bundle = {
			health = (modList.health#update (int_of_float (cos ((float_of_int time) /. 21.) *. 2.))) ;
			energy = modList.energy ;
			hygiene = modList.hygiene ;
			happyness = modList.happyness
		} in
		let rec loop () =
		match Sdlevent.poll () with
		| Some event -> matchEvent time event ; loop ()
		| None -> ()
		in loop () ; run (time + 1) hamtaro#update bundle
	in try run 0 hamtaro modList with
	| Exit -> ()
	| Meter.Lost -> print_endline "You lost"

let main () =
	Sdl.init [`VIDEO ] ;
	at_exit Sdl.quit ;
	Sdlttf.init ();
	at_exit Sdlttf.quit;

	Sdlevent.Old.set_keyboard_event_func (fun a b c d -> print_endline (string_of_int c));
	init ()

let () = main ()
