RESULT	= Tamagochi
SOURCES	= main.ml \
	modules/Meter.mli \
	modules/Health.ml
LIBS	= bigarray sdl sdlloader sdlttf
INCDIRS	= +sdl
OCAMLLDFLAGS = -cclib sdl
TREADS	= true
include OCamlMakefile
