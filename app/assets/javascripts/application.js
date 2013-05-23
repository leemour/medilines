// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function initMap() {
	var map = new YMaps.Map(document.getElementById("ya-maps"));
    map.setCenter(new YMaps.GeoPoint(30.484438, 59.922266), 14);
    map.addControl(new YMaps.TypeControl([
                   YMaps.MapType.MAP,
                   YMaps.MapType.HYBRID]));
    map.addControl(new YMaps.ToolBar());
    map.addControl(new YMaps.Zoom());
    //map.addControl(new YMaps.MiniMap());
    map.addControl(new YMaps.ScaleLine());
    var location = new YMaps.Placemark(new YMaps.GeoPoint(30.495253, 59.92442));
    location.name = "Медилайн Сервис";
    //object.description = "";
    //object.setIconContent("");
    map.addOverlay(location);
    YMaps.Styles.add("constructor#33CC00c85Polyline", {
        lineStyle : {
            strokeColor : "33CC00c8",
            strokeWidth : 5
        }
    });
    YMaps.Styles.add("constructor#66C7FFc85Polyline", {
        lineStyle : {
            strokeColor : "66C7FFc8",
            strokeWidth : 5
        }
    });        
    //map.addOverlay(createObject("Polyline", [new YMaps.GeoPoint(30.318593,59.916615),new YMaps.GeoPoint(30.322282,59.917914),new YMaps.GeoPoint(30.322969,59.917225)], "constructor#33CC00c85Polyline", "от метро Технологический Институт"));
    //map.addOverlay(createObject("Polyline", [new YMaps.GeoPoint(30.329687,59.920698),new YMaps.GeoPoint(30.32222,59.918026),new YMaps.GeoPoint(30.323121,59.917186)], "constructor#66C7FFc85Polyline", "от метро Пушкинская"));
    location.openBalloon("<div style='font-size:150%'>"+location.name+"</div>",{hasCloseButton:true, maxWidth:200});

    /*
    function createObject (type, point, style, description) {
        var allowObjects = ["Placemark", "Polyline", "Polygon"],
            index = YMaps.jQuery.inArray( type, allowObjects),
            constructor = allowObjects[(index == -1) ? 0 : index];
            description = description || "";
        
        var object = new YMaps[constructor](point, {style: style, hasBalloon : !!description});
        object.description = description;
        
        return object;
    }
    */
}
