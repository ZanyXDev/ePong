#pragma once

#include <QObject>
#include <QtCore/QDir>
#include <QtCore/QStandardPaths>
#include <QDebug>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

#include "permissions.h"

class Hal : public QObject
{
    Q_OBJECT
    // Property indicating if the internal storage read / write permission has been granted
    Q_PROPERTY (bool externalStorageAccessGranted
                READ externalStorageAccessGranted
                NOTIFY externalStorageAccessGrantedChanged)

    Q_PROPERTY(double devicePixelRatio
               READ getDevicePixelRatio
               NOTIFY devicePixelRatioChanged);
public:
    explicit Hal(QObject *parent = nullptr);

    double getDevicePixelRatio() const;
    bool getDebugMode() const;
    bool externalStorageAccessGranted() const ;

    void setDebugMode(bool newDebugmode);
    void setDotsPerInch(qreal m_dpi);
    void setDevicePixelRatio(qreal m_dpr);
    void createAppFolder();


public slots:
    Q_INVOKABLE void updateInfo();

signals:
    void upTimeChanged();
    void devicePixelRatioChanged();
    void externalStorageAccessGrantedChanged();

private:
    double m_dpr; // DevicePixelRatio
    qreal m_physicalDotsPerInch;
    qreal m_devicePixelRatio;
    bool m_debugMode;
    bool m_externalStorageAccessGranted;
    Permissions *permissions;       // Object to request permissions from the Andoid
};

