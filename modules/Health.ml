(*
* @Author: adebray
* @Date:   2015-11-14 02:08:32
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-14 02:28:21
*)

module Health : Meter.METER =
struct
	type t = int

	let add = ( + )
	let sub = ( - )

	let pos = Sdlvideo.rect 10 10 100 100
end
