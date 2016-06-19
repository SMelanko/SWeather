import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import QtQuick.Layouts 1.3

import "Utils.js" as Utils

Rectangle {
	id: _currWeatherWgt
	color: "transparent"

	// Set background.
	Rectangle {
		anchors.fill: parent
		border {
			color: "#adadad"
			width: 1
		}

		color: "#d7d7d7"
		radius: 3
	}

	// Location label.
	RowLayout {
		id: _locationRowLayout
		anchors {
			left: parent.left
			top: parent.top
			right: parent.right
		}
		height: parent.height * 0.15

		Text {
			id: _locationTxt
			anchors.centerIn: parent
			font {
				pixelSize: _locationRowLayout.height * 0.9
			}
		}
	}

	RowLayout {
		id: _mainRowLayout
		anchors {
			left: parent.left
			top: _locationRowLayout.bottom
			right: parent.right
			bottom: _descrRowLayout.top
		}

		// Temperature.
		Item {
			id: _tempItem
			anchors {
				left: parent.left
				top: parent.top
				right: parent.horizontalCenter
				bottom: parent.bottom
			}

			Text {
				id: _temperatureTxt
				anchors.centerIn: parent
				color: "#c77e35"
				font {
					pixelSize: _mainRowLayout.height * 0.6
				}
			}
		}

		Image {
			id: _weatherMainImg
			anchors {
				left: _tempItem.right
				top: parent.top
				right: parent.right
				bottom: parent.bottom
			}
			fillMode: Image.PreserveAspectFit
		}
	}

	RowLayout {
		id: _descrRowLayout
		anchors {
			left: parent.left
			right: parent.right
			bottom: _paramsRowLayout.top
		}
		height: parent.height * 0.15

		// Description.
		Text {
			id: _descriptionTxt
			anchors.horizontalCenter: parent.horizontalCenter
			font {
				pixelSize: _descrRowLayout.height * 0.9
			}
		}
	}

	RowLayout {
		id: _paramsRowLayout
		anchors {
			left: parent.left
			right: parent.right
			bottom: parent.bottom
			margins: 3
		}
		height: parent.height * 0.15

		readonly property int spacingVal: 2
		readonly property int paramFontSize: parent.height * 0.1 * 0.9
		readonly property int measureFontSize: parent.height * 0.1 * 0.7

		// Wind.
		Row {
			id: _windRow
			anchors.left: parent.left
			spacing: parent.spacingVal

			Image {
				anchors.verticalCenter: parent.verticalCenter
				source: "qrc:///images/wind.png"
			}

			Text {
				id: _windVelocityTxt
				anchors.verticalCenter: parent.verticalCenter
				font {
					pixelSize: _paramsRowLayout.paramFontSize
				}
			}

			Text {
				anchors.verticalCenter: parent.verticalCenter
				font {
					pixelSize: _paramsRowLayout.measureFontSize
				}
				text: qsTr("m/s")
			}

			Image {
				id: _windDirectionImg
				anchors.verticalCenter: parent.verticalCenter
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

		// Humidity.
		Row {
			id: _humidityRow
			anchors.centerIn: parent
			spacing: parent.spacingVal

			Image {
				anchors.verticalCenter: parent.verticalCenter
				source: "qrc:///images/humidity.png"
			}

			Text {
				id: _humidityValueTxt
				anchors.verticalCenter: parent.verticalCenter
				font {
					pixelSize: _paramsRowLayout.paramFontSize
				}
			}

			Text {
				anchors.verticalCenter: parent.verticalCenter
				font {
					pixelSize: _paramsRowLayout.measureFontSize
				}
				text: "%"
			}
		}

		// Pressure.
		Row {
			id: _pressureRow
			anchors.right: parent.right
			spacing: parent.spacingVal

			Image {
				anchors.verticalCenter: parent.verticalCenter
				source: "qrc:///images/pressure.png"
			}

			Text {
				id: _pressureValueTxt
				anchors.verticalCenter: parent.verticalCenter
				font {
					pixelSize: _paramsRowLayout.paramFontSize
				}
			}

			Text {
				anchors.verticalCenter: parent.verticalCenter
				font {
					pixelSize: _paramsRowLayout.measureFontSize
				}
				text: qsTr("mmHg")
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
		_locationTxt.text = location
		_temperatureTxt.text = Math.round(data.main.temp) + '°'
		_descriptionTxt.text = Utils.convertFirstCharToUpperCase(
			data.weather[0].description)
		var pressureVal = data.main.pressure * 0.75
		_pressureValueTxt.text = parseInt(pressureVal, 10)
		_humidityValueTxt.text = data.main.humidity
		_windVelocityTxt.text = data.wind.speed.toFixed(1)
		_windDirectionImgRotation.angle = data.wind.deg
		_weatherMainImg.source = 'qrc:///images/main/' +
			Utils.getWeatherIcon(data.weather[0].icon) + '.png'
	}
}
