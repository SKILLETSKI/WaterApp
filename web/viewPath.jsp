
<!DOCTYPE html>
<html>
    <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# easy_mall: http://ogp.me/ns/fb/easy_mall#">
       

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet"
              href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet"
              href="./bootstrap/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet"
              href="./bootstrap/css/flexslider.css">
        <link rel="stylesheet"  
              href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="./bootstrap/css/promotionThumbnail.css">
        <link rel="stylesheet" href="./bootstrap/css/bootstrap-table.css">
        <link href="./bootstrap/css/prettyPhoto.css" rel="stylesheet">
        <link href="./bootstrap/css/price-range.css" rel="stylesheet">
        <link href="./bootstrap/css/animate.css" rel="stylesheet">
        <link href="./bootstrap/css/main.css" rel="stylesheet">
        <link href="./bootstrap/css/responsive.css" rel="stylesheet">   
        <link href="./bootstrap/css/storeProfileBox.css" rel="stylesheet">   

        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
        <script src="./bootstrap/js/bootstrap.min.js"></script>
        <script src="./bootstrap/js/bootstrap-table.js"></script>
        <script src="./bootstrap/js/main.js"></script>
        <script src="./bootstrap/js/html5shiv.js"></script>
        <script src="./bootstrap/js/jquery.prettyPhoto.js"></script>
        <script src="./bootstrap/js/jquery.scrollUp.min.js"></script>
        <script src="./bootstrap/js/price-range.js"></script>
        <script src="http://maps.googleapis.com/maps/api/js?v=3.exp"></script>

        <style>

            .ui-autocomplete {
                max-height: 100px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
            }
            /* IE 6 doesn't support max-height
             * we use height instead, but this forces the menu to always be this tall
             */
            * html .ui-autocomplete {
                height: 100px;
            }

            .text a{
                text-indent:20px;
                padding-top:4px;
                font-size:150%;
                color:#191919;
            }

            .notification a:hover{
                color: #FFBC59 !important
            }

            .search_box .form-control:focus{
                border-color: #cccccc;
                -webkit-box-shadow: none;
                box-shadow: none;
            }


            .carouImage {
                width: 800px;
                height: 400px;
                overflow: hidden;
            }


            @media ( min-width :992px) {
                .desktop-only {
                    display: block !important;
                }
            }

            @media ( max-width : 991px) {
                .mobile-only {
                    display: block !important;
                }
                .desktop-only {
                    display: none !important;
                }
            }

            #map-canvas {
                height: 100%;
                margin: 0px;
                padding: 0px;
            }
            #panel {
                position: absolute;
                top: 5px;
                left: 70%;
                margin-left: -180px;
                z-index: 5;
                background-color: #fff;
                padding: 5px;
                border: 1px solid #999;
            } 

            #directions-panel {
                display:none;
                position: absolute;
                height: 100%;
                float: left;
                background-color: #fff;
                border-style: solid;
                border-width: 1px;
                border-color: silver;
                overflow: auto;
            }

            img {  display: block;width: 100%; }
            .product-image:hover {
                opacity: 0.6;
                -webkit-transition: all 0.4s ease-out;
                -moz-transition: all 0.4s ease-out;  /* FF4+ */
                -o-transition: all 0.4s ease-out;  /* Opera 10.5+ */
                -ms-transition: all 0.4s ease-out;  /* IE10? */
                transition: all 0.4s ease-out;    
            }
        </style>

        <!-- flexslider plug-in -->
        <script type="text/javascript" charset="utf-8">
            $(window).load(function() {
                $('.flexslider').flexslider();
            });
        </script>
        <!-- auto complete -->
        <script>
            var concept = "";
            $(document).ready(function(e) {
                concept = "Product";
                $('.search-panel .dropdown-menu').find('li').click(function(e) {
                    e.preventDefault();
                    concept = $(this).text();
                    if (concept === "Store") {
                        $('.search-panel .dropdown-menu li > a').text("Product");
                    } else {
                        $('.search-panel .dropdown-menu li > a').text("Store");
                    }
                    console.log("The text: " + concept);
                    $('.search-panel span#search_concept').text(concept);
                    $('.input-group #search_param').val(concept);
                });
            });

            function auto() {
                /* var selector = document.getElementById("selector").value; */
                var searchInput = document.getElementById("text").value;
                /* if (selector == "not select"){
                 document.getElementById("text").value = "";
                 $("#text").attr("placeholder","Please Select Product/Stroe!");
                 //document.getElementById("text1").value = "Please Select Product/Stroe!";
                 }else  */
                if (searchInput == null || searchInput == "") {

                } else {
                    $.extend($.ui.autocomplete.prototype, {
                        _renderItem: function(ul, item) {
                            item.label = item.label.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(this.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>");
                            return $("<li></li>")
                                    .data("item.autocomplete", item)
                                    .append("<a>" + item.label + "</a>")
                                    .appendTo(ul);
                        }
                    });
                    $("#text").autocomplete({
                        source: function(request, response) {
                            console.log(concept + "," + searchInput);
                            $.ajax({
                                url: "autoCompleteController.do?type=" + concept + "&search=" + searchInput,
                                type: "POST",
                                dataType: "json",
                                data: {
                                    q: request.term
                                },
                                success: function(data) {

                                    response(data);

                                }
                            });
                        },
                        minLength: 2,
                        open: function() {
                            $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                        },
                        close: function() {
                            $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                        }
                    });
                }
            }
        </script>

  
        <!-- initialize the map -->
        <script>

            function initialize() {
                var homeLatlng = new google.maps.LatLng(28.63006298, 77.16598928);
                var mapOptions = {
                    zoom: 19,
                    center: homeLatlng

                };
                var map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);
                var marker = new google.maps.Marker({
                    position: homeLatlng,
                    map: map,
                    title: "Home Location"
                });
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
        <!-- Calculate the distance -->
        <script>
            function calculateDistance(lat1, lon1, lat2, lon2) {

                var R = 6371; // km
                var dLat = (lat2 - lat1) * Math.PI / 180;
                var dLon = (lon2 - lon1) * Math.PI / 180;
                var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                        Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                        Math.sin(dLon / 2) * Math.sin(dLon / 2);
                var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                var d = R * c;
                return d;
            }
        </script>
        <!-- Google Map -->
        <script>
            var directionsDisplay;
            var directionsService = new google.maps.DirectionsService();
            var JDBlating;
            var storeLatlng;
            var passLating1;
            var passLating2;
            
            function initialize() {
                //if user allows to track his/her location then goole will get user's location from browser
                JDBlating = new google.maps.LatLng(28.6457559,76.8105573);

                var displayPoints = [];

                //path is draggable(only WALKING and DRIVING)
                var rendererOptions = {
                    draggable: true
                };

                directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
        //set store addres        s
                homeLatlng = new google.maps.LatLng(28.550728, 77.2189397);

                displayPoints[0] = JDBlating;
                displayPoints[1] = homeLatlng;

                var mapOptions = {
                    zoom: 13,
                    center:  homeLatlng,
                };

                var map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);

                directionsDisplay.setMap(map);
                directionsDisplay.setPanel(document.getElementById('directions-panel'));
                console.log(displayPoints.length);

                for (var i = 0; i < displayPoints.length; i++) {
                    var point = displayPoints[i];
                    console.log(point);
                    var marker = new google.maps.Marker({
                        position: point,
                        map: map,
                        animation: google.maps.Animation.DROP,
                        title: 'Google Map'
                    });
                    attachMessage(map, marker, i + 1);
                }

            }

            //show some message when user click store address marker
            function attachMessage(map, marker, i) {
                var infowindow = new google.maps.InfoWindow({
                    content: "Product Location",
                });
                google.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map, marker);
                });
            }

            //show the path
            function calcRoute() {
                var selectedMode = document.getElementById('mode').value;
                var request = {
                    origin: JDBlating,
                    destination: homeLatlng,
                    // Note that Javascript allows us to access the constant
                    // using square brackets and a string value as its
                    // "property."
                    travelMode: google.maps.TravelMode[selectedMode],
                    unitSystem: google.maps.UnitSystem.METRIC,
                    optimizeWaypoints: true
                };
                directionsService.route(request, function(response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(response);
                    }
                });
                var path = document.getElementById('directions-panel');
                path.style.display = 'block';
                /* var displaymap = document.get.getElementById("map-canvas"); */
            }

            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
        <!-- AJAX loadXMLDoc -->
        <script type="text/javascript">
        //Create the method to initialize the XMLHttpRequest
            function loadXMLDoc(url, cfunc)
            {
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = cfunc;
                xmlhttp.open("GET", url, true);
                xmlhttp.send();
            }
        </script>

        <meta property="fb:app_id"          content="962390463777722" /> 
        <meta property="og:type"            content="easy_mall:store" /> 
        <meta property="place:location:latitude"  content="28.6457559" /> 
        <meta property="place:location:longitude" content="76.8105573" />
       
       

        

        
    </head>
    <body>
        <!-- The script below give the basic version of the SDK where the options are set to their most common defaults -->
        <script>
            /*
             * This is boilerplate code that is used to initialize
             * the Facebook JS SDK.  You would normally set your
             * App ID in this code.
             */

        // Additional JS functions here
            window.fbAsyncInit = function() {
                FB.init({
                    appId: '962390463777722',
                    cookie: true,
                    xfbml: true,
                    version: 'v2.1'
                });
            };
        //Load the SDK Asynchronously
            (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) {
                    return;
                }
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));

    function postLike        () {
        var store_name = '123';
     
                var fbId = sessionStorage.fbID;
                if (fbId == null || fbId == "") {

                    location.href = "./login.jsp?currentPage=" + currentPage;
                }
                console.log("FB ID: " + fbId);
                // update object content

                FB.api(
                        'https://graph.facebook.com/' + fbId + '/easy_mall:check_in?access_token=962390463777722|KA5F8eAOLiA76vm50p3_Hnjx-aA&fb:explicitly_shared=true',
                        'post',
                        {
                            store: currentURL,
                            place: currentURL,
                            scrape: true,
                            privacy: {'value': 'EVERYONE'}
                        },
                function(response) {

                    if (!response) {
                        alert('Error occurred.');
                    } else if (response.error) {
                        $('#myModal').modal('show');
                        document.getElementById('result').innerHTML =
                                'Error: ' + response.error.message;
                    } else {
                        $('#myModal').modal('show');
                        document.getElementById('result').innerHTML =
                                'You have Successfully checked in ' +
                                store_name;
                    }
                }
                );
            }
        </script>


                    <!-- Store's Location -->
                    <div class="features_items"><!--promotions-->
                        <h2 class="title text-center">Our Location</h2>
                        <div class="col-sm-9">
                            <div id="panel">
                                <b>Mode of Travel: </b> 
                                <select id="mode" onchange="calcRoute();">
                                    <option value="" selected>-- Select a Mode --</option>
                                    <option value="DRIVING">Driving</option>
                                    <option value="WALKING">Walking</option>
                                    <option value="TRANSIT">Transit</option>
                                    <!-- Singapore don't "support BICYCLING" mode -->
                                </select>
                            </div>
                            <table class="col-md-12" style="height:500px;width:100%">
                                <tr>
                                    <td width="35%" id="directions-panel" boder="1"></td>
                                    <td width="65%" id="map-canvas"></td>
                                </tr>
                            </table>
                        </div>


                        </div>

                    </div>
                </div> <!-- END OF COL SM 10 -->
            </div> <!-- END OF PRODUCT ROW -->
        </div><!-- END OF CONTAINER -->

        <br>
        <br>    

   
    </body>
</html>

