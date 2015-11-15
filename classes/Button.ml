(*
* @Author: adebray
* @Date:   2015-11-14 07:56:10
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-15 03:15:15
*)

class base renderer font label position =
object (self)

	val _label = Sdlttf.render_text_blended font label ~fg:Sdlvideo.black
	val _pos = position

	method text = _label

	method draw = begin
		Sdlvideo.fill_rect
			~rect:(Sdlvideo.rect ((fst _pos) - 20) ((snd _pos) + 81) 102 72)
			renderer (Sdlvideo.map_RGB renderer Sdlvideo.black) ;
		Sdlvideo.fill_rect
			~rect:(Sdlvideo.rect (((fst _pos) - 20) + 1) ((snd _pos) + 82) 100 70)
			renderer (Sdlvideo.map_RGB renderer Sdlvideo.white) ;
		Sdlvideo.blit_surface
			~src: self#text
			~dst_rect: (Sdlvideo.rect (fst _pos + 20 - (String.length label) * 3) (snd _pos + 100) 0 0)
			~dst:renderer ()
		end

end
