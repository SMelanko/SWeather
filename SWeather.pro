TEMPLATE = app
TARGET = SWeather
QT += qml quick

CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

ios {
	QMAKE_INFO_PLIST = ios/Info.plist

	ios_icon.files = $$files($$PWD/ios/logo*.png)
	QMAKE_BUNDLE_DATA += ios_icon
}

# Default rules for deployment.
include(deployment.pri)
