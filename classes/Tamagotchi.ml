(*
* @Author: adebray
* @Date:   2015-11-14 07:41:46
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-15 03:12:57
*)

let quadlist = [
	Sdlvideo.rect 0 0 (30 * 4) (30 * 4) ;
	Sdlvideo.rect (30 * 4) 0 (30 * 4) (30 * 4) ;
	Sdlvideo.rect 0 (30 * 4) (30 * 4) (30 * 4) ;
]

let animationList = [ 0 ; 0 ; 0 ; 1 ; 1 ; 0 ; 0]

class hamtaro file screen =
object (self)

	val _timer = 0
	val _animationIndex = 0
	val _pos = ((265 - 60), (200 - 60))
	val _image = Sdlloader.load_image file

	method update =
		(* print_endline (string_of_int _timer) ; *)
		if _timer = 30 && _animationIndex + 1 < (List.length animationList) then
			{< _timer = 0 ; _animationIndex = (_animationIndex + 1) >}
		else if _timer = 30 then
			{< _timer = 0 ; _animationIndex = 0 >}
		else
			{< _timer = (_timer + 1) >}

	method draw =
		Sdlvideo.blit_surface
		~src_rect:(List.nth quadlist (List.nth animationList _animationIndex))
		~dst_rect: (Sdlvideo.rect (fst _pos) (snd _pos) 0 0)
		~src: _image
		~dst: screen ()

end
