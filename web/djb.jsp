<%-- 
    Document   : djb
    Created on : Mar 18, 2016, 7:21:19 AM
    Author     : muhammadims.2013
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% if(session.getAttribute("user")==null) {
    request.setAttribute("error","Unauthorized access");
    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
    dispatcher.forward(request,response);
} else if (!session.getAttribute("user").equals("djb")) {
    request.setAttribute("error","Unauthorized access");
    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
    dispatcher.forward(request,response);
}%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
