<%@ Page Title="Map" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="MiTasksWAA.Map" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">




 <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <style>

    </style>

    <a href="javascript:addTent();" class="btn btn-primary">Add Med Tent</a>
    <label>Display Event</label>
    <asp:DropDownList ID ="ddlevents" onchange="loadEvent();" runat="server"></asp:DropDownList>
    <div id="map" style="width:100%;height:1000px;margin-left:-20px;"></div>
    <script>

        // initialize Leaflet
        var map = L.map('map').setView({ lon: 0, lat: 0 }, 2);

        // add the OpenStreetMap tiles
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap contributors</a>'
        }).addTo(map);

        // show the scale bar on the lower left corner
        L.control.scale({ imperial: true, metric: true }).addTo(map);

        // show a marker on the map
        L.marker({ lon: 0, lat: 0 }).bindPopup('The center of the world').addTo(map);

        var path;

        function loadEvent() {
            var arForm = jQuery("#frmcms").serializeArray();
            arForm.push({ 'name': 'mapeventid', 'value': jQuery('#ddlevents').val() });
            jQuery.ajax({
                type: "POST",
                url: "/Map.aspx/wmLoadEvent",
                data: JSON.stringify({ formVars: arForm }),
                contentType: "application/json",
                dataType: "json",
                success: function (msg) {
                    //populateform(msg.d);
                    var latsArr = msg.d.lats.split(',');
                    var longsArr = msg.d.longs.split(',');
                    var latlongs = []
                    for (var i = 0; i < latsArr.length; i++) {
                        latlongs.push([latsArr[i], longsArr[i]]);
                    }

                    try {
                        map.removeLayer(path);
                    }
                    catch {

                    }

                    var tentlatsArr = msg.d.tentslat.split(',');
                    var tentlongsArr = msg.d.tentslong.split(',');
                    for (var j = 0; j < tentlatsArr.length; j++) {
                        L.marker({ lon: tentlongsArr[j], lat: tentlatsArr[j] }).bindPopup('Med Tent').addTo(map);
                    }
                    

                    path = L.polyline(latlongs, { "delay": 400, "weight": 5, "color": "red", "paused": true, "reverse": false }).addTo(map);
                    map.addLayer(path);
                    map.fitBounds(path.getBounds());
                }
            });
        }

        function addTent() {
                    $('#tentModal').modal('show');
        }

        function addTentFinal() {
            var longitude = jQuery('#txtlongitude').val();
            var latitude = jQuery('#txtlatitude').val();
            L.marker({ lon: longitude, lat: latitude }).bindPopup('Med Tent').addTo(map);
            $('#tentModal').modal('hide');
        }
    </script>
    <div class="modal" tabindex="-1" id="tentModal" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Tent</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="txtlatitude">Latitude</label>
                    <input type="text" class="form-control" id="txtlatitude">
                    <label for="txtlongitude">Longitude</label>
                    <input type="text" class="form-control" id="txtlongitude">
                </div>
                <div class="modal-footer">
                    <a id="a_addtent" href="javascript:addTentFinal();" class="btn btn-primary">Add Tent</a>
                    <a class="btn btn-secondary" data-dismiss="modal">Close</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
