RESULT	= Tamagochi
SOURCES	= classes/Tamagotchi.ml \
		classes/Button.ml \
		classes/Meter.ml \
		main.ml
LIBS	= bigarray sdl sdlloader sdlttf
INCDIRS	= +sdl
OCAMLLDFLAGS = -cclib "-framework Cocoa"
TREADS	= true
include OCamlMakefile
