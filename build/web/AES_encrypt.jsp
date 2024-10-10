<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="aes.ed.AES256"%>
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
            String secretKey = request.getParameter("key");
            String salt = "MySalt";
  
            // String to be encrypted
            String originalString = request.getParameter("plainText");
            // Encrypt the string
            String encryptedString = AES256.encrypt(originalString, secretKey, salt);
            String email=request.getParameter("email");
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
