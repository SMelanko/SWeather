//
// JS utility functions.
//

//! Converts the first character in string to the upper case.
// @1 - source string.
function convertFirstCharToUpperCase(str) {
	return str.toUpperCase().charAt(0) + str.substring(1);
}

//! Returns month name from date.
// @1 - date object.
function getMonthNameFromDate(date) {
	var monthNames = ["Jan", "Feb", "Mar", "Apr", "May",
		"Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

	return monthNames[date.getMonth()];
}

//! Return icon id.
// @1 - code of the icon.
function getWeatherIcon(code) {
	// http://openweathermap.org/weather-conditions
	switch (code) {
	case "01d":
	case "01n":
		return code
	case "02d":
	case "02n":
		return code
	case "03d":
	case "03n":
	case "04d":
	case "04n":
		return "03d"
	case "09d":
	case "09n":
		return "09d"
	case "10d":
	case "10n":
		return "10d"
	case "11d":
	case "11n":
		return "11d"
	case "13d":
	case "13n":
		return "13d"
	case "50d":
	case "50n":
		return code
	default:
		return "01d" // TODO Return 'error' image.
	}
}

//! Converts Celsius temperature unit to Fahrenheit.
function Celsius2Fahrenheit(celsius) {
	return (celsius * 1.8) + 32
}

//! Converts Celsius temperature unit to Kelvin.
function Celsius2Kelvin(celsius) {
	return celsius + 273.15
}

//! Converts Fahrenheit temperature unit to Celsius.
function Fahrenheit2Celsius(fahrenheit) {
	return (fahrenheit - 32) / 1.8
}

//! Converts Fahrenheit temperature unit to Kelvin.
function Fahrenheit2Kelvin(fahrenheit) {
	return (fahrenheit + 459.67) * 0.556
}

//! Converts Kelvin temperature unit to Celsius.
function Kelvin2Celsius(kelvin) {
	return kelvin - 273.15
}

//! Converts Kelvin temperature unit to Fahrenheit.
function Kelvin2Fahrenheit(kelvin) {
	return kelvin / 0.556 - 459.67
}
