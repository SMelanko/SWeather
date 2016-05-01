//
// JS utility functions.
//

//! Converts the first character in string to the upper case.
// @1 - source string.
function convertFirstCharToUpperCase(str) {
	return str.toUpperCase().charAt(0) + str.substring(1);
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

function foo(code) {
	switch (code) {
	case 200:
	case 201:
	case 202:
	case 210:
	case 230:
	case 231:
	case 232:
		return "storm-showers"
	case 211:
	case 212:
	case 221:
	case 960:
	case 961:
		return "thunderstorm"
	case 300:
	case 301:
	case 302:
	case 310:
	case 311:
	case 312:
	case 313:
	case 314:
	case 321:
	case 701:
		return "sprinkle"
	case 500:
	case 501:
	case 502:
	case 503:
	case 504:
		return "rain"
	case 511:
	case 615:
	case 616:
	case 620:
	case 621:
	case 622:
		return "rain-mix"
	case 520:
	case 521:
	case 522:
	case 531:
		return "showers"
	case 600:
	case 601:
	case 602:
		return "snow"
	case 611:
	case 612:
		return "sleet"
	case 711:
		return "smoke"
	case 721:
		return "day-haze"
	case 741:
		return "fog"
	case 731:
	case 751:
	case 952:
	case 953:
	case 955:
	case 956:
	case 957:
	case 958:
	case 959:
	case 962:
		return "cloudy-gusts"
	case 761:
		return "dust"
	case 762:
		return "smog"
	case 771:
		return "day-windy"
	case 781:
	case 900:
		return "tornado"
	case 800:
	case 951:
		return "sunny"
	case 801:
	case 802:
	case 803:
	case 804:
		return "cloudy"
	case 901:
	case 902:
		return "hurricane"
	case 903:
		return "snowflake-cold"
	case 904:
		return "hot"
	case 905:
		return "windy"
	case 906:
		return "hail"
	}
}
