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

    try {

        URL url = new URL("http://localhost:8080/RESTfulExample/json/product/get");
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
    
    if(feedResult!=null) {
        feeds = feedResult.getFeeds();
        Feeds latestFeed = feeds.get(0);
        if(latestFeed.getField1()<=10) {
            dispatchTruck = true;
            session.setAttribute("dispatchTruck",dispatchTruck);
        }
    }
    
    

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Water level status</h1>
        <table>
            <tr>
                <th>Water Level</th>
                <th>Time</th>
            </tr>
            <%
            for(Feeds feed: feeds) {%>
            <tr>
                <td><%=feed.getField1()%></td>
                <td><%=feed.getCreated_at()%></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
