<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String usernameDB = "system";
    String passwordDB = "rahul";
    
    String newEmail = request.getParameter("email");
    String newPass = request.getParameter("password");

    // Database query and user registration
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(url, usernameDB, passwordDB);

        // Check if the user already exists
        String checkQuery = "SELECT * FROM user_login WHERE email=?";
        PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
        checkStatement.setString(1, newEmail);
        ResultSet checkResultSet = checkStatement.executeQuery();

        if (checkResultSet.next()) {
            // User already exists
            %>
            <script>
                window.alert("User with this email already exists. Please choose a different email.");
                window.location.href = "sign_up.html";
            </script>
            <%
        } else {
            // User does not exist, proceed with registration
            String insertQuery = "INSERT INTO user_login VALUES(?, ?)";
            PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
            insertStatement.setString(1, newEmail);
            insertStatement.setString(2, newPass);
            int rowsAffected = insertStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Registration successful
        %>
                <script>
                    window.alert("Registration Successful");
                    window.location.href = "login.html";
                </script>
                <%
                response.sendRedirect("login.html");
            } else {
                // Registration failed
                %>
                <script>
                    window.alert("Registration failed. Please try again later.");
                    window.location.href = "sign_up.html";
                </script>
                <%
            }
        }

        checkResultSet.close();
        checkStatement.close();
        connection.close();
    } catch (Exception e) {
     %>
        <script>
            window.alert("An error as occured. Please try again later.");
            window.location.href = "signup.html";
        </script>
        <%
    }
%>
