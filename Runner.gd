extends Control

onready var input = $VBoxContainer/HBoxContainer/MarginContainer/Input
onready var output = $VBoxContainer/Output


func _on_Day1_pressed():
	var lines = input.get_line_count()
	for i in range(lines):
		for j in range(lines):
			if i == j:
				continue
			if int(input.get_line(i)) + int(input.get_line(j)) == 2020:
				output.text = str(int(input.get_line(i)) * int(input.get_line(j)))
				break


func _on_Day1Part2_pressed():
	var lines = input.get_line_count()
	for i in range(lines):
		for j in range(lines):
			if i == j:
				continue
			for k in range(lines):
				if i == k or j == k:
					continue
				if int(input.get_line(i)) + int(input.get_line(j)) + int(input.get_line(k)) == 2020:
					output.text = str(int(input.get_line(i)) * int(input.get_line(j)) * int(input.get_line(k)))
					break
