import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

Rectangle {
	id: _currWeatherWgt
	color: "transparent"

	Rectangle {
		anchors.fill: parent
		color: "#d7d7d7"
		opacity: 0.3
		radius: 3
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
		color: "transparent"

		Image {
			id: _img
			width: _weatherImg.width / 1.5; height: _weatherImg.height / 1.5
			anchors.centerIn: parent
			fillMode: Image.PreserveAspectFit
			smooth: true
		}
	}

	Rectangle {
		anchors {
			left: parent.left
			top: parent.top
			right: parent.horizontalCenter
			bottom: parent.bottom
			margins: 5
		}

		color: "transparent"

		//
		// Location.
		//

		Text {
			id: _location
			anchors {
				top: parent.top
				horizontalCenter: parent.horizontalCenter
			}
			font {
				pixelSize: _currWeatherWgt.height * 0.1
			}
		}

		//
		// Temperature.
		//

		Text {
			id: _temperature
			anchors {
				top: _location.bottom
				horizontalCenter: parent.horizontalCenter
			}
			font {
				family: fontFamily
				pixelSize: _currWeatherWgt.height * 0.25
			}
		}

		//
		// Pressure.
		//

		Text {
			id: _pressure
			anchors.top: _temperature.bottom
			font {
				pointSize: fontSize
			}
			text: qsTr("Pressure") +", " + qsTr("mmHg") + ": "
		}
		Text {
			id: _pressureVal
			anchors {
				top: _temperature.bottom
				left: _pressure.right
			}
			font {
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
				pointSize: fontSize
			}
			text: qsTr("Humidity") +", " + "%" + ": "
		}
		Text {
			id: _humidityVal
			anchors {
				top: _pressure.bottom
				left: _humidity.right
			}
			font {
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
				pointSize: fontSize
			}
			text: qsTr("Wind") +", " + qsTr("m/s") + ": "
		}
		Text {
			id: _windyVal
			anchors {
				top: _humidity.bottom
				left: _windy.right
			}
			font {
				pointSize: fontSize
			}
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
		_temperature.text = Math.round(data.main.temp) + '°'
		var pressureVal = data.main.pressure * 0.75
		_pressureVal.text = parseInt(pressureVal, 10)
		_humidityVal.text = data.main.humidity
		_windyVal.text = data.wind.speed
		_img.source = 'qrc:///images/main/sun.png'
	}
}
