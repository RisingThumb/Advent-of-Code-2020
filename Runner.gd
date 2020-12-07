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

var passport_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

func passValid(port: Dictionary, part2= false) -> int:
	var isValid = 0
	if port.keys().size() == passport_fields.size() or \
		port.keys().size() == passport_fields.size()-1 and !("cid" in port.keys()):
		isValid = 1
		if part2:
			for element in port.keys():
				match element:
					"byr":
						if int(port[element]) > 2002 or int(port[element]) < 1920:
							isValid = 0
					"iyr":
						if int(port[element]) < 2010 or int(port[element]) > 2020:
							isValid = 0
					"eyr":
						if int(port[element]) > 2030 or int(port[element]) < 2020:
							isValid = 0
					"hgt":
						var el = port[element]
						if el.ends_with("cm"):
							var centi = int(el.trim_suffix("cm"))
							if centi < 150 or centi > 193:
								isValid = 0
						elif el.ends_with("in"):
							var inches = int(el.trim_suffix("in"))
							if inches < 59 or inches > 76:
								isValid = 0
						else:
							isValid = 0
					"hcl":
						var el:String = port[element]
						if el.length() != 7:
							isValid = 0
						var validChars = "0123456789abcdef"
						if el.begins_with("#"):
							el = el.trim_prefix("#")
							for c in el:
								if not (c in validChars):
									isValid = 0
									break
						else:
							isValid = 0
					"ecl":
						var el:String = port[element]
						var validECL = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
						if not (el in validECL):
							isValid = 0
					"pid":
						var el:String = port[element]
						var validChars = "0123456789"
						if el.length() != 9:
							isValid = 0
						else:
							for c in el:
								if not (c in validChars):
									isValid = 0
									break
	return isValid

func _on_Day4Part1_pressed():
	var lines = input.get_line_count()
	var thisPort = {}
	var validCount = 0
	for i in range(lines):
		var thisLine = input.get_line(i)
		if thisLine == "":
			validCount += passValid(thisPort)
			thisPort.clear()
			continue
		
		var lineSplit = thisLine.split(" ")
		for part in lineSplit:
			var sides = part.split(":")
			thisPort[sides[0]]=sides[1]
	
	validCount += passValid(thisPort)
	output.text = str(validCount)

func _on_Day4Part2_pressed():
	var lines = input.get_line_count()
	var thisPort = {}
	var validCount = 0
	for i in range(lines):
		var thisLine = input.get_line(i)
		if thisLine == "":
			validCount += passValid(thisPort, true)
			thisPort.clear()
			continue
		
		var lineSplit = thisLine.split(" ")
		for part in lineSplit:
			var sides = part.split(":")
			thisPort[sides[0]]=sides[1]
	
	validCount += passValid(thisPort, true)
	output.text = str(validCount)


func _on_Day5Part1_pressed():
	var lines = input.get_line_count()
	var largestID = -1
	for i in range(lines):
		var shifter = 64
		var upper = 127
		var lower = 0
		var line = input.get_line(i)
		for j in range(7):
			var c = line[j]
			if c == "F":
				upper -= shifter
			if c == "B":
				lower += shifter
			shifter/=2
		var row = upper
		upper = 7
		lower = 0
		shifter = 4
		for j in range(3):
			var c = line[j+7]
			if c == "L":
				upper -= shifter
			if c == "R":
				lower += shifter
			shifter /= 2
		var col = upper
		
		var seatID = row * 8 + col
		if seatID > largestID:
			largestID = seatID
	output.text = str(largestID)


func _on_Day5Part2_pressed():
	var seats = []
	var lines = input.get_line_count()
	var largestID = -1
	for i in range(lines):
		var shifter = 64
		var upper = 127
		var lower = 0
		var line = input.get_line(i)
		for j in range(7):
			var c = line[j]
			if c == "F":
				upper -= shifter
			if c == "B":
				lower += shifter
			shifter/=2
		var row = upper
		upper = 7
		lower = 0
		shifter = 4
		for j in range(3):
			var c = line[j+7]
			if c == "L":
				upper -= shifter
			if c == "R":
				lower += shifter
			shifter /= 2
		var col = upper
		
		var seatID = row * 8 + col
		seats.append(seatID)
		
	seats.sort()
	var previousID = -1
	for seat in seats:
		if previousID == -1:
			previousID = seat
			continue
		if (seat-previousID) == 2:
			output.text = str(previousID+1)
			break
		previousID = seat


func _on_Day6Part1_pressed():
	var groups = [[]]
	var lines = input.get_line_count()
	for i in range(lines):
		var line = input.get_line(i)
		if line == "":
			groups.append([])
			continue
		for c in line:
			groups[-1].append(line)
	#print(groups)
	var count = 0
	for group in groups:
		var questions = []
		for person in group:
			for c in person:
				if !(c in questions):
					questions.append(c)
		count += questions.size()
	output.text = str(count)


func _on_Day6Part2_pressed():
	var groups = [[]]
	var lines = input.get_line_count()
	for i in range(lines):
		var line = input.get_line(i)
		if line == "":
			groups.append([])
			continue
		for c in line:
			groups[-1].append(line)
	var count = 0
	for group in groups:
		var questions = []
		var questionsAdded = []
		var firstPerson = true
		for person in group:
			if firstPerson:
				for c in person:
					questions.append(c)
				firstPerson = false
			else:
				var removalLetters = []
				for q in questions:
					if !(q in person):
						removalLetters.append(q)
				for l in removalLetters:
					questions.remove(questions.find(l))

		count += questions.size()
	output.text = str(count)
	print(count)


func _on_Day7Part1_pressed():
	pass # Replace with function body.


func _on_Day7Part2_pressed():
	pass # Replace with function body.
