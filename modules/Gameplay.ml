(*
* @Author: adebray
* @Date:   2015-11-16 21:01:15
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-17 17:49:47
*)

type modList = {
	health : Meter.health ;
	energy : Meter.energy ;
	hygiene : Meter.hygiene ;
	happyness : Meter.happyness
}

let init renderer font =
	let load () =
		try let saveFile = open_in "save.itama" in
			try let input = input_line saveFile in close_in (saveFile) ; input with
			| Sys_error err -> ( print_endline ("saveFile error: " ^ err) ; "" )
			| End_of_file -> ""
		with
			| Sys_error err -> ( print_endline ("saveFile error: " ^ err) ; "" )
	in let rec validate ?(stack = 0) str =
		let rxp = Str.regexp "[0-9][0-9][0-9]" in

		if (str = "\n" || str = "") && stack = 4 then true
		else if Str.string_match rxp str 0 then
			validate ~stack:(stack + 1) (String.sub str 3 ((String.length str) - 3))
		else false
	in match load () with
		| str when validate str ->
			let rxp = Str.regexp "\\([0-9][0-9][0-9]\\)\\([0-9][0-9][0-9]\\)\\([0-9][0-9][0-9]\\)\\([0-9][0-9][0-9]\\)"
			in ignore (Str.string_match rxp str 0) ;
			{
				health = new Meter.health renderer font (int_of_string (Str.matched_group 1 str)) ;
				energy = new Meter.energy renderer font (int_of_string (Str.matched_group 2 str)) ;
				hygiene = new Meter.hygiene renderer font (int_of_string (Str.matched_group 3 str)) ;
				happyness = new Meter.happyness renderer font (int_of_string (Str.matched_group 4 str))
			}
		| _ -> {
			health = new Meter.health renderer font 100 ;
			energy = new Meter.energy renderer font 100 ;
			hygiene = new Meter.hygiene renderer font 100 ;
			happyness = new Meter.happyness renderer font 100
		}

let save modList =
	try let saveFile = open_out "save.itama" in
	Printf.fprintf saveFile "%03d%03d%03d%03d"
		modList.health#state
		modList.energy#state
		modList.hygiene#state
		modList.happyness#state
	with | Sys_error err -> print_endline ("saveFile error: " ^ err)

let update time modList = {
	health = (modList.health#update (-1)) ;
	energy = modList.energy ;
	hygiene = modList.hygiene ;
	happyness = modList.happyness
}

let draw modList = modList.health#draw ;
	modList.energy#draw ;
	modList.hygiene#draw ;
	modList.happyness#draw

let do_action modList hea ene hyg hap = {
	health = modList.health#update hea ;
	energy = modList.energy#update ene ;
	hygiene = modList.hygiene#update hyg ;
	happyness = modList.happyness#update hap
}

let matchAction point modList =
	if modList.health#get_button#collides point then
		do_action modList 25 (-10) (-20) 5
	else if modList.energy#get_button#collides point then
		do_action modList (-20) 25 0 (-20)
	else if modList.hygiene#get_button#collides point then
		do_action modList (-20) (-10) 25 5
	else if modList.happyness#get_button#collides point then
		do_action modList (-20) (-10) 0 20
	else
		modList
