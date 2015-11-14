RESULT	= Tamagochi
SOURCES	= classes/Tamagotchi.ml \
		classes/Meter.ml \
		main.ml
LIBS	= bigarray sdl
INCDIRS	=
OCAMLLDFLAGS = -cclib "-framework Cocoa -framework SDL2"
TREADS	= true
include OCamlMakefile
