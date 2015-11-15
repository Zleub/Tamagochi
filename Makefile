RESULT	= Tamagochi
SOURCES	= classes/Tamagotchi.ml \
		classes/Button.ml \
		classes/Meter.ml \
		main.ml
LIBS	= bigarray sdl sdlloader sdlttf
INCDIRS	= /nfs/zfs-student-2/users/2013/adebray/.opam/system/lib/sdl
OCAMLLDFLAGS = -custom -cclib "-framework Cocoa"
TREADS	= true
include OCamlMakefile
