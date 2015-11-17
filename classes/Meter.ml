(*
* @Author: adebray
* @Date:   2015-11-14 06:08:52
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-17 17:43:23
*)

exception Lost

class virtual base init renderer font label position =
object (self)

	val _state = init
	val _label = Sdlttf.render_text_blended font label ~fg:Sdlvideo.black
	val _pos = position

	method text = _label
	method state = _state

	method update diff =
		(* print_endline (string_of_int diff) ; *)
		if _state + diff <= 0
			then raise Lost
		else if _state + diff > 100 then
			{< _state = 100 >}
		else
			{< _state = (_state + diff) >}

	method draw = begin
		Sdlvideo.blit_surface
			~src: self#text
			~dst_rect: (Sdlvideo.rect (fst _pos - String.length label) (snd _pos) 0 0)
			~dst:renderer () ;
		Sdlvideo.fill_rect
			~rect:(Sdlvideo.rect ((fst _pos) - 20) ((snd _pos) + 21) 102 12)
			renderer (Sdlvideo.map_RGB renderer Sdlvideo.black) ;
		Sdlvideo.fill_rect
			~rect:(Sdlvideo.rect (((fst _pos) - 20) + 1) ((snd _pos) + 22) _state 10)
			renderer (Sdlvideo.map_RGB renderer Sdlvideo.white)
		end
end

class health renderer font value =
object (self)
	inherit base value renderer font "Health" (30, 10) as super

	val button = new Button.base renderer font "EAT" (30, 210)
	method get_button = button

	method draw = super#draw ; button#draw
end

class energy renderer font value =
object (self)
	inherit base value renderer font "Energy" (160, 10) as super

	val button = new Button.base renderer font "THUNDER" (160, 210)
	method get_button = button

	method draw = super#draw ; button#draw
end

class hygiene renderer font value =
object (self)
	inherit base value renderer font "Hygiene" (290, 10) as super

	val button = new Button.base renderer font "BATH" (290, 210)
	method get_button = button

	method draw = super#draw ; button#draw
end

class happyness renderer font value =
object (self)
	inherit base value renderer font "Happyness" (420, 10) as super

	val button = new Button.base renderer font "KILL" (420, 210)
	method get_button = button

	method draw = super#draw ; button#draw
end

