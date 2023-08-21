!versionAtLeast(QT_VERSION, 5.15.0):error("Requires Qt version 5.15.0 or greater.")

TEMPLATE +=app
TARGET = ePong

QT       += core qml quick quickcontrols2 multimedia svg

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17
CONFIG += resources_big
CONFIG(release,debug|release):CONFIG += qtquickcompiler # Qt Quick compiler
CONFIG += add_ext_res_task # Add extra res to target
CONFIG(release,debug|release):CONFIG += add_source_task # Add source.zip to target
CONFIG(debug,debug|release):CONFIG += qml_debug  # Add qml_debug

DEFINES += VERSION_STR=\\\"$$cat(version.txt)\\\"
DEFINES += PACKAGE_NAME_STR=\\\"$$cat(package_name.txt)\\\"

DEFINES += QT_DEPRECATED_WARNINGS

# QT_NO_CAST_FROM_ASCII QT_NO_CAST_TO_ASCII
#don't use precompiled headers https://www.kdab.com/beware-of-qt-module-wide-includes/

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
    src/hal.h \
        src/permissions.h

SOURCES += \
            src/main.cpp \
        src/hal.cpp \
                src/permissions.cpp

RESOURCES += \
        images.qrc \
        qml.qrc \
        js.qrc \
        fonts.qrc

OTHER_FILES += ext_res.qrc

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD/res/qml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/res/qml
QML2_IMPORT_PATH = $$PWD/res/qml

add_source_task{
#https://raymii.org/s/blog/Existing_GPL_software_for_sale.html
    message("add source.zip")
    #system(cd $$PWD; cd ../;rm source.zip; zip -r source.zip .)
    #RESOURCES += source.qrc
}

add_ext_res_task{
    message("create extra RESOURCES binary file")
    system($$PWD/tools/ci/create_ext_res.sh $$[QT_INSTALL_PREFIX])
}

android {
    QT += androidextras

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    disable-xcb {
        message("The disable-xcb option has been deprecated. Please use disable-desktop instead.")
        CONFIG += disable-desktop
    }

    OTHER_FILES += \
        android/AndroidManifest.xml \
        android/build.gradle \
        android/gradle.properties \
        android/gradlew \
        android/gradlew.bat \
        android/gradle/wrapper/gradle-wrapper.jar \
        android/gradle/wrapper/gradle-wrapper.properties \
        android/res/values/libs.xml \
         android/res/values/strings.xml \
        android/src/io/github/zanyxdev/epong/ShowPermissionRationale.java

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
 #       ANDROID_EXTRA_LIBS = \
 #          $$PWD/android/3rdparty/openssl/armeabi-v7a/libcrypto_1_1.so \
 #         $$PWD/android/3rdparty/openssl/armeabi-v7a/libssl_1_1.so
 }
contains(ANDROID_TARGET_ARCH,arm64-v8a) {
        #ANDROID_EXTRA_LIBS = \
        #    $$PWD/android/3rdparty/openssl/arm64-v8a/libcrypto_1_1.so \
        #    $$PWD/android/3rdparty/openssl/arm64-v8a/libssl_1_1.so
 }
}

DISTFILES += \
    android/local.properties \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-xhdpi/icon.png \
    android/res/drawable-xxhdpi/icon.png \
    android/res/drawable-xxxhdpi/icon.png \
    android/src/io/github/zanyxdev/epong/UIDialogFragment.java

SUBDIRS += \
    android/proguard-rules.pro

