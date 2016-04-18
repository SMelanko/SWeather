import QtQuick 2.6

Rectangle {
	id: _rect
	color: "#dcdcdc"
	radius: 3

	ListView {
		id: _list
		anchors.fill: parent
		clip: true
		focus: true

/*
		header: Rectangle {
			width: parent.width
			height: 30
			gradient: Gradient {
				GradientStop { position: 0; color: "black" }
				GradientStop { position: 0.85; color: "gray" }
			}
			radius: 3
			Text {
				anchors.centerIn: parent
				color: "white"
				text: "Header"
				font {
					bold: true
					pointSize: 20
				}
			}
		}
		headerPositioning: ListView.OverlayHeader
*/
/*
		highlight: Rectangle {
			width: parent.width
			color: "lightgray"
			radius: 3
		}
		highlightMoveDuration: 200
		highlightMoveVelocity: 200
*/
		model: WeatherListModel{}

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

		onCurrentIndexChanged: {
			console.log("onCurrentIndexChanged: " + currentIndex);
		}
	}
}
