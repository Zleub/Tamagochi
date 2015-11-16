(*
* @Author: adebray
* @Date:   2015-11-13 22:36:55
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-16 23:00:43
*)

let init () =
	let screen = Sdlvideo.set_video_mode 530 400 [] in
	let font = Sdlttf.open_font "fonts/courier.ttf" 16 in

	let clearScreen () = Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen (214, 255, 203)) in
	let hamtaro = new Tamagotchi.hamtaro "assets/mytamabig.png" screen in

	let modList = Gameplay.init screen font in

	let rec run time hamtaro modList =

		let matchEvent = function
		| Sdlevent.MOUSEBUTTONDOWN { Sdlevent.mbe_x = x_mouse ; Sdlevent.mbe_y = y_mouse } ->
			run (time + 1) hamtaro#update (Gameplay.matchAction (x_mouse, y_mouse) modList)
		| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> raise Exit
		| Sdlevent.QUIT -> raise Exit
		| _ -> () in

		clearScreen () ;
		hamtaro#draw ;
		Gameplay.draw modList ;
		Sdlvideo.flip screen ;

		Sdlevent.pump () ;
		let rec loop () = match Sdlevent.poll () with
			| Some event -> matchEvent event ; loop ()
			| None -> ()
		in loop () ;

		if (time + 1) mod 60 = 0 then
			run (time + 1) hamtaro#update modList (* (Gameplay.update time modList) *)
		else
			run (time + 1) hamtaro#update modList
	in try run 0 hamtaro modList with
	| Exit -> ()
	| Meter.Lost -> print_endline "You lost"

let main () =
	Random.self_init () ;
	Sdl.init [`VIDEO ] ;
	at_exit Sdl.quit ;
	Sdlttf.init ();
	at_exit Sdlttf.quit;

	Sdlevent.Old.set_keyboard_event_func (fun a b c d -> print_endline (string_of_int c));
	init ()

let () = main ()
