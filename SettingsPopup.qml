import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0

Popup {
	id: _settingsPopup
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
				text: "Temperature unit:"
			}

			ComboBox {
				id: _optionBox
				model: ["Celsius, °C", "Fahrenheit, °F", "Kelvin, K"]
				Layout.fillWidth: true
			}
		}

		GroupBox {
			title: "Wind speed"
			Layout.fillWidth: true

			Row {
				anchors.centerIn: parent
				spacing: 10

				RadioButton {
					text: "m/s"
					checked: true
				}
				RadioButton {
					text: "km/h"
				}
				RadioButton {
					text: "mph"
				}
			}
		}

		RowLayout {
			spacing: 10

			Button {
				id: _okButton
				text: "Ok"
				onClicked: {
					_settingsPopup.close()
				}
				Layout.fillWidth: true
			}

			Button {
				id: _cancelButton
				text: "Cancel"
				onClicked: {
					_settingsPopup.close()
				}
				Layout.fillWidth: true
			}
		}
	}
}
