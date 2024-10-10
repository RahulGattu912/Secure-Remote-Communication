import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import aes.ed.AES256;

@WebServlet("/UploadFile")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // Max file size 10MB
public class UploadFile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String secretKey = request.getParameter("key");
        String email = request.getParameter("email");
        
        // Get the uploaded file part
        Part filePart = request.getPart("file");
        String fileName = extractFileName(filePart);

        // Get the input stream of the uploaded file
        InputStream fileContentStream = filePart.getInputStream();

        // Read contents of the uploaded file
        byte[] fileBytes = fileContentStream.readAllBytes();

        // Encrypt the file contents
        String encryptedString = AES256.encrypt(new String(fileBytes, "UTF-8"), secretKey, "MySalt");

        // Set encrypted string as request attribute
        request.setAttribute("encryptedString", encryptedString);
        request.setAttribute("email", email);
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}

