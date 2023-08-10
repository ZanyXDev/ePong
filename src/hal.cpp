#include "hal.h"

Hal::Hal(QObject *parent)
    : QObject{parent}
    , m_uptime("")
    , m_dpr(1)
    , m_debugMode(false)
    , m_physicalDotsPerInch(0)
    , m_devicePixelRatio(0)
{

}

void Hal::updateInfo(){

}

double Hal::getDevicePixelRatio() const{
    int density = 0;
#ifdef Q_OS_ANDROID
    QAndroidJniEnvironment env;

    //  BUG with dpi on some androids: https://bugreports.qt-project.org/browse/QTBUG-35701
    QAndroidJniObject qtActivity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        return EXIT_FAILURE;
    }

    QAndroidJniObject resources = qtActivity.callObjectMethod("getResources", "()Landroid/content/res/Resources;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        return EXIT_FAILURE;
    }

    QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics", "()Landroid/util/DisplayMetrics;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
        return EXIT_FAILURE;
    }

    density = displayMetrics.getField<int>("densityDpi");
#else
    density = m_physicalDotsPerInch * m_devicePixelRatio;
#endif

#ifdef QT_DEBUG
    density = 240;
#endif
    return   density >= 480 ? 3 :
                              density >= 320 ? 2 :
                                               density >= 240 ? 1.5 : 1;
}

void Hal::setDebugMode(bool newDebugmode){
    if (m_debugmode == newDebugmode)
        return;
    m_debugmode = newDebugmode;
    emit debugModeChanged();
}

/*!
 * \brief Make docs encourage readers to query locale right
 * \sa https://codereview.qt-project.org/c/qt/qtdoc/+/297560
 */
void Hal::createAppFolder(){
    ///TODO check permissions
    QDir dirAppConfig( QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation) );
    if (dirAppConfig.exists() == false) {
        dirAppConfig.mkpath(dirAppConfig.path());
    }
    QDir dirAppData( QStandardPaths::writableLocation(QStandardPaths::AppDataLocation ) );
    if (dirAppData.exists() == false) {
        dirAppData.mkpath(dirAppData.path());
    }
}
