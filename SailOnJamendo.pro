# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = SailOnJamendo

CONFIG += sailfishapp
PKGCONFIG += sailfishapp

QT += multimedia

SOURCES += src/SailOnJamendo.cpp

OTHER_FILES += qml/SailOnJamendo.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/SailOnJamendo.changes.in \
    rpm/SailOnJamendo.spec \
    rpm/SailOnJamendo.yaml \
    SailOnJamendo.desktop \
    qml/js/jamlib.js \
    qml/pages/JamRadios.qml \
    qml/pages/JamFeed.qml \
    qml/pages/JamPlayer.qml \
    qml/pages/JamSearch.qml \
    qml/pages/JamAlbum.qml \
    qml/pages/JamArtist.qml \
    qml/pages/JamSearchResults.qml \
    qml/pages/JamDelegateArtist.qml \
    qml/pages/JamDelegateAlbum.qml \
    qml/pages/JamDelegateTrack.qml \
    qml/images/icon-m-toolbar-mediacontrol-next.svg \
    qml/images/icon.svg \
    SailOnJamendo.png \
    qml/js/jamconfig.js \
    .gitignore \
    README.md

icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps

INSTALLS += desktop icon

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n


