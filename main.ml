(*
* @Author: adebray
* @Date:   2015-11-13 22:36:55
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-14 07:53:17
*)

let quadlist = [
	Sdlvideo.rect 0 0 30 30 ;
	Sdlvideo.rect 30 0 30 30 ;
	Sdlvideo.rect 0 30 30 30 ;
]

let init () =
	(* Sdlwm.grab_input true ; *)
	let screen = Sdlvideo.set_video_mode 400 400 [] in

	Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen (214, 255, 203)) ;

	let image = Sdlloader.load_image "assets/mytama.png" in
	let quad = List.nth quadlist 0 in
	let position_of_image = Sdlvideo.rect 0 0 42 42 in
	Sdlvideo.blit_surface ~src_rect:quad ~dst_rect:position_of_image ~src:image ~dst:screen ();

	let font = Sdlttf.open_font "fonts/courier.ttf" 16 in
	let text = Sdlttf.render_text_blended font "Enjoy!" ~fg:Sdlvideo.black in
	let position_of_text = Sdlvideo.rect 300 0 300 300 in
	Sdlvideo.blit_surface ~dst_rect:position_of_text ~src:text ~dst:screen ();

	let healthmod = new Meter.health screen font in
	healthmod#draw ;

	let matchEvent = function
	| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> print_endline "keydown"
	| Sdlevent.QUIT -> print_endline "bye" ; raise Exit
	| event -> print_endline (Sdlevent.string_of_event event) ;
	in
	let rec run time =

		if (time mod 60) = 59 then
			Sdlvideo.blit_surface ~src_rect:(List.nth quadlist 1) ~dst_rect:position_of_image ~src:image ~dst:screen ();
(* 		if (time mod 120) = 0 then
			Sdlvideo.blit_surface ~src_rect:(List.nth quadlist 1) ~dst_rect:position_of_image ~src:image ~dst:screen ();
 *)		Sdlvideo.flip screen;

		Sdlevent.pump () ;
		match Sdlevent.poll () with
		| Some event -> matchEvent event ; run (time + 1)
		| None -> run (time + 1)
	in try run 0 with
	| Exit -> ()

let main () =
	Sdl.init [`VIDEO ] ;
	at_exit Sdl.quit ;
	Sdlttf.init ();
	at_exit Sdlttf.quit;

	Sdlevent.Old.set_keyboard_event_func (fun a b c d -> print_endline (string_of_int c));
	init ()

let () = main ()
