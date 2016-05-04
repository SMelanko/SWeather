import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

import "Utils.js" as Utils

Rectangle {
	id: _currWeatherWgt
	color: "transparent"

	// Set background.
	Rectangle {
		anchors.fill: parent
		color: "#d7d7d7"
		opacity: 0.3
		radius: 3
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
			id: _locationTxt
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
			id: _temperatureTxt
			anchors {
				top: _locationTxt.bottom
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
			id: _descriptionTxt
			anchors {
				top: _temperatureTxt.bottom
				horizontalCenter: parent.horizontalCenter
			}
			font {
				pixelSize: _currWeatherWgt.height * 0.075
			}
		}

		Column {
			id: _paramsColumn
			anchors {
				top: _descriptionTxt.bottom
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
					source: "qrc:///images/wind.png"
				}

				Text {
					id: _windVelocityTxt
					font {
						pixelSize:  _currWeatherWgt.height * 0.05
					}
				}

				Text {
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
					text: qsTr("m/s")
				}

				Image {
					id: _windDirectionImg
					source: "qrc:///images/wind-direction.png"
					transform: Rotation {
						id: _windDirectionImgRotation
						origin {
							x: _windDirectionImg.width / 2;
							y: _windDirectionImg.width / 2;
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
					source: "qrc:///images/humidity.png"
				}

				Text {
					id: _humidityValueTxt
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
				}

				Text {
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
					source: "qrc:///images/pressure.png"
				}

				Text {
					id: _pressureValueTxt
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
				}

				Text {
					font {
						pixelSize: _currWeatherWgt.height * 0.05
					}
					text: qsTr("mmHg")
				}
			}
		}
	}

	//
	// Main weather image.
	//

	Rectangle {
		id: _weatherImgRect
		anchors {
			left: parent.horizontalCenter
			top: parent.top
			right: parent.right
			bottom: parent.bottom
			margins: 5
		}
		color: "transparent"

		Image {
			id: _weatherMainImg
			width: _weatherImgRect.width * 0.75
			height: _weatherImgRect.height * 0.75
			anchors.centerIn: parent
			fillMode: Image.PreserveAspectFit
		}
	}

	//
	// JS implementation.
	//

	//! Sets current weather parameters.
	// @1 - json object of the parameters for current weather.
	function setCurrWeatherParams(location, data)
	{
		_locationTxt.text = location
		_temperatureTxt.text = Math.round(data.main.temp) + '°'
		_descriptionTxt.text = Utils.convertFirstCharToUpperCase(
			data.weather[0].description)
		var pressureVal = data.main.pressure * 0.75
		_pressureValueTxt.text = parseInt(pressureVal, 10)
		_humidityValueTxt.text = data.main.humidity
		_windVelocityTxt.text = data.wind.speed
		_windDirectionImgRotation.angle = data.wind.deg
		_weatherMainImg.source = 'qrc:///images/main/' +
			Utils.getWeatherIcon(data.weather[0].icon) + '.png'
	}
}
