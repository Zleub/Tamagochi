(*
* @Author: adebray
* @Date:   2015-11-14 07:41:46
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-17 18:41:29
*)

let quadlist = [
(* 0 *)		Sdlvideo.rect 0			0			(30 * 4) (30 * 4) ;
(* 1 *)		Sdlvideo.rect (30 * 4)	0			(30 * 4) (30 * 4) ;
(* 2 *)		Sdlvideo.rect (60 * 4)	0			(30 * 4) (30 * 4) ;

(* 3 *)		Sdlvideo.rect 0			(30 * 4)	(30 * 4) (30 * 4) ;
(* 4 *)		Sdlvideo.rect (30 * 4)	(30 * 4)	(30 * 4) (30 * 4) ;
(* 5 *)		Sdlvideo.rect (60 * 4)	(30 * 4)	(30 * 4) (30 * 4) ;
(* 6 *)		Sdlvideo.rect (90 * 4)	(30 * 4)	(30 * 4) (30 * 4) ;

(* 7 *)		Sdlvideo.rect 0			(60 * 4)	(30 * 4) (30 * 4) ;
(* 8 *)		Sdlvideo.rect (30 * 4)	(60 * 4)	(30 * 4) (30 * 4) ;
(* 9 *)		Sdlvideo.rect (60 * 4)	(60 * 4)	(30 * 4) (30 * 4) ;

(* 10 *)	Sdlvideo.rect 0			(90 * 4)	(30 * 4) (30 * 4) ;
(* 11 *)	Sdlvideo.rect (30 * 4)	(90 * 4)	(30 * 4) (30 * 4) ;
(* 12 *)	Sdlvideo.rect (60 * 4)	(90 * 4)	(30 * 4) (30 * 4) ;
(* 13 *)	Sdlvideo.rect (90 * 4)	(90 * 4)	(30 * 4) (30 * 4)
]

let animationList = [
	[ 3 ; 4 ; 5 ; 6 ; 3 ; 3] ;
	[ 0 ; 0 ; 0 ; 0; 0 ; 0 ; 0 ] ;
	[ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 1 ; 1 ; 1 ] ;
	[ 0 ; 0 ; 0 ; 0 ; 1 ; 1 ; 1 ; 1 ; 2 ; 2 ; 0 ] ;
	[ 0 ; 0 ; 0 ; 0 ; 0 ; 7 ; 7 ; 7 ; 8 ; 8 ; 9 ; 9 ] ;
	[ 10 ; 11 ; 12 ; 13 ; 10 ; 10]
]

class hamtaro file screen =
object (self)

	val _rate = 4
	val _timer = 0
	val _animation = 0
	val _animationIndex = 0
	val _pos = ((265 - 60), (200 - 60))
	val _image = Sdlloader.load_image file

	method update =
		let index = (List.nth (List.nth animationList _animation) _animationIndex) in
		if _timer = _rate && _animationIndex + 1 < (List.length (List.nth animationList _animation)) then
			match index with
			| 4 -> {< _timer = 0 ; _animationIndex = (_animationIndex + 1) ; _pos = ((fst _pos) - 10, (snd _pos))>}
			| 6 -> {< _timer = 0 ; _animationIndex = (_animationIndex + 1) ; _pos = ((fst _pos) - 10, (snd _pos))>}
			| 11 -> {< _timer = 0 ; _animationIndex = (_animationIndex + 1) ; _pos = ((fst _pos) + 10, (snd _pos))>}
			| 13 -> {< _timer = 0 ; _animationIndex = (_animationIndex + 1) ; _pos = ((fst _pos) + 10, (snd _pos))>}
			| _ -> {< _timer = 0 ; _animationIndex = (_animationIndex + 1) >}
		else if _timer = _rate then
			begin
				if (fst _pos) < 100 then
					{< _timer = 0 ; _animationIndex = 0 ; _animation = (Random.int ((List.length animationList) - 1)) + 1 >}
				else if (fst _pos) > 300 then
					{< _timer = 0 ; _animationIndex = 0 ; _animation = Random.int ((List.length animationList) - 1) >}
				else
					{< _timer = 0 ; _animationIndex = 0 ; _animation = (Random.int ((List.length animationList))) >}
			end
		else
			{< _timer = (_timer + 1) >}

	method draw =
		Sdlvideo.blit_surface
		~src_rect:(List.nth quadlist (List.nth (List.nth animationList _animation) _animationIndex))
		~dst_rect: (Sdlvideo.rect (fst _pos) (snd _pos) 0 0)
		~src: _image
		~dst: screen ()

end
