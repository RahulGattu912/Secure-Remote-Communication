<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*, org.apache.commons.io.IOUtils, aes.ed.AES256"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Encryption</title>
        <style>
            *{
                margin: 0;
                padding: 0;
                outline: none;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }
            body{
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                padding: 10px;
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);
            }
            table {
                width: 100%;
                margin-left:auto;
                margin-right:auto;
                margin-top:auto;
                margin-bottom:auto;
            }
            th, td {
                width: 100px;
                text-align: center;
                padding: 5px;
            }
            tr {
                height: 40px;
            }
        </style>
        <script>
            function triggerExample() {
                const element = document.querySelector('#id1');
                element.select();
                element.setSelectionRange(0, 99999);
                document.execCommand('copy');
            }
        </script>
    </head>
    <body>
        <%
    // Parameters from the form
    String secretKey = request.getParameter("key");
    String email = request.getParameter("email");
    String encryptedString="";
    // Check if a file was uploaded
    Part filePart = request.getPart("file"); // Assuming your file input field name is "file"

    if (filePart != null && filePart.getSize() > 0) {
        // Get the file name
        String fileName = filePart.getSubmittedFileName();

        // Get the input stream of the uploaded file
        InputStream fileContentStream = filePart.getInputStream();

        // Read contents of the uploaded file
        byte[] fileBytes = IOUtils.toByteArray(fileContentStream);

        // Encrypt the file contents
        encryptedString = AES256.encrypt(new String(fileBytes, "UTF-8"), secretKey, "MySalt");

        %>
        <table>
            <tr>
                <td>
                    <textarea id="id1" rows="10" cols="50"><%= encryptedString %></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <form action="mailto:<%= email %>" method="post" enctype="text/plain">
                            <!-- <input type="hidden" name="subject" value="Encrypted Text">-->
                            <input type="hidden" name="Text:" value="<%= encryptedString %>">
                            <input type="submit" value="Send">
                        </form>
                    </div>
                </td>
            </tr>
        </table>
        <%
    } else {
        // Handle if no file was uploaded
        out.println("No file uploaded!");
    }
%>
        <table>
            <tr>
                <td>
                    <textarea id="id1" rows="10" cols="50"><%= encryptedString %></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <form action="mailto:<%= email %>" method="post" enctype="text/plain">
                           <!-- <input type="hidden" name="subject" value="Encrypted Text">-->
                            <input type="hidden" name="Text:" value=" <%= encryptedString %>">
                            <input type="submit" value="Send">
                        </form>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>
