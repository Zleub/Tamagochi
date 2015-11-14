(*
* @Author: adebray
* @Date:   2015-11-14 02:09:55
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-14 02:26:05
*)

module type METER =
sig
	type t

	val add : t -> t -> t
	val sub : t -> t -> t

	val pos : Sdlvideo.rect
end
