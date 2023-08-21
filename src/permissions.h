#pragma once

#include <QObject>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif
class Permissions : public QObject
{
    Q_OBJECT
public:
    explicit Permissions(QObject *parent = nullptr);
    /*!
     * \brief Requesting external storage read and write permission
     * This is a synchronous call so the application will not execute
     * until after the user denies or grants the permission.
     * \sa https://developer.android.com/training/permissions/requesting.html
     */
    void requestExternalStoragePermission();

    // Method to get the permission granted state
    bool getPermissionResult() const;

private:
    // Variable indicating if the permission to read / write has been granted
    bool m_permissionResult;

#if defined(Q_OS_ANDROID)
    // Object used to obtain permissions on Android Marshmallow and above
    QAndroidJniObject AndroidPermissions;
#endif
};
