#pragma once

#include <QObject>
#include <QtCore/QDir>
#include <QtCore/QStandardPaths>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

class Hal : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString uptime READ getUpTime NOTIFY upTimeChanged);
    Q_PROPERTY(double devicePixelRatio READ getDevicePixelRatio NOTIFY devicePixelRatioChanged);
    Q_PROPERTY(bool debugmode READ getDebugMode WRITE setDebugMode NOTIFY debugModeChanged);
public:
    explicit Hal(QObject *parent = nullptr);

    const QString &getUpTime() const { return m_uptime; }
    double getDevicePixelRatio() const;
    bool getDebugMode() const { return m_debugMode; }

    void setDebugMode(bool newDebugmode);
    void setDotsPerInch(qreal m_dpi) { m_physicalDotsPerInch = m_dpi; }
    void setDevicePixelRatio(qreal m_dpr) { m_devicePixelRatio = m_dpr; }
    void createAppFolder();
public slots:
    Q_INVOKABLE void updateInfo();

signals:
    void upTimeChanged();
    void devicePixelRatioChanged();
    void debugModeChanged();

private:
    QString m_uptime;
    double m_dpr; // DevicePixelRatio
    bool m_debugMode;
    bool m_debugmode;
    qreal m_physicalDotsPerInch;
    qreal m_devicePixelRatio;
};

