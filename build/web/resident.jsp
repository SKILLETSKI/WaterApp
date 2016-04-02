<%-- 
    Document   : resident
    Created on : Mar 18, 2016, 7:21:07 AM
    Author     : muhammadims.2013
--%>

<%@page import="java.util.List"%>
<%@page import="water.entity.Feeds"%>
<%@page import="water.entity.FeedResult"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.net.URL" %>

<% if (session.getAttribute("user") == null) {
        request.setAttribute("error", "Unauthorized access");
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    } else if (!session.getAttribute("user").equals("resident")) {
        request.setAttribute("error", "Unauthorized access");
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    Gson gson = new Gson();
    FeedResult feedResult = null;
    double waterLevel = 0;

    try {

        URL url = new URL("https://api.thingspeak.com/channels/96227/feeds.json");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : "
                    + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(
                (conn.getInputStream())));
        
        feedResult = gson.fromJson(br,FeedResult.class);
        
        
        

        /*String output;
        String jsonString = "";
        System.out.println("Output from Server .... \n");
        while ((output = br.readLine()) != null) {
            jsonString+=output;
        }*/

        conn.disconnect();
        
        

    } catch (MalformedURLException e) {

        e.printStackTrace();

    } catch (IOException e) {

        e.printStackTrace();

    }
    
    List<Feeds> feeds = null;
    Boolean dispatchTruck = false;
    Feeds latestFeed = null;
    
    if(feedResult!=null) {
        feeds = feedResult.getFeeds();
        latestFeed = feeds.get(feeds.size()-1);
        waterLevel = Double.parseDouble(latestFeed.getField1());
        if(waterLevel<=0.2) {
            dispatchTruck = true;
            session.setAttribute("dispatchTruck",dispatchTruck);
        }
    }
    
    int waterLevel100 = (int)waterLevel * 100;

%>
<!DOCTYPE html>

<html lang="en">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>Water Level Indicator | </title>

  <!-- Bootstrap core CSS -->

  <link href="css/bootstrap.min.css" rel="stylesheet">

  <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
  <link href="css/animate.min.css" rel="stylesheet">

  <!-- Custom styling plus plugins -->
  <link href="css/custom.css" rel="stylesheet">
  <link href="css/icheck/flat/green.css" rel="stylesheet">

  <link rel="stylesheet" type="text/css" href="css/maps/jquery-jvectormap-2.0.3.css" />

  <script src="js/jquery.min.js"></script>

  <!--[if lt IE 9]>
        <script src="../assets/js/ie8-responsive-file-warning.js"></script>
        <![endif]-->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

</head>


