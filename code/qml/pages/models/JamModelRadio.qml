import QtQuick 2.0
import Sailfish.Silica 1.0

import "../../js/jamlib.js" as JamModel

Item {
    property alias radios: _radios
    property bool loaded: false

    property int toLoad: 0;

    ListModel {
        id: _radios
    }

    function getRadios()
    {
        var module = "radios";
        var action = "";
        var args = "order=dispname&type=www";
        JamModel.getData(module, action, args, parseRadios);
    }

    function parseRadio(data){
        var res = JSON.parse(data);
        var results = res["results"];
        if(results.length > 0){
            var it = results[0];
            _radios.append({"_radioName": it.dispname, "_radioImage": it.image, "_radioStream": it.stream});
            loaded = (toLoad-- == 0);
        }
    }

    function parseRadios(data)
    {
        var res = JSON.parse(data);
        var results = res["results"];
        var i = 0;
        var module = "radios";
        var action = "stream";
        var args = "id=";
        toLoad = results.length-1;
        for(i = 0; i < results.length; i++) {
            var it = results[i];
            JamModel.getData(module, action, args+it.id, parseRadio);
        }
    }
}
