import QtQuick 2.5
import QtQuick.Dialogs 1.2
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

import "HttpRequest.js" as HttpRequest

ApplicationWindow {
	id: _applicationWindow
	width: 640; height: 480
	title: qsTr("SWeather")
	visible: true

	//
	// Property interface.
	//
	property string apiKey: '6f75ff20ca01b304bb986d7019d05adc'
	property string cityId: '706483' // Kharkiv, Ukraine.
	property string units: 'metric'
	property string fontFamily: "Open Sans"
	property int fontSize: 18

	//
	// Signals interface.
	//
	signal responseFailed(int status, string msg)
	signal responseReceived(string response)

	//
	// Title.
	//
	Rectangle {
		id: _banner
		width: parent.width; height: _title.height * 1.4
		anchors.top: parent.top
		gradient: Gradient {
				GradientStop { position: 0.0; color: "black" }
				GradientStop { position: 1.0; color: "#4c4c4c" }
		}

		Text {
			id: _title
			anchors.centerIn: parent
			color: "#5caa15"
			font {
				family: fontFamily
				pointSize: fontSize * 2
			}
			text: "SWeather"
		}
	}

	CurrentWeatherWidget {
		id: _currWeatherWgt
		anchors {
			left: parent.left
			top: _banner.bottom
			right: parent.right
			bottom: parent.verticalCenter
		}
	}

	WeatherListView {
		id: _listView
		anchors {
			left: parent.left
			leftMargin: 5
			top: _currWeatherWgt.bottom
			topMargin: 5
			right: parent.right
			rightMargin: 5
			bottom: parent.bottom
			bottomMargin: 5
		}
	}

	Button {
		id: _btn
		x: 5; y: 5
		width: 150; height: _banner.height - 10
		text: qsTr("Update")

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
		//console.log(response)
		var data = JSON.parse(response)
		var location = data.city.name + ', ' + data.city.country

		_currWeatherWgt.setCurrWeatherParams(location, data.list[0])

		for (var j = 1; j < 9; ++j) {
			_listView.addRow(data.list[j])
			/*
			console.log(data.list[j].dt_txt)
			console.log("       Main: " + data.list[j].weather[0].main)
			console.log("Description: " + data.list[j].weather[0].description)
			console.log("       Icon: " + data.list[j].weather[0].icon)
			console.log("     Clouds: " + data.list[j].clouds.all)
			console.log("Temperature: " + data.list[j].main.temp)
			console.log("   Pressure: " + data.list[j].main.pressure)
			console.log("       Wind: " + data.list[j].wind.speed)
			*/
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
