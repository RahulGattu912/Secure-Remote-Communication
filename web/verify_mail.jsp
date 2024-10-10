<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Database connection parameters
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String usernameDB = "system";
    String passwordDB = "rahul";

    // Form parameters
    String enteredEmail = request.getParameter("email");
    String enteredPassword = request.getParameter("password");

    // Database query and user verification
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(url, usernameDB, passwordDB);

        String query = "SELECT * FROM user_login WHERE email = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, enteredEmail);

        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            String storedPassword = resultSet.getString("password");
            if (enteredPassword.equals(storedPassword)) {
                // Verification successful
                response.sendRedirect("userPage.html");
            } else {
                // Verification failed - Incorrect password
                %>
                <script>
                    window.alert("Verification Failed! Incorrect password");
                    window.location.href = "login.html";
                </script>
                
                <%
            }
        } else {
            // Verification failed - User not found
            %>
             <script>
                    window.alert("Verification Failed! No user found");
                    window.location.href = "login.html";
                </script>
            <%
        }

        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception e) {
    %>
    <script>
        window.alert("An Error has occured");
        window.location.href = "login.html";
    </script>
    <%
    }
%>
