<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
   String email = request.getParameter("email");
   String pass = request.getParameter("password");
   String str1 = "rahulgattu912@gmail.com";
   String str2 = "password";
   if (email.equals(str1) && pass.equals(str2)) {
        response.sendRedirect("userPage.html");
   } else {
%>
        <script>
            alert("Incorrect Credentials");
            window.location.href = "login.html"; 
        </script>
<%
    }
%>
