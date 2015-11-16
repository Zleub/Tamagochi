(*
* @Author: adebray
* @Date:   2015-11-13 22:36:55
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-16 20:06:09
*)

type mods = {
	health : Meter.health ;
	energy : Meter.energy ;
	hygiene : Meter.hygiene ;
	happyness : Meter.happyness
	}

let game () =
	(* Sdlwm.grab_input true ; *)
	let screen = Sdlvideo.set_video_mode 530 400 [] in
	let font = Sdlttf.open_font "fonts/courier.ttf" 16 in

	let clearScreen () = Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen (214, 255, 203)) in
	let hamtaro = new Tamagotchi.hamtaro "assets/mytamabig.png" screen in

	let saveFile = open_in "save.file" in
		try read_line  with
		| Sys_error x -> print_endline x


	let modList = {
		health = new Meter.health 100 screen font ;
		energy = new Meter.energy 100 screen font ;
		hygiene = new Meter.hygiene 12 screen font ;
		happyness = new Meter.happyness 21 screen font
	} in

	let rec matchEvent time = function
		| Sdlevent.MOUSEBUTTONDOWN { Sdlevent.mbe_x = x_mouse ; Sdlevent.mbe_y = y_mouse } ->
			print_endline (string_of_int x_mouse)
		| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> raise Exit
		| Sdlevent.QUIT -> print_endline "bye" ; raise Exit
		| event -> ()
	and run time hamtaro modList =
		Sdlevent.pump () ;

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
	game ()

let () = main ()
