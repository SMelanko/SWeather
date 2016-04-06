import QtQuick 2.5
import QtQuick.Dialogs 1.2
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

import "HttpRequest.js" as HttpRequest

ApplicationWindow {
	id: _applicationWindow
	width: 240; height: 320
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

	Button {
		id: _btn
		width: parent.width / 2; height: parent.height / 4
		anchors.centerIn: parent
		text: qsTr("Test")

		onClicked: {
			var request = makeRequestUrl(cityId, apiKey, units)
			console.log(request)
			getResponse(request)
		}
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

	//
	// Slots implementations.
	//

	onResponseFailed: {
		if (status == 0) {
			_msgBox.informativeText = "No internet connection"
		} else {
			_msgBox.informativeText = status + ': ' + msg
		}

		_msgBox.visible = true
	}

	onResponseReceived: {
		var data = JSON.parse(response)
		var location = data.city.name + ', ' + data.city.country
		console.log(location)
		for (var i = 0; i < 8; ++i) {
			console.log(data.list[i].dt_txt)
			console.log("     Clouds: " + data.list[i].clouds.all)
			console.log("Temperature: " + data.list[i].main.temp)
			console.log("   Pressure: " + data.list[i].main.pressure)
			console.log("       Wind: " + data.list[i].wind.speed)
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
