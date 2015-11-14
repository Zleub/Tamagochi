(*
* @Author: adebray
* @Date:   2015-11-14 06:08:52
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-14 07:40:28
*)

class virtual base renderer font label position =
object (self)

	val _label = Sdlttf.render_text_blended font "Enjoy 1" ~fg:Sdlvideo.black
	val _pos = Sdlvideo.rect (fst position) (snd position) 0 0

	method text = _label
	method position = _pos

	method draw = Sdlvideo.blit_surface
		~src: self#text
		~dst_rect:self#position
		~dst:renderer ()

end

class health renderer font =
object (self)
	inherit base renderer font "Health" (100, 100)
end

