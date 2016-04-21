import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

Rectangle {
	color: "transparent"
	border {
		width: 1
		color: "magenta"
	}

	property string fontFamily: "Open Sans"
	property int fontSize: 18

	//
	// Weather image.
	//

	Rectangle {
		id: _weatherImg
		anchors {
			left: parent.horizontalCenter
			top: parent.top
			right: parent.right
			bottom: parent.bottom
			margins: 5
		}
		border {
			width: 1
			color: "red"
		}

		property alias source: _img.source

		Image {
			id: _img
			width: _weatherImg.width / 1.5; height: _weatherImg.height / 1.5
			anchors.centerIn: parent
			fillMode: Image.PreserveAspectFit
			smooth: true
			source: "qrc:///images/main/moon_cloud.png"
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
