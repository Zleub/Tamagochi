(*
* @Author: adebray
* @Date:   2015-11-13 22:36:55
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-14 03:19:22
*)

let init () =
	let screen = Sdlvideo.set_video_mode 400 400 [] in
	let image = Sdlloader.load_image "assets/img.png" in
	let position_of_image = Sdlvideo.rect 0 0 42 42 in
	Sdlvideo.blit_surface ~dst_rect:position_of_image ~src:image ~dst:screen ();


	let font = Sdlttf.open_font "fonts/courier.ttf" 24 in
	let text = Sdlttf.render_text_blended font "Enjoy!" ~fg:Sdlvideo.white in
	let position_of_text = Sdlvideo.rect 300 0 300 300 in
	Sdlvideo.blit_surface ~dst_rect:position_of_text ~src:text ~dst:screen ();


	let rec run () =
		match Sdlevent.wait_event () with
		| Sdlevent.KEYDOWN x -> print_endline (String.make 1 x.keycode)
		| Sdlevent.QUIT -> print_endline "bye"
		| event ->
			Sdlvideo.flip screen;
			print_endline (Sdlevent.string_of_event event) ;
			run ()
	in run ()

let main () =
	Sdl.init [`VIDEO] ;
	at_exit Sdl.quit ;
	Sdlttf.init ();
	at_exit Sdlttf.quit;
    let printEventKind = function
      | Sdlevent.ACTIVE_EVENT -> print_endline "ACTIVE_EVENT"
      | Sdlevent.KEYDOWN_EVENT -> print_endline "KEYDOWN_EVENT"
      | Sdlevent.KEYUP_EVENT -> print_endline "KEYUP_EVENT"
      | Sdlevent.MOUSEMOTION_EVENT -> print_endline "MOUSEMOTION_EVENT"
      | Sdlevent.MOUSEBUTTONDOWN_EVENT -> print_endline "MOUSEBUTTONDOWN_EVENT"
      | Sdlevent.MOUSEBUTTONUP_EVENT -> print_endline "MOUSEBUTTONUP_EVENT"
      | Sdlevent.JOYAXISMOTION_EVENT -> print_endline "JOYAXISMOTION_EVENT"
      | Sdlevent.JOYBALL_EVENT -> print_endline "JOYBALL_EVENT"
      | Sdlevent.JOYHAT_EVENT -> print_endline "JOYHAT_EVENT"
      | Sdlevent.JOYBUTTONDOWN_EVENT -> print_endline "JOYBUTTONDOWN_EVENT"
      | Sdlevent.JOYBUTTONUP_EVENT -> print_endline "JOYBUTTONUP_EVENT"
      | Sdlevent.QUIT_EVENT -> print_endline "QUIT_EVENT"
      | Sdlevent.SYSWM_EVENT -> print_endline "SYSWM_EVENT"
      | Sdlevent.RESIZE_EVENT -> print_endline "RESIZE_EVENT"
      | Sdlevent.EXPOSE_EVENT -> print_endline "EXPOSE_EVENT"
      | Sdlevent.USER_EVENT -> print_endline "USER_EVENT"
     in
    List.iter printEventKind (Sdlevent.of_mask (Sdlevent.get_enabled_events ())) ;
	init ()

let () = main ()
