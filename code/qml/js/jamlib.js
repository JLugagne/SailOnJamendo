.pragma library

Qt.include("jamconfig.js")
Qt.include("jamdb.js")

var jamModel = Qt.createQmlObject('import QtQuick 2.0; import "../pages/models"; Item { \
    property alias playlist: _playlist; \
    property int position: 0; \
    property int buffering: 0; \
    property bool pause: false; \
    JamModelPlaylist { \
        id: _playlist; \
    } \
}', Qt.application, 'JamModel');

function getData(module, action, args, callback)
{
    var xhr = new XMLHttpRequest();
    var requestUrl = jamApiBase+"/"+module+"/"+action+"?client_id="+jamAppId+"&format=jsonpretty&"+args;
    console.log(requestUrl)
    xhr.open('get', requestUrl);

    // Track the state changes of the request.
    xhr.onreadystatechange = function () {
        var DONE = 4; // readyState 4 means the request is done.
        var OK = 200; // status 200 is a successful return.
        if (xhr.readyState === DONE) {
            if (xhr.status === OK) {
                callback(xhr.responseText);
            } else {
                console.log("error");
            }
        }
    };

    // Send the request to send-ajax-data.php
    xhr.send(null);
}

function zeroFill( number, width )
{
  width -= number.toString().length;
  if ( width > 0 )
  {
    return new Array( width + (/\./.test( number ) ? 2 : 1) ).join( '0' ) + number;
  }
  return number + ""; // always return a string
}

function timeToString(sec) {
    var time = parseInt(sec);
    return zeroFill(parseInt(time/60), 2)+":"+zeroFill(parseInt(time%60), 2)
}
