import QtQuick 2.6

Rectangle {
	id: _rect
	color: "#dcdcdc"
	radius: 3
	border {
		width: 1
		color: "green"
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
			width: _rect.width; height: 64
			Row {
				leftPadding: 10
				spacing: 20
				anchors.verticalCenter: parent.verticalCenter
				Text {
					font.pointSize: 20
					text: time
					verticalAlignment: Text.AlignVCenter
				}
				Image {
					width: 32; height: 32
					source: icon
					smooth: true
				}
				Row {
					Text { text: "Temperature, °C: "; font.pointSize: 16 }
					Text { text: temperature; font.pointSize: 16 }
				}
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

		_listModel.append({
			time: dt.toTimeString(),
			temperature: data.main.temp,
			icon: "qrc:///images/list/moon@2x.png"
		})
	}
}
