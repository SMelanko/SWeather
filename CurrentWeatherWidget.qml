import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

import "Utils.js" as Utils

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
			color: "#c77e35"
			font {
				pixelSize: _currWeatherWgt.height * 0.35
			}
		}

		//
		// Description.
		//

		Text {
			id: _description
			anchors {
				top: _temperature.bottom
				horizontalCenter: parent.horizontalCenter
			}
			font {
				pixelSize: _currWeatherWgt.height * 0.05
			}
		}

		Column {
			id: _column
			anchors {
				top: _description.bottom
				topMargin: _currWeatherWgt.height * 0.05
				horizontalCenter: parent.horizontalCenter
			}
			spacing: 10

			//
			// Wind.
			//

			Row {
				id: _windRow
				spacing: 10

				Image {
					smooth: true
					source: "qrc:///images/wind.png"
				}

				Text {
					id: _windVal
					font {
						pointSize:  _currWeatherWgt.height * 0.05
					}
				}

				Text {
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
					text: qsTr("m/s")
				}

				Image {
					id: _windDirection
					smooth: true
					source: "qrc:///images/wind-direction.png"
					transform: Rotation {
						id: _rotation
						origin {
							x: _windDirection.width / 2;
							y: _windDirection.width / 2;
						}
					}
				}
			}

			//
			// Humidity.
			//

			Row {
				id: _humidityRow
				spacing: 10

				Image {
					smooth: true
					source: "qrc:///images/humidity.png"
				}

				Text {
					id: _humidityVal
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
				}

				Text {
					id: _humidity
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
					text: "%"
				}
			}

			//
			// Pressure.
			//

			Row {
				id: _pressureRow
				spacing: 10

				Image {
					smooth: true
					source: "qrc:///images/pressure.png"
				}

				Text {
					id: _pressureVal
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
				}

				Text {
					id: _pressure
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
					text: qsTr("mmHg")
				}
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
		_description.text = Utils.convertFirstCharToUpperCase(
			data.weather[0].description)
		var pressureVal = data.main.pressure * 0.75
		_pressureVal.text = parseInt(pressureVal, 10)
		_humidityVal.text = data.main.humidity
		_windVal.text = data.wind.speed
		_rotation.angle = data.wind.deg
		_img.source = 'qrc:///images/main/' +
			Utils.getWeatherIcon(data.weather[0].icon) + '.png'
	}
}
