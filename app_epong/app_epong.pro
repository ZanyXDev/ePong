!versionAtLeast(QT_VERSION, 5.15.0):error("Requires Qt version 5.15.0 or greater.")

TEMPLATE +=app
TARGET = ePong

QT       += core gui qml quick quickcontrols2 multimedia

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

LANGUAGE  = C++


CONFIG += c++17 resources_big
CONFIG(release,debug|release):CONFIG += qtquickcompiler # Qt Quick compiler
CONFIG(release,debug|release):CONFIG += add_source_task # Add source.zip to target
CONFIG(debug,debug|release):CONFIG += qml_debug  # Add qml_debug

#include(gitversion.pri)

DEFINES += QT_DEPRECATED_WARNINGS

# QT_NO_CAST_FROM_ASCII QT_NO_CAST_TO_ASCII
#don't use precompiled headers https://www.kdab.com/beware-of-qt-module-wide-includes/

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/main.cpp

RESOURCES += \
        images.qrc \
        qml.qrc \
        js.qrc \
        ../shared/quick_shared.qrc \
        ../shared/fonts.qrc

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =  ../shared

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = ../shared

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

add_source_task{
#https://raymii.org/s/blog/Existing_GPL_software_for_sale.html
    message("add source.zip")
    system(cd $$PWD; cd ../;rm source.zip; zip -r source.zip .)
    RESOURCES += source.qrc
}
