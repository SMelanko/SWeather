import QtQuick 2.5
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0

Popup {
	id: settingsPopup
	width: Math.min(_applicationWindow.width, _applicationWindow.height) / 3 * 2.5
	height: _settingsColumn.implicitHeight + topPadding + bottomPadding
	x: (_applicationWindow.width - width) / 2
	y: _applicationWindow.height / 6
	focus: true
	modal: true
	closePolicy: Popup.OnEscape | Popup.OnPressOutside

	contentItem: ColumnLayout {
		id: _settingsColumn
		spacing: 10

		Label {
			text: "Settings"
			font.bold: true
		}

		RowLayout {
			spacing: 10

			Label {
				text: "Option:"
			}

			ComboBox {
				id: _optionBox
				model: ["Option 1", "Option 2", "Option 3"]
				Layout.fillWidth: true
			}
		}

		GroupBox {
			title: "Title"
			Layout.fillWidth: true

			Column {
				spacing: 10

				RadioButton {
					text: "First"
					checked: true
				}
				RadioButton {
					text: "Second"
				}
				RadioButton {
					text: "Third"
				}
			}
		}

		RowLayout {
			spacing: 10

			Button {
				id: _okButton
				text: "Ok"
				onClicked: {
					settingsPopup.close()
				}
				Layout.fillWidth: true
			}

			Button {
				id: _cancelButton
				text: "Cancel"
				onClicked: {
					settingsPopup.close()
				}
				Layout.fillWidth: true
			}
		}
	}
}
