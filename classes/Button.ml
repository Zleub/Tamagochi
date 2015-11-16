(*
* @Author: adebray
* @Date:   2015-11-14 07:56:10
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-16 21:51:19
*)

class base renderer font label position =
object (self)

	val _label = Sdlttf.render_text_blended font label ~fg:Sdlvideo.black
	val _pos = ((fst position - 20), (snd position + 80))
	val _size = (100 , 70)

	method text = _label
	method collides (point : int * int) =
		((fst _pos) < (fst point) && (fst point) < (fst _pos) + (fst _size)) &&
		((snd _pos) < (snd point) && (snd point) < (snd _pos) + (snd _size))

	method draw = begin
		Sdlvideo.fill_rect
			~rect:(Sdlvideo.rect (fst _pos) ((snd _pos) + 1) 102 72)
			renderer (Sdlvideo.map_RGB renderer Sdlvideo.black) ;
		Sdlvideo.fill_rect
			~rect:(Sdlvideo.rect ((fst _pos) + 1) ((snd _pos) + 2) 100 70)
			renderer (Sdlvideo.map_RGB renderer Sdlvideo.white) ;
		Sdlvideo.blit_surface
			~src: self#text
			~dst_rect: (Sdlvideo.rect (fst _pos + 40 - (String.length label) * 3) (snd _pos + 20) 0 0)
			~dst:renderer ()
		end

end
