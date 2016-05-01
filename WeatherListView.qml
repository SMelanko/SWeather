import QtQuick 2.6

import "Utils.js" as Utils

Rectangle {
	id: _rect
	color: "transparent"

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
		id: _list
		anchors.fill: parent
		clip: true
		focus: true

		model: _listModel

		delegate: Item {
			id: _delegate
			width: _rect.width; height: 60
			Row {
				id: _row
				leftPadding: 10
				spacing: 20
				anchors.verticalCenter: parent.verticalCenter

				Text {
					height: _row.height
					font {
						pixelSize: _delegate.height / 2
					}
					text: time
					verticalAlignment: Text.AlignVCenter
				}
				Image {
					width: 32; height: 32
					source: icon
					smooth: true
				}
				Row {
					Text {
						height: _row.height
						font {
							pixelSize: _delegate.height / 2
						}
						text: temperature
						verticalAlignment: Text.AlignVCenter
					}
					Text {
						height: _row.height
						font {
							pixelSize: _delegate.height / 2
						}
						text: "°"
						verticalAlignment: Text.AlignVCenter
					}
				}
				Row {
					Text { text: pressure; font.pointSize: 16 }
					Text { text: " mmHg"; font.pointSize: 16 }
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

			MouseArea {
				anchors.fill: parent;
				onClicked: {
					_list.currentIndex = index
				}
			}
		}

		add: Transition {
			NumberAnimation { properties: "y"; from: height; duration: 500 }
			NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 500 }
			//NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 500 }
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
			time: hh + ":00",
			icon: "qrc:///images/list/" +
				Utils.getWeatherIcon(data.weather[0].icon) + ".png",
			temperature: Math.round(data.main.temp),
			pressure: parseInt(data.main.pressure * 0.75, 10)
		})
	}
}
