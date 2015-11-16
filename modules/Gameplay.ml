(*
* @Author: adebray
* @Date:   2015-11-16 21:01:15
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-16 23:42:26
*)

type modList = {
	health : Meter.health ;
	energy : Meter.energy ;
	hygiene : Meter.hygiene ;
	happyness : Meter.happyness
}

let init renderer font = {
	health = new Meter.health renderer font ;
	energy = new Meter.energy renderer font ;
	hygiene = new Meter.hygiene renderer font ;
	happyness = new Meter.happyness renderer font
}

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
