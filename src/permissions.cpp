#include "permissions.h"

Permissions::Permissions(QObject *parent)
    : QObject{parent}
{

}

void Permissions::requestExternalStoragePermission(){
#ifdef Q_OS_ANDROID
    // Result of the request for WRITE_EXTERNAL_STORAGE
    QtAndroid::PermissionResult requestResultWrite;
    // Result of the request for READ_EXTERNAL_STORAGE
    QtAndroid::PermissionResult requestResultRead;
    // Assuming that no permission has been granted
    this->m_permissionResult = false;

    // String list with the permissions to request
    // Forming the string list with the permissions to request
    QStringList permissionsToRequest;
    permissionsToRequest << "android.permission.WRITE_EXTERNAL_STORAGE";
    permissionsToRequest << "android.permission.READ_EXTERNAL_STORAGE";

    requestResultWrite = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
    requestResultRead = QtAndroid::checkPermission("android.permission.READ_EXTERNAL_STORAGE");
    if ((requestResultWrite == QtAndroid::PermissionResult::Denied) ||
            (requestResultRead == QtAndroid::PermissionResult::Denied)){

        QtAndroid::requestPermissionsSync(permissionsToRequest);
        requestResultWrite = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        requestResultRead = QtAndroid::checkPermission("android.permission.READ_EXTERNAL_STORAGE");

        if ((requestResultWrite == QtAndroid::PermissionResult::Denied) ||
                (requestResultRead == QtAndroid::PermissionResult::Denied)) {
            this->m_permissionResult = false;
            if (QtAndroid::shouldShowRequestPermissionRationale("android.permission.WRITE_EXTERNAL_STORAGE") ||
                    QtAndroid::shouldShowRequestPermissionRationale("android.permission.READ_EXTERNAL_STORAGE")) {
                AndroidPermissions = QAndroidJniObject("io/github/zanyxdev/epong/ShowPermissionRationale",
                                                       "(Landroid/app/Activity;)V",
                                                       QtAndroid::androidActivity().object<jobject>()
                                                       );

                // Checking for errors in the JNI
                QAndroidJniEnvironment env;
                if (env->ExceptionCheck()) {
                    env->ExceptionDescribe();
                    env->ExceptionClear();
                }
            }
        }
        else { this->m_permissionResult = true; }
    }
    else { this->m_permissionResult = true; }
#else
    m_permissionResult =true;
#endif
}

bool Permissions::getPermissionResult() const{
    return m_permissionResult;
}
