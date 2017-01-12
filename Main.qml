import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0

import "Utils.js" as Utils

ApplicationWindow {
	id: _applicationWindow
	width: 550; height: 700
	title: qsTr("SWeather")
	visible: true

	property string apiKey: '6f75ff20ca01b304bb986d7019d05adc'
	property string cityId: '706483' // Kharkiv, Ukraine.
	property string units: 'metric'

	signal responseFailed(int status, string msg)
	signal responseReceived(string response)

	Component.onCompleted: {
		httpRequest()
	}

	header: Rectangle {
		id: _header
		width: _applicationWindow.width; height: _title.height * 1.2
		gradient: Gradient {
			GradientStop { position: 0.0; color: "#000" }
			GradientStop { position: 1.0; color: "#4c4c4c" }
		}

		Rectangle {
			anchors {
				left: _header.left
				leftMargin: 10
				verticalCenter: _header.verticalCenter
			}
			width: _header.width * 0.1; height: _header.height * 0.8
			color: "transparent"

			Image {
				anchors.centerIn: parent
				source: "qrc:///images/update.png"
			}

			MouseArea {
				anchors.fill: parent
				onClicked: httpRequest()
			}
		}

		Text {
			anchors.centerIn: _header
			id: _title
			color: "#357ec7"
			font {
				pointSize: 36
			}
			text: "SWeather"
		}

		Rectangle {
			anchors {
				right: _header.right
				rightMargin: 10
				verticalCenter: _header.verticalCenter
			}
			width: _header.width * 0.1; height: _header.height * 0.8
			color: "transparent"

			Image {
				anchors.centerIn: parent
				source: "qrc:///images/menu.png"
			}

			MouseArea {
				anchors.fill: parent
				onClicked: _optionsMenu.open()
			}
/*
			Menu {
				id: _optionsMenu
				x: parent.width - width
				transformOrigin: Menu.TopRight

				MenuItem {
					text: "Settings"
					onTriggered: _settingsPopup.open()
				}
				MenuItem {
					text: "About"
					onTriggered: _aboutPopup.open()
				}
			}
*/
		}
	}

	CurrentWeatherWidget {
		id: _currWeatherWgt
		width: parent.width; height: parent.height * 0.5
		anchors {
			left: parent.left
			top: _header.bottom
			right: parent.right
			margins: 5
		}
		visible: false
	}

	BusyIndicator {
		id: _busiIndicator
		readonly property int size: Math.min(_applicationWindow.width, _applicationWindow.height) / 5
		width: size; height: size
		anchors.centerIn: parent
		visible: true
	}

	WeatherListView {
		id: _listView
		anchors {
			left: parent.left
			top: _currWeatherWgt.bottom
			right: parent.right
			bottom: parent.bottom
			margins: 5
		}
		visible: false
	}

	MessageDialog {
		id: _msgBox
		icon: StandardIcon.Critical
		modality: Qt.WindowModal
		standardButtons: StandardButton.Ok
		title: qsTr("Error box")
		visible: false

		onAccepted: {
			Qt.quit()
		}
	}

	AboutPopup {
		id: _aboutPopup
	}

	SettingsPopup {
		id: _settingsPopup
	}

	//
	// Slots implementations.
	//

	onResponseFailed: {
		_busiIndicator.visible = false

		if (status == 0) {
			_msgBox.informativeText = "No internet connection"
		} else {
			_msgBox.informativeText = status + ': ' + msg
		}

		_msgBox.visible = true
	}

	onResponseReceived: {
		console.log(response)
		var data = JSON.parse(response)
		var location = data.city.name + ', ' + data.city.country

		_busiIndicator.visible = false
		_currWeatherWgt.visible = true
		_listView.visible = true

		_currWeatherWgt.setCurrWeatherParams(location, data.list[0])

		for (var j = 1; j < 9; ++j) {
			_listView.addRow(data.list[j])
		}
	}

	//
	// JS function implementations.
	//

	//! Receives response from the server.
	// @1 - Request url.
	function getResponse(request_) {
		var xhr = new XMLHttpRequest;
		xhr.open("GET", request_, true);
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE) {
				if (xhr.status === 200) {
					_applicationWindow.responseReceived(xhr.responseText)
				} else {
					_applicationWindow.responseFailed(xhr.status, xhr.statusText)
				}
			}
		}
		xhr.send(null)
	}

	function httpRequest() {
		var request = makeRequestUrl(cityId, apiKey, units)
		console.log(request)
		getResponse(request)
	}

	//! Makes a request url.
	// @1 - City id.
	// @2 - API key.
	// @3 - Temperature unit. For temperature in Fahrenheit - imperial,
	//      Celsius - metric. Temperature in Kelvin is used by default.
	function makeRequestUrl(cityId_, apiKey_, units_) {
		var request = 'http://api.openweathermap.org/data/2.5/forecast/'
		request += 'city?id=' + cityId_
		request += '&units=' + units_
		request += '&APPID=' + apiKey_
		return request
	}
}
