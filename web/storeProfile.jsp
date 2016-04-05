
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

        <!-- Like script -->
        <script type="text/javascript">
        // Like and Unlike function
            function likeProduct(url)
            {

                loadXMLDoc(url, function()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {

                        var json = eval('(' + xmlhttp.responseText + ')');
                        var noOfLikes = json.noOfLikes;
                        var store_id = json.store_id;
                        var product_sn = json.product_sn;
                        var id = store_id + product_sn;
                        var likeBtnIDSel = "#" + store_id + product_sn + "likeBtn";
                        var likeIconIDSel = "#" + store_id + product_sn + "likeIcon";
                        //var iconColor = document.getElementById(likeBtnID).getAttribute("color");
                        var iconColor = $(likeIconIDSel).css("color");
                        if (iconColor === "rgb(255, 0, 0)") {
                            $(likeIconIDSel).css("color", "rgb(42, 100, 150)");
                            $(likeBtnIDSel).attr("title", "Like");
                        } else {
                            $(likeIconIDSel).css("color", "rgb(255, 0, 0)");
                            $(likeBtnIDSel).attr("title", "Unlike");
                        }

                        //var likeBtnVal = $(likeBtnID).text();
                        //if(likeBtnVal==="Like"){

                        //document.getElementById(likeBtnIDValue).innerHTML="Unlike";
                        //}else{
                        //document.getElementById(likeBtnIDValue).innerHTML="Like";
                        //}
                        document.getElementById(id).innerHTML = "(" + noOfLikes + ")";
                    }
                });
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

        
        <header><!--/header-->

  

            <div class="header-bottom"><!--header-bottom-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="mainmenu pull-left">
                                <ul class="nav navbar-nav collapse navbar-collapse">
                                    <li><a href="home.jsp">Home</a></li>
                                    <li><a href="promotion.jsp">Promotion</a>       
                                    <li><a href="aboutUs.jsp">About Us</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6">

                            <form id="searchForm" action="./searchController.do" method="post">
                                <div class="input-group">
                                    <div class="input-group-btn search-panel">
                                        <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown" style="height:35px;margin-top:0px">
                                            <span id="search_concept">Product</span>
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a href="#store">Store</a></li>
                                        </ul>
                                    </div>
                                    <input type="hidden" name="search_param" value="Product" id="search_param">
                                    <div class="search_box ui-widget" style="width:330 !important">
                                        <input id="text" type="text" class="form-control" name="search_input" placeholder="Search" onkeyup="auto()"/>
                                    </div>
                                    <span class="input-group-btn">
                                        <button class="btn btn-default dropdown-toggle usa" type="button"  style="height:35px;margin-top:0px" onclick="submit()"><span><i class="fa fa-search"></i></span></button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div><!--/header-bottom-->
        </header><!--/header-->

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

                        <div class="col-sm-3">
                            <h2>JDB</h2>
                            <address>
                                <strong>North</strong><br>
                                address:123<br>
                            </address>
                            <br>
                            <%-- <%
                            if(s==null){
                                            String currentStorePage = "./storeProfile.jsp?store_id=" + storeId;
                                            String followID = storeId + "followID";
                                            String followIconID = storeId + "followIcon";
                                            if(username==null){
                                    %>		
                                                    <a id="<%=followID %>" onclick="location.href='./login.jsp?currentPage=<%=currentStorePage %>'" class="btn btn-default add-to-cart">Follow this Store</a>
                                                    <br>
                                                    <p style="font-size:12px;margin-top:-10px"> <font id="<%=followIconID %>"><%=store.getNoOfFollow()%></font>&nbsp;followers</p>
                                                    
                                            <%
                                            }else{ 
                                                            if(FollowManager.retrieveFollow_By_Username_Store(username, storeId)==0){
                                    
                                            %>
                                                    <a id="<%=followID %>" onclick="followStore('./followController.do?store_id=<%=storeId%>')" class="btn btn-default add-to-cart">Follow this store</a>
                                                    <br>
                                                    <p style="font-size:12px;margin-top:-10px"> <font id="<%=followIconID %>"><%=store.getNoOfFollow()%></font>&nbsp;followers
                                                    </p>
                                                            <%}else{ %>
                                                    <a id="<%=followID %>" onclick="followStore('./followController.do?store_id=<%=storeId%>')" class="btn btn-default add-to-cart">Unfollow this store</a>
                                                    <br>
                                                    <p style="font-size:12px;margin-top:-10px"> <font id="<%=followIconID %>"><%=store.getNoOfFollow()%></font>&nbsp;followers
                                                    </p>
                                                            <%} %>
                                    <%
                                            } 
                                    }
                                    %>
                                    
                    <br> --%>
                            <%-- <div class="fb-share-button" data-href="<%=currentPageMeta %>" data-width="100px" data-layout="button_count"></div>
                            <div id="fb-root"></div> --%>
                        </div>

                    </div>
                </div> <!-- END OF COL SM 10 -->
            </div> <!-- END OF PRODUCT ROW -->
        </div><!-- END OF CONTAINER -->

        <br>
        <br>	

   
    </body>
</html>
