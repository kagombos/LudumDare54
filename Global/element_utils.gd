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
	Element.FIRE: Color(255, 0, 0),
	Element.WATER: Color(0, 0, 255),
	Element.EARTH: Color(0, 255, 0),
	Element.AIR: Color(0.5, 0.5, 0.5),
	Element.LIGHT: Color(255, 255, 0),
	Element.DARK: Color(0.2, 0.1, 0.5),
	Element.JUNK: Color(255, 255, 255)
}
