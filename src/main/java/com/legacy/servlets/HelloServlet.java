// File: src/com/legacy/servlets/HelloServlet.java
package com.legacy.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HelloServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Direct HTML output from servlet (legacy practice)
            out.println("<html>");
            out.println("<head><title>Red Hat Sample Legacy Servlet Example</title></head>");
            out.println("<body>");

            // Hard-coded message (better served by JSP or template engines)
            String message = "Hello TMX! from the legacy Servlet!";
            out.println("<h1>" + message + "</h1>");

            // Manual parameter handling without validation (security issue)
            String user = request.getParameter("user");
            out.println("<p>User provided: " + user + "</p>");

            // Legacy approach: session usage without proper validation
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            // Deprecated timestamp usage in servlet (modern approach uses JSTL or frameworks)
            out.println("<p>Timestamp: " + new java.util.Date().toLocaleString() + "</p>");

            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            out.println("<pre>");
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            out.println(sw.toString());
            out.println("</pre>");
        }
    }
}