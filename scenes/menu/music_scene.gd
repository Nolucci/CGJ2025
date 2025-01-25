extends Node2D

@onready var Musique_Grotte = $Musique_Grotte
@onready var MusiqueBass1 = $MusiqueBass1
@onready var MusiqueBass2 = $MusiqueBass2
@onready var MusiqueEgypt1 = $MusiqueEgypt1
@onready var MusiqueEgypt2 = $MusiqueEgypt2
@onready var MusiqueTrumpet1 = $MusiqueTrumpet1
@onready var MusiqueTrumpet2 = $MusiqueTrumpet2

@onready var SonMenu = $SonMenu


@onready var music_id = AudioServer.get_bus_index("Bus_one")

# Une liste pour suivre toutes les musiques
var all_musics = []

func _ready():
	all_musics = [
		Musique_Grotte,
		MusiqueBass1, MusiqueBass2,
		MusiqueEgypt1, MusiqueEgypt2,
		MusiqueTrumpet1, MusiqueTrumpet2
	]
	
	# Connect signals to their respective functions
	MusiqueBass1.connect("finished", Callable(self, "_on_musique_bass_1_finished"))
	MusiqueEgypt1.connect("finished", Callable(self, "_on_musique_egypt_1_finished"))
	MusiqueTrumpet1.connect("finished", Callable(self, "_on_musique_trumpet_1_finished"))

func stopAllMusic():
	# Arrêter toutes les musiques de la liste
	for music in all_musics:
		if music.playing:
			music.stop()

func launchMusicGrotte():
	stopAllMusic()
	Musique_Grotte.play()

func launchMusic1():
	stopAllMusic()
	MusiqueBass1.play()

func launchMusic2():
	stopAllMusic()
	MusiqueEgypt1.play()

func launchMusic3():
	stopAllMusic()
	MusiqueTrumpet1.play()

func launchAleatoire():
	stopAllMusic()
	var rand = randi_range(0, 2)
	if rand == 0:
		launchMusic1()
	elif rand == 1:
		launchMusic2()
	elif rand == 2:
		launchMusic3()

func launchSon():
	SonMenu.play()

func update_music_level(new_level):
	AudioServer.get_bus_volume_db(music_id)
	AudioServer.set_bus_mute(music_id, new_level == 0)

func get_music_level():
	return db_to_linear(AudioServer.get_bus_volume_db(music_id))


func _on_musique_bass_1_finished():
	MusiqueBass2.play()


func _on_musique_trumpet_1_finished():
	MusiqueTrumpet2.play()


func _on_musique_egypt_1_finished():
	MusiqueEgypt2.play()
