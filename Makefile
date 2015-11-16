RESULT	= Tamagochi
SOURCES	= classes/Tamagotchi.ml \
		classes/Button.ml \
		classes/Meter.ml \
		modules/Gameplay.ml \
		main.ml
LIBS	= bigarray sdl sdlloader sdlttf
INCDIRS	= +sdl /nfs/zfs-student-2/users/2013/adebray/.opam/system/lib/sdl
OCAMLLDFLAGS = -custom -cclib "-framework Cocoa"
TREADS	= true
include OCamlMakefile

fclean:
	rm -rf *.cmi *.cmo **/*.cmi **/*.cmo ._d
