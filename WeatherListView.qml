import QtQuick 2.6

import "Utils.js" as Utils

Rectangle {
	id: _listViewRect
	color: "transparent"

	// Set background.
	Rectangle {
		anchors.fill: parent
		color: "#d7d7d7"
		opacity: 0.3
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
				anchors.verticalCenter: parent.verticalCenter
				leftPadding: 10
				spacing: 25

				Text {
					height: _delegateRow.height
					font {
						pixelSize: _delegate.height / 2
					}
					text: time
					verticalAlignment: Text.AlignVCenter
				}

				Text {
					height: _delegateRow.height
					font {
						pixelSize: _delegate.height / 3
					}
					text: date
					verticalAlignment: Text.AlignTop
				}

				Image {
					fillMode: Image.PreserveAspectFit
					source: icon
				}

				Row {
					Text {
						height: _delegateRow.height
						font {
							pixelSize: _delegate.height / 2
						}
						text: temperature
						verticalAlignment: Text.AlignVCenter
					}

					Text {
						height: _delegateRow.height
						font {
							pixelSize: _delegate.height / 2
						}
						text: "°"
						verticalAlignment: Text.AlignVCenter
					}
				}
			}

			Rectangle {
				anchors {
					left: parent.left
					bottom: parent.bottom
				}
				width: parent.width; height: 1
				color: "#d7d7d7"
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
			date: dt.getDay() + ', ' + Utils.getMonthNameFromDate(dt),
			icon: 'qrc:///images/list/' +
				Utils.getWeatherIcon(data.weather[0].icon) + '.png',
			temperature: Math.round(data.main.temp)
		})
	}
}
