#include <QtCore/QCoreApplication>

#include <QtCore/QTranslator>
#include <QtGui/QGuiApplication>

#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#else
#include <QtGui/QScreen>
#endif

#ifdef QT_DEBUG
#include <QtCore/QDirIterator>
#include <QtCore/QLoggingCategory>
#endif

#include "hal.h"




int main(int argc, char *argv[]) {

    // Allocate [Hal] before the engine to ensure that it outlives it !!
    QScopedPointer<Hal> m_hal(new Hal);
    m_hal->createAppFolder();
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QCoreApplication::setOrganizationName("ZanyXDev");
    QCoreApplication::setApplicationName(PACKAGE_NAME_STR);
    QGuiApplication app(argc, argv);

    /**
     * @brief myappTranslator
     */
    /// TODO add translations
    //    QTranslator myappTranslator;
    //    myappTranslator.load(QLocale(),
    //                         QLatin1String("ePong"),
    //                         QLatin1String("_"),
    //                         QLatin1String(":/i18n"));
    //    app.installTranslator(&myappTranslator);

#ifdef Q_OS_ANDROID
    QtAndroid::hideSplashScreen();
#endif

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/res/qml");


#ifndef Q_OS_ANDROID
    QScreen *screen = qApp->primaryScreen();
    m_hal->setDotsPerInch( screen->physicalDotsPerInch() );
    m_hal->setDevicePixelRatio( screen->devicePixelRatio() );
#endif

#ifdef QT_DEBUG
    m_hal->setDebugMode(true);
    QLoggingCategory::setFilterRules(QStringLiteral("qt.qml.binding.removal.info=true"));
#endif

    QQmlContext *context = engine.rootContext();
    context->setContextProperty("mm",m_hal->getDevicePixelRatio() / 25.4);
    context->setContextProperty("pt", 1);
    context->setContextProperty("AppVersion",VERSION_STR);
    context->setContextProperty("isDebugMode", m_hal->getDebugMode() );

#ifdef Q_OS_ANDROID
    context->setContextProperty("isMobile",true);
#else
    context->setContextProperty("isMobile",false);
#endif

    context->setContextProperty("DevicePixelRatio", m_hal->getDevicePixelRatio());

    const QUrl url(QStringLiteral("qrc:/res/qml/main.qml"));
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](const QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);

    // Register the singleton type provider with QML by calling this
    // function in an initialization function.
    qmlRegisterSingletonInstance("io.github.zanyxdev.epong.hal", 1, 0,
                                 "HAL", m_hal.get()
                                 );

    engine.load(url);

    return app.exec();
}
