# SailOnJamendo

All informations about the Jamendo's API is there : https://developer.jamendo.com/v3.0

* Setting the API key
    As the API key is private for each applications, I put it in the file qml/js/jamconfig.js and this file is private. The content of the file is something like that :

    <<<
    .pragma library

    var jamAppId = "<key id>";
    var jamApiBase = "https://api.jamendo.com/v3.0";
    >>>

    If you just want to try it, you can use the public key (0a7472b2) and generate your own later.

