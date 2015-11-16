(*
* @Author: adebray
* @Date:   2015-11-16 21:01:15
* @Last Modified by:   adebray
* @Last Modified time: 2015-11-16 22:00:18
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

let do_eat modList = {
	health = modList.health#update 25 ;
	energy = modList.energy#update (-10) ;
	hygiene = modList.hygiene#update (-20) ;
	happyness = modList.happyness#update 5
}

let do_thunder modList = {
	health = modList.health#update (-20) ;
	energy = modList.energy#update 25 ;
	hygiene = modList.hygiene ;
	happyness = modList.happyness#update (-20)
}

let do_bath modList = {
	health = modList.health#update (-20) ;
	energy = modList.energy#update (-10) ;
	hygiene = modList.hygiene#update 25;
	happyness = modList.happyness#update 5
}

let do_kill modList = {
	health = modList.health#update (-20) ;
	energy = modList.energy#update (-10) ;
	hygiene = modList.hygiene ;
	happyness = modList.happyness#update 20
}

let matchAction point modList =
	if modList.health#get_button#collides point then
		do_eat modList
	else if modList.energy#get_button#collides point then
		do_thunder modList
	else if modList.hygiene#get_button#collides point then
		do_bath modList
	else if modList.happyness#get_button#collides point then
		do_kill modList
	else
		modList
