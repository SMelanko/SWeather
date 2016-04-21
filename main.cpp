#include <QtGlobal>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
	QGuiApplication::setApplicationName("SWeather");
	QGuiApplication::setOrganizationName("Slava Melanko");
	QGuiApplication::setApplicationVersion("1.0.0");
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);

	qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "true");
	qputenv("QT_LABS_CONTROLS_STYLE", "Material");

	QQmlApplicationEngine engine;
	engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
	if (engine.rootObjects().isEmpty()) {
		return -1;
	}

	return app.exec();
}
