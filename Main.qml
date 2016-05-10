import QtQuick 2.5
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import QtQuick.Window 2.2

import "Utils.js" as Utils

ApplicationWindow {
	id: _applicationWindow
	width: 550; height: 700
	title: qsTr("SWeather")
	visible: true

	//
	// Property interface.
	//
	property string apiKey: '6f75ff20ca01b304bb986d7019d05adc'
	property string cityId: '706483' // Kharkiv, Ukraine.
	property string units: 'metric'

	//
	// Signals interface.
	//
	signal responseFailed(int status, string msg)
	signal responseReceived(string response)

	Component.onCompleted: {
		httpRequest()

		console.log("pixel density: " +
			Screen.pixelDensity.toFixed(2) + " dots/mm (" +
			(Screen.pixelDensity * 25.4).toFixed(2) + " dots/inch)")
		console.log("dimensions: " + Screen.width + "x" + Screen.height)
		console.log("logical pixel density: " +
			Screen.logicalPixelDensity.toFixed(2) + " dots/mm (" +
			(Screen.logicalPixelDensity * 25.4).toFixed(2) + " dots/inch)")
		console.log("device pixel ratio: " + Screen.devicePixelRatio.toFixed(2))
		console.log("available virtual desktop: " +
			Screen.desktopAvailableWidth + "x" + Screen.desktopAvailableHeight)
	}

	/*
		// Work
		qml: pixel density: 3.76 dots/mm (95.60 dots/inch)
		qml: dimensions: 1920x1080
		qml: logical pixel density: 3.78 dots/mm (96.00 dots/inch)
		qml: device pixel ratio: 1.00
		qml: available virtual desktop: 3200x1053
		// Mac
		qml: pixel density: 4.47 dots/mm (113.50 dots/inch)
		qml: dimensions: 1280x800
		qml: logical pixel density: 2.83 dots/mm (72.00 dots/inch)
		qml: device pixel ratio: 2.00
		qml: available virtual desktop: 1280x730
		// Nexus 5
		qml: pixel density: 5.81 dots/mm (147.45 dots/inch)
		qml: dimensions: 360x592
		qml: logical pixel density: 2.83 dots/mm (72.00 dots/inch)
		qml: device pixel ratio: 3.00
		// Nexus 7 (1280 x 800)
		qml: pixel density: 6.31 dots/mm (160.16 dots/inch)
		qml: dimensions: 601x905
		qml: logical pixel density: 2.83 dots/mm (72.00 dots/inch)
		qml: device pixel ratio: 1.33
		// iphone 6s simulator
		qml: pixel density: 6.42 dots/mm (163.00 dots/inch)
		qml: dimensions: 375x667
		qml: logical pixel density: 2.83 dots/mm (72.00 dots/inch)
		qml: device pixel ratio: 2.00
	*/

	//
	// Background.
	//

	Image {
		width: parent.width; height: parent.height
		source: "qrc:///images/background.jpg"
	}

	//
	// Header.
	//

	header: Rectangle {
		id: _header
		width: _applicationWindow.width; height: _title.height * 1.2
		gradient: Gradient {
			GradientStop { position: 0.0; color: "#000" }
			GradientStop { position: 1.0; color: "#4c4c4c" }
		}

		RowLayout {
			spacing: 20
			anchors.fill: parent

			ToolButton {
				label: Image {
					anchors.centerIn: parent
					source: "qrc:///images/update.png"
				}

				onClicked: {
					httpRequest()
				}
			}

			Text {
				id: _title
				color: "#357ec7"
				font {
					pointSize: 36
				}
				text: "SWeather"
				horizontalAlignment: Qt.AlignHCenter
				verticalAlignment: Qt.AlignVCenter
				Layout.fillWidth: true
			}

			ToolButton {
				label: Image {
					anchors.centerIn: parent
					source: "qrc:///images/menu.png"
				}
				onClicked: optionsMenu.open()

				Menu {
					id: optionsMenu
					x: parent.width - width
					transformOrigin: Menu.TopRight

					MenuItem {
						text: "Settings"
						onTriggered: settingsPopup.open()
					}
					MenuItem {
						text: "About"
						//onTriggered: aboutDialog.open()
					}
				}
			}
		}
	}

	CurrentWeatherWidget {
		id: _currWeatherWgt
		width: parent.width; height: parent.height * 0.52
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

	SettingsPopup {
		id: settingsPopup
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
		//console.log(response)
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
		//console.log(request)
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
