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
		color: "#d7d7d7"
		opacity: 0.3
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
/*
	// Main params.
	RowLayout {
		id: _mainParamsRowLayout
		anchors {
			left: parent.left
			top: _locationRowLayout.bottom
			right: parent.right
		}
		height: parent.height * 0.75

		// Left.
		ColumnLayout {
			id: _leftParamsColLayout
			anchors {
				left: parent.left
				top: _locationRowLayout.bottom
				right: parent.horizontalCenter
			}

			// Temperature.
			Text {
				id: _temperatureTxt
				color: "#c77e35"
				font {
					pixelSize: _leftParamsColLayout.height * 0.7
				}
			}

			// Description.
			Text {
				id: _descriptionTxt
				font {
					pixelSize: _leftParamsColLayout.height * 0.2
				}
			}
		}

		// Right. Main weather image.
		Image {
			id: _weatherMainImg
			//width: _weatherImgRect.width * 0.75
			//height: _weatherImgRect.height * 0.75
			//anchors.centerIn: parent
			fillMode: Image.PreserveAspectFit
		}
	}
*/
	RowLayout {
		id: _paramsRowLayout
		anchors {
			left: parent.left
			//top: _locationRowLayout.bottom
			right: parent.right
			bottom: parent.bottom
			margins: 5
		}
		height: parent.height * 0.1

		readonly property int spacingVal: 4
		readonly property int paramFontSize: height * 0.9
		readonly property int measureFontSize: height * 0.7

		// Wind.
		Row {
			id: _windRow
			Layout.fillWidth: true
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
			Layout.fillWidth: true
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
			Layout.fillWidth: true
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
		/*_temperatureTxt.text = Math.round(data.main.temp) + '°'
		_descriptionTxt.text = Utils.convertFirstCharToUpperCase(
			data.weather[0].description)*/
		var pressureVal = data.main.pressure * 0.75
		_pressureValueTxt.text = parseInt(pressureVal, 10)
		_humidityValueTxt.text = data.main.humidity
		_windVelocityTxt.text = data.wind.speed.toFixed(1)
		_windDirectionImgRotation.angle = data.wind.deg
		/*_weatherMainImg.source = 'qrc:///images/main/' +
			Utils.getWeatherIcon(data.weather[0].icon) + '.png'*/
	}
}