<body class="nav-md">

  <div class="container body">


    <div class="main_container">

      <div class="col-md-3 left_col">
        <div class="left_col scroll-view">

          <div class="navbar nav_title" style="border: 0;">
            <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>Easy Water Supply</span></a>
          </div>
          <div class="clearfix"></div>


          <!-- /menu footer buttons -->
        </div>
      </div>

      <!-- top navigation -->
      <div class="top_nav">
        <div class="nav_menu">
          <nav class="" role="navigation">
            <div class="nav toggle">
              <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>

            <ul class="nav navbar-nav navbar-right">
              <li class="user-profile">
                <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                  <img src="images/img.jpg" alt="">John Doe
                </a>
              </li>
               
          </nav>
        </div>

      </div>
      <!-- /top navigation -->
                  <div class="row">
                    <div class="col-md-6">
                      <div class="panel panel-body" style="margin:10px;width:300px">
                        <div class="x_title" style="text-align:center">
                          <h4>Your Water Level</h4>
                        </div>

                        <div class="row">
                          <div class="col-md-12">
                            <span class="chart" data-percent="<%=waterLevel100%>" style="left:80px">
                                <span class="percent" style="left:83px"></span>
                            </span>
                          </div>          
                          <div class="clearfix"></div>
                        </div>

                      </div>
                    </div>

                  </div>


                </div>
              </div>
            </div>

          </div>
        </div>

        <!-- footer content -->
        <footer>
          <div class="copyright-info">
              <p class="pull-right">Easy Water Suppy System <a href="">United Nation</a>    
            </p>
           
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->

      </div>
      <!-- /page content -->
    </div>

  </div>

  <div id="custom_notifications" class="custom-notifications dsp_none">
    <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
    </ul>
    <div class="clearfix"></div>
    <div id="notif-group" class="tabbed_notifications"></div>
  </div>

  <script src="js/bootstrap.min.js"></script>

  <!-- worldmap -->
  <script type="text/javascript" src="js/maps/jquery-jvectormap-2.0.3.min.js"></script>
  <script type="text/javascript" src="js/maps/gdp-data.js"></script>
  <script type="text/javascript" src="js/maps/jquery-jvectormap-world-mill-en.js"></script>
  <script type="text/javascript" src="js/maps/jquery-jvectormap-us-aea-en.js"></script>

  <!-- chart js -->
  <script src="js/moment/moment.min.js"></script>
  <script src="js/chartjs/chart.min.js"></script>
  <!-- bootstrap progress js -->
  <script src="js/progressbar/bootstrap-progressbar.min.js"></script>
  <script src="js/nicescroll/jquery.nicescroll.min.js"></script>
  <!-- icheck -->
  <script src="js/icheck/icheck.min.js"></script>
  <!-- sparkline -->
  <script src="js/sparkline/jquery.sparkline.min.js"></script>

  <script src="js/custom.js"></script>
  <!-- easypie -->
  <script src="js/easypie/jquery.easypiechart.min.js"></script>
  <!-- pace -->
  <script src="js/pace/pace.min.js"></script>

  <script>
    //@code_start
    $(function() {
      $.getJSON('js/maps/us-unemployment.json', function(data) {
        var val = 2009;
        statesValues = jvm.values.apply({}, jvm.values(data.states)),
          metroPopValues = Array.prototype.concat.apply([], jvm.values(data.metro.population)),
          metroUnemplValues = Array.prototype.concat.apply([], jvm.values(data.metro.unemployment));
        $('#usa_map').vectorMap({
          map: 'us_aea_en',
          markers: data.metro.coords,
          backgroundColor: 'transparent',
          zoomOnScroll: false,
          series: {
            markers: [{
              attribute: 'fill',
              scale: ['#FEE5D9', '#A50F15'],
              values: data.metro.unemployment[val],
              min: jvm.min(metroUnemplValues),
              max: jvm.max(metroUnemplValues)
            }, {
              attribute: 'r',
              scale: [5, 20],
              values: data.metro.population[val],
              min: jvm.min(metroPopValues),
              max: jvm.max(metroPopValues)
            }],
            regions: [{
              scale: ['#E6F2F0', '#149B7E'],
              attribute: 'fill',
              values: data.states[val],
              min: jvm.min(statesValues),
              max: jvm.max(statesValues)
            }]
          },
          onMarkerTipShow: function(event, label, index) {
            label.html(
              '<b>' + data.metro.names[index] + '</b><br/>' +
              '<b>Population: </b>' + data.metro.population[val][index] + '</br>' +
              '<b>Unemployment rate: </b>' + data.metro.unemployment[val][index] + '%'
            );
          },
          onRegionTipShow: function(event, label, code) {
            label.html(
              '<b>' + label.html() + '</b></br>' +
              '<b>Unemployment rate: </b>' + data.states[val][code] + '%'
            );
          }
        });
      });
    });
    //@code_end
  </script>
  <script>
    $(function() {
      $('#world-map-gdp').vectorMap({
        map: 'world_mill_en',
        backgroundColor: 'transparent',
        zoomOnScroll: false,
        series: {
          regions: [{
            values: gdpData,
            scale: ['#E6F2F0', '#149B7E'],
            normalizeFunction: 'polynomial'
          }]
        },
        onRegionTipShow: function(e, el, code) {
          el.html(el.html() + ' (GDP - ' + gdpData[code] + ')');
        }
      });
    });
  </script>

  <script>
    $(function() {
      $('.chart').easyPieChart({
        easing: 'easeOutBounce',
        lineWidth: '6',
        barColor: '#75BCDD',
        onStep: function(from, to, percent) {
          $(this.el).find('.percent').text(Math.round(percent));
        }
      });
      var chart = window.chart = $('.chart').data('easyPieChart');
      $('.js_update').on('click', function() {
        chart.update(Math.random() * 200 - 100);
      });

      //hover and retain popover when on popover content
      var originalLeave = $.fn.popover.Constructor.prototype.leave;
      $.fn.popover.Constructor.prototype.leave = function(obj) {
        var self = obj instanceof this.constructor ?
          obj : $(obj.currentTarget)[this.type](this.getDelegateOptions()).data('bs.' + this.type)
        var container, timeout;

        originalLeave.call(this, obj);

        if (obj.currentTarget) {
          container = $(obj.currentTarget).siblings('.popover')
          timeout = self.timeout;
          container.one('mouseenter', function() {
            //We entered the actual popover – call off the dogs
            clearTimeout(timeout);
            //Let's monitor popover content instead
            container.one('mouseleave', function() {
              $.fn.popover.Constructor.prototype.leave.call(self, self);
            });
          })
        }
      };
      $('body').popover({
        selector: '[data-popover]',
        trigger: 'click hover',
        delay: {
          show: 50,
          hide: 400
        }
      });

    });
  </script>


  <script>
    $('document').ready(function() {
      $(".sparkline_bar").sparkline([2, 4, 3, 4, 5, 4, 5, 4, 3, 4, 5, 6, 4, 5, 6, 3, 5], {
        type: 'bar',
        colorMap: {
          '7': '#a1a1a1'
        },
        barColor: '#26B99A'
      });

      $(".sparkline_area").sparkline([5, 6, 7, 9, 9, 5, 3, 2, 2, 4, 6, 7], {
        type: 'line',
        lineColor: '#26B99A',
        fillColor: '#26B99A',
        spotColor: '#4578a0',
        minSpotColor: '#728fb2',
        maxSpotColor: '#6d93c4',
        highlightSpotColor: '#ef5179',
        highlightLineColor: '#8ba8bf',
        spotRadius: 2.5,
        width: 85
      });

      $(".sparkline_line").sparkline([2, 4, 3, 4, 5, 4, 5, 4, 3, 4, 5, 6, 4, 5, 6, 3, 5], {
        type: 'line',
        lineColor: '#26B99A',
        fillColor: '#ffffff',
        width: 85,
        spotColor: '#34495E',
        minSpotColor: '#34495E'
      });

      $(".sparkline_pie").sparkline([1, 1, 2, 1], {
        type: 'pie',
        sliceColors: ['#26B99A', '#ccc', '#75BCDD', '#D66DE2']
      });

      $(".sparkline_discreet").sparkline([4, 6, 7, 7, 4, 3, 2, 1, 4, 4, 2, 4, 3, 7, 8, 9, 7, 6, 4, 3], {
        type: 'discrete',
        barWidth: 3,
        lineColor: '#26B99A',
        width: '85',
      });

    });
  </script>
</body>

</html>
