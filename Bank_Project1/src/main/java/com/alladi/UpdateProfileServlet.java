package com.alladi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String updateType = request.getParameter("updateType");
        String username = (String) request.getSession().getAttribute("admin");
        String newField = request.getParameter("newField");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root");

            if ("mobile".equals(updateType)) {
                PreparedStatement ps = conn.prepareStatement("UPDATE registration SET mobileno = ? WHERE uemail = ?");
                ps.setString(1, newField);
                ps.setString(2, username);
                ps.executeUpdate();
            } else if ("address".equals(updateType)) {
                PreparedStatement ps = conn.prepareStatement("UPDATE registration SET address = ? WHERE uemail = ?");
                ps.setString(1, newField);
                ps.setString(2, username);
                ps.executeUpdate();
            }

            conn.close();
            response.sendRedirect("userdashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
