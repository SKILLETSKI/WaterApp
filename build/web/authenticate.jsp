<%-- 
    Document   : login
    Created on : Mar 18, 2016, 6:46:21 AM
    Author     : muhammadims.2013
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String username = request.getParameter("username");
String password = request.getParameter("password");
if(username.equals("resident") && password.equals("resident")){
    session.setAttribute("user","resident");
    response.sendRedirect("resident.jsp");
} else if (username.equals("djb") && password.equals("djb")) {
    session.setAttribute("user","djb");
    response.sendRedirect("djb.jsp");
} else {
    request.setAttribute("error","Invalid username or password.");
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
