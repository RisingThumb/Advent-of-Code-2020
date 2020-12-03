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


func _on_Day2Part1_pressed():
	var lines = input.get_line_count()
	var numberOfValid = 0
	for i in range(lines):
		var line = input.get_line(i)
		if line == "":
			continue
		var newlines = line.split('-')
		var mincount = int(newlines[0])
		newlines = newlines[1].split(': ')
		var sequence = newlines[1]
		newlines = newlines[0].split(' ')
		var maxcount = int(newlines[0])
		var character = newlines[1]
		var count = 0
		for c in sequence:
			if c == character:
				count += 1
				if count > maxcount: # Don't waste my time
					break
		if count >= mincount and count <= maxcount:
			numberOfValid +=1
	output.text = str(numberOfValid)


func _on_Day2Part2_pressed():
	var lines = input.get_line_count()
	var numberOfValid = 0
	for i in range(lines):
		var line = input.get_line(i)
		if line == "":
			continue
		var newlines = line.split('-')
		var mincount = int(newlines[0])
		newlines = newlines[1].split(': ')
		var sequence: String = newlines[1]
		newlines = newlines[0].split(' ')
		var maxcount = int(newlines[0])
		var character = newlines[1]
		var count = 0
		if sequence[mincount-1] == character and sequence[maxcount-1] != character:
			numberOfValid += 1
		elif sequence[mincount-1] != character and sequence[maxcount-1] == character:
			numberOfValid += 1
	output.text = str(numberOfValid)

func findAmountForSlope(var slope: Vector2):
	var lines = input.get_line_count()
	var width = input.get_line(0).length()
	var treeCount = 0
	var position = slope
	while position.y < lines:
		var lineToCheck = input.get_line(position.y)
		var xToCheck = int(position.x) % (width)
		if lineToCheck[xToCheck] == '#':
			treeCount+=1
		position += slope
	return treeCount

func _on_Day3Part1_pressed():
	output.text = str(findAmountForSlope(Vector2(3,1)))

func _on_Day3Part2_pressed():
	var finalOut = 1
	var slopes = [Vector2(1, 1), Vector2(3, 1), Vector2(5, 1), Vector2(7, 1), Vector2(1, 2)]
	for slope in slopes:
		finalOut *= findAmountForSlope(slope)
	output.text = str(finalOut)
