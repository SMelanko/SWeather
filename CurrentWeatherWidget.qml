import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

Rectangle {

	property string fontFamily: "Open Sans"
	property int fontSize: 18
	property int margin: 5

	//
	// Weather image.
	//

	Item {
		id: _weatherImg
		anchors {
			top: parent.top
			right: parent.right
		}
		width: 64; height: 64

		property alias source: _img.source

		Image {
			id: _img
			anchors.centerIn: parent
			cache: false
		}
	}

	//
	// Location.
	//

	Text {
		id: _location
		anchors {
			left: parent.left
			top: parent.top
			leftMargin: margin
			topMargin: margin
			bottomMargin: margin
		}
		color: "#357ec7"
		font {
			family: fontFamily
			pointSize: fontSize * 2
		}
	}

	//
	// Temperature.
	//

	Text {
		id: _temperature
		x: margin
		anchors {
			top: _location.bottom
		}
		font {
			family: fontFamily
			pointSize: fontSize
		}
		text: qsTr("Temperature") +", " + "°C" + ":"
	}
	Text {
		id: _temperatureVal
		anchors {
			left: _temperature.right
			top: _location.bottom
			leftMargin: margin
		}
		font {
			family: fontFamily
			pointSize: fontSize
		}
	}

	//
	// Pressure.
	//

	Text {
		id: _pressure
		x: margin
		anchors.top: _temperature.bottom
		font {
			family: fontFamily
			pointSize: fontSize
		}
		text: qsTr("Pressure") +", " + qsTr("mmHg") + ":"
	}
	Text {
		id: _pressureVal
		anchors {
			top: _temperature.bottom
			left: _pressure.right
			leftMargin: margin
		}
		font {
			family: fontFamily
			pointSize: fontSize
		}
	}

	//
	// Humidity.
	//

	Text {
		id: _humidity
		x: margin
		anchors.top: _pressure.bottom
		font {
			family: fontFamily
			pointSize: fontSize
		}
		text: qsTr("Humidity") +", " + "%" + ":"
	}
	Text {
		id: _humidityVal
		anchors {
			top: _pressure.bottom
			left: _humidity.right
			leftMargin: margin
		}
		font {
			family: fontFamily
			pointSize: fontSize
		}
	}

	//
	// Windy.
	//

	Text {
		id: _windy
		x: margin
		anchors.top: _humidity.bottom
		font {
			family: fontFamily
			pointSize: fontSize
		}
		text: qsTr("Windy") +", " + qsTr("m/s") + ":"
	}
	Text {
		id: _windyVal
		anchors {
			top: _humidity.bottom
			left: _windy.right
			leftMargin: margin
		}
		font {
			family: fontFamily
			pointSize: fontSize
		}
	}

	//
	// JS implementation.
	//

	//! Sets current weather parameters.
	// @1 - json object of the parameters for current weather.
	function setCurrWeatherParams(location, data)
	{
		_location.text = location
		_temperatureVal.text = data.main.temp
		var pressureVal = data.main.pressure * 0.75
		_pressureVal.text = parseInt(pressureVal, 10)
		_humidityVal.text = data.main.humidity
		_windyVal.text = data.wind.speed
	}
}
