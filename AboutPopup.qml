import QtQuick 2.5
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

Popup {
	id: _aboutPopup
	width: Math.min(_applicationWindow.width, _applicationWindow.height) / 3 * 2.5
	contentHeight: _aboutColumn.height
	x: (_applicationWindow.width - width) / 2
	y: _applicationWindow.height / 6
	focus: true
	modal: true
	closePolicy: Popup.OnEscape | Popup.OnPressOutside

	ColumnLayout {
		id: _aboutColumn
		width: parent.width
		spacing: 10

		Label {
			text: "About"
			font.bold: true
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			text: "Slava Melanko"
		}

		Image {
			anchors.horizontalCenter: parent.horizontalCenter
			source: "http://s3-eu-west-1.amazonaws.com/qt-files/logos/Qt-logo-small.png"
		}
	}
}
