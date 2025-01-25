extends Node2D

@onready var Musique_Grotte = $Musique_Grotte
@onready var Musique_1 = $Musique_1
@onready var Musique_2 = $Musique_2
@onready var Musique_3 = $Musique_3

@onready var music_id = AudioServer.get_bus_index("Bus_one")

func stopAllMusic():
	Musique_Grotte.stop()
	Musique_1.stop()
	Musique_2.stop()
	Musique_3.stop()

func launchMusicGrotte():
	stopAllMusic()
	Musique_Grotte.play()

func launchMusic1():
	stopAllMusic()
	Musique_1.play()

func launchMusic2():
	stopAllMusic()
	Musique_2.play()

func launchMusic3():
	stopAllMusic()
	Musique_3.play()

func lauchAleatoire():
	var rand = randi_range(0,2)
	if rand == 0:
		launchMusic1()
	elif rand == 1 :
		launchMusic2()
	if rand == 2:
		launchMusic3()


func update_music_level(new_level):
	AudioServer.get_bus_volume_db(music_id)
	AudioServer.set_bus_mute(music_id, new_level == 0)

func get_music_level():
	return db_to_linear(AudioServer.get_bus_volume_db(music_id))
