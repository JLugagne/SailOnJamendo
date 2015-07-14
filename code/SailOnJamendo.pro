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
TARGET = harbour-sailonjamendo

CONFIG += sailfishapp
PKGCONFIG += sailfishapp

QT += multimedia network

SOURCES += src/SailOnJamendo.cpp \
    src/jamnetwork.cpp

OTHER_FILES += \
    qml/harbour-sailonjamendo.qml \
    qml/pages/JamRadios.qml \
    qml/pages/JamPlayer.qml \
    qml/pages/JamSearch.qml \
    qml/pages/JamAlbum.qml \
    qml/pages/JamArtist.qml \
    qml/pages/delegates/JamDelegateArtist.qml \
    qml/pages/delegates/JamDelegateAlbum.qml \
    qml/pages/delegates/JamDelegateTrack.qml \
    qml/pages/JamFeeds.qml \
    qml/pages/JamFeed.qml \
    qml/pages/JamPlayerUi.qml \
    qml/images/icon-m-toolbar-mediacontrol-next.svg \
    qml/images/icon.svg \
    qml/cover/CoverPage.qml \
    qml/js/jamconfig.js \
    qml/js/jamlib.js \
    .gitignore \
    README.md \
    harbour-sailonjamendo.png \
    harbour-sailonjamendo.desktop \
    rpm/SailOnJamendo.spec \
    rpm/harbour-sailonjamendo.spec \
    rpm/harbour-sailonjamendo.yaml \
    rpm/harbour-sailonjamendo.changes \
    qml/js/jamdb.js \
    qml/pages/JamAbout.qml \
    qml/pages/JamSettings.qml \
    qml/pages/JamPlaylist.qml \
    qml/pages/JamSearchResults.qml \
    qml/pages/delegates/JamDelegateRadio.qml \
    qml/pages/models/JamModelPlaylist.qml \
    qml/pages/models/JamModelRadio.qml \
    qml/pages/models/JamModelSearch.qml \
    qml/pages/models/JamModelArtist.qml \
    qml/pages/models/JamModelAlbum.qml \
    qml/pages/models/JamModelLastPlayed.qml

icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps

INSTALLS += desktop icon

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

HEADERS += \
    src/jamnetwork.h


