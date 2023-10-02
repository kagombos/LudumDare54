extends Node

var DigitToElementMap = {
	11: Element.FIRE, #L
	19: Element.EARTH, #T
	0: Element.WATER, #A
	12: Element.LIGHT, #M
	2: Element.DARK, #C
	25: Element.AIR, #Z
}

var ElementToString = {
	Element.FIRE: "Fire",
	Element.WATER: "Water",
	Element.LIGHT: "Light",
	Element.DARK: "Dark",
	Element.AIR: "Air",
	Element.EARTH: "Earth",
	Element.JUNK: "Junk",
	Element.NONE: "None",
}

var ElementToColor = {
	Element.FIRE: Color(1, 0, 0),
	Element.WATER: Color(0, 0, 1),
	Element.EARTH: Color(0, 1, 0),
	Element.AIR: Color(0.5, 0.5, 0.5),
	Element.LIGHT: Color(1, 1, 1),
	Element.DARK: Color(0.3, 0.2, 0.6),
	Element.JUNK: Color(1, 1, 1),
	Element.NONE: Color(1, 1, 1, 0)
}

var ElementToIcon = {
	Element.FIRE: preload("res://UI/Sprites/Fire_Icon.png"),
	Element.WATER: preload("res://UI/Sprites/Water_Icon.png"),
	Element.EARTH: preload("res://UI/Sprites/Earth_Icon.png"),
	Element.AIR: preload("res://UI/Sprites/Air_Icon.png"),
	Element.LIGHT: preload("res://UI/Sprites/Light_Icon.png"),
	Element.DARK: preload("res://UI/Sprites/Dark_Icon.png"),
	Element.JUNK: preload("res://UI/Sprites/Junk_Icon.png"),
}
