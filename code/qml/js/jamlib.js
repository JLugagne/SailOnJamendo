.pragma library

Qt.include("jamconfig.js")
Qt.include("jamdb.js")

var jamModel = Qt.createQmlObject('import QtQuick 2.0; import QtMultimedia 5.0; QtObject { \
    id: jamModelIntern
    property variant radios: []; \
    property variant feeds: []; \
    property variant search: []; \
    property variant playlist: []; \
    property variant selectedFeed: []; \
    property variant album; \
    property variant artist; \
    property string searchIn; \
    property string searchFor; \
    property variant stream:{
                                "url":"", \
                                "image":"../images/icon.svg", \
                                "artist":"", \
                                "name":"", \
                                "album":"", \
                                "duration":""\
                            }; \
    property int playingId: -1; \
    property bool pause: false; \
    property bool hasNext: playingId != -1 && playingId != playlist.length-1
    property int playlistCount: jamModelIntern.playlist.length
    property variant shuffle: []; \
    property bool repeat: false; \
    onPlaylistChanged: { playingId = -1; if(playlist.length > 0) { playingId = 0; pause = false; } \ }
    onPlayingIdChanged: if(playingId < 0) { \
                            stream.url = ""; \
                        } else if(playlist.length > 0) { \
                            var id = playingId; \
                            if(jamModelIntern.playlistCount != 0 && jamModelIntern.shuffle.length == jamModelIntern.playlistCount){ \
                                id = jamModelIntern.shuffle[playingId]; \
                            } \
                            stream = playlist[id]; \
                        } \
    function setShuffle() { \
        var o = []; \
        var i; \
        for(i = 0; i < jamModelIntern.playlistCount; i++) o.push(i); \
        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x); \
        jamModelIntern.shuffle = o; \
    } \
    function nextTrack() \
    { \
        if(playingId != playlist.length-1) \
            playingId++; \
        else if(jamModelIntern.repeat) \
            playingId = 0; \
    } \
    function previousTrack() \
    { \
        if(playingId > 0) \
            playingId--; \
        else if(jamModelIntern.repeat) \
            playingId = playlist.length-1; \
    } \
}', Qt.application, 'JamModel');

var jamPlaying = Qt.createQmlObject('import QtQuick 2.0; import QtMultimedia 5.0; QtObject { \
    property int duration: 0; \
    property int position: 0; \
    property int buffering: 0; \
    property int albumId: 0; \
    property string image: "../images/icon.svg"; \
    property string album: ""; \
    property string artist: ""; \
}', Qt.application, 'JamPlaying');

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

function cbListRadios(data)
{
    var res = JSON.parse(data);
    jamModel.radios = res["results"];

}

function cbPlayRadio(data)
{
    var res = JSON.parse(data);
    var stream = res["results"][0]["stream"];
    var image = res["results"][0]["image"];
    var name = res["results"][0]["dispname"];
    jamModel.playlist = [{
                             "url":stream,
                             "image":image,
                             "artist":"radios",
                             "name":name,
                             "album":"radios",
                             "duration":0
                         }];
}

function cbFeeds(data)
{
    var res = JSON.parse(data);
    jamModel.feeds = res["results"];
}

function cbSelectedFeed(data)
{
    var res = JSON.parse(data);
    jamModel.selectedFeed = res["results"][0];
}

function cbSearchResults(data)
{
    var res = JSON.parse(data);
    jamModel.search = res["results"];
    if(jamModel.search.length == 0){
        jamModel.search = [{"name": "Nothing found"}];
    }
}

function cbAlbumsList(data)
{
    var res = JSON.parse(data);
    jamModel.search = res["results"][0]["albums"];
}

function cbAlbum(data)
{
    var res = JSON.parse(data);
    jamModel.album = res["results"][0];
}

function cbArtist(data)
{
    var res = JSON.parse(data);
    jamModel.artist = res["results"][0];
}

function updateListRadios()
{
    var module = "radios";
    var action = "";
    var args = "limit=all&order=dispname&type=www";
    getData(module, action, args, cbListRadios);
}

function updatePlayRadio(name)
{
    var module = "radios";
    var action = "stream";
    var args = "name="+name;
    getData(module, action, args, cbPlayRadio);
}

function updateFeeds()
{
    var module = "feeds";
    var action = "";
    var args = "target=all&order=date_end_desc&limit=10&lang=en&type=album";
    getData(module, action, args, cbFeeds);
}

function getFeed(id)
{
    var module = "feeds";
    var action = "";
    var args = "id="+id;
    getData(module, action, args, cbSelectedFeed);
}

function getSearchFor(search, searchIn, offset)
{
    //if(offset == 0) jamModel.search = [];
    jamModel.searchIn = searchIn;
    jamModel.searchFor = search;
    var module = searchIn;
    var action = "";
    var args = "limit=30&namesearch="+search+"&offset="+offset;
    getData(module, action, args, cbSearchResults);
}

function getAlbum(id)
{
    var module = "albums";
    var action = "tracks";
    var args = "id="+id;
    jamPlaying.albumId = id;
    getData(module, action, args, cbAlbum);
}

function getArtist(artistId)
{
    var module = "artists";
    var action = "tracks";
    var args = "order=track_id_asc&id="+artistId;
    getData(module, action, args, cbArtist);
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
