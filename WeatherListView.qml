import QtQuick 2.6

import "Utils.js" as Utils

Rectangle {
	id: _listViewRect
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

	ListModel {
		id: _listModel
	}

	ListView {
		id: _listView
		anchors.fill: parent
		clip: true
		focus: true

		model: _listModel

		delegate: Item {
			id: _delegate
			width: _listViewRect.width; height: _listViewRect.height / 5
			Row {
				id: _delegateRow
				anchors.fill: parent
				anchors.verticalCenter: parent.verticalCenter

				Text {
					width: parent.width / 4; height: _delegateRow.height
					font {
						pixelSize: _delegate.height / 2
					}
					text: time
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
				}

				Text {
					width: parent.width / 4; height: _delegateRow.height
					font {
						pixelSize: _delegate.height / 3
					}
					text: date
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
				}

				Rectangle {
					width: parent.width / 4; height: _delegate.height
					color: "transparent"
					Image {
						anchors.centerIn: parent
						fillMode: Image.PreserveAspectFit
						source: icon
					}
				}

				Text {
					width: parent.width / 4; height: _delegateRow.height
					font {
						pixelSize: _delegate.height / 2
					}
					text: temperature
					verticalAlignment: Text.AlignVCenter
					horizontalAlignment: Text.AlignHCenter
				}
			}

			Rectangle {
				anchors {
					left: parent.left
					bottom: parent.bottom
				}
				width: parent.width; height: 1
				color: "#adadad"
			}
		}

		add: Transition {
			NumberAnimation {
				properties: "y"
				from: height
				duration: 500
			}
			NumberAnimation {
				property: "opacity"
				from: 0; to: 1.0
				duration: 500
			}
		}
	}

	//
	// JS implementation.
	//

	//! Appends new row with weather information.
	// @1 - json object of the weather's parameters for corresponding time.
	function addRow(data)
	{
		var dt = new Date()
		dt.setTime(Date.parse(data.dt_txt))
		var hh = dt.getHours().toString()
		if (hh.length == 1) {
			hh = '0' + hh
		}

		_listModel.append({
			time: hh + ':00',
			date: dt.getDate() + ', ' + Utils.getMonthNameFromDate(dt),
			icon: 'qrc:///images/list/' +
				Utils.getWeatherIcon(data.weather[0].icon) + '.png',
			temperature: '' + Math.round(data.main.temp) + '°'
		})
	}
}
