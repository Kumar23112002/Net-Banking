package com.alladi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyTpinServlet")
public class VerifyTpinServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tpin = request.getParameter("tpin");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Session expired.");
            return;
        }

        String username = (String) session.getAttribute("admin");
        boolean valid = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root");
            PreparedStatement ps = conn.prepareStatement("SELECT tpin FROM account WHERE uemail = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String correctTpin = rs.getString("tpin");
//                System.out.println("User input TPIN: " + tpin);
//                System.out.println("Database TPIN: " + correctTpin);

                if (correctTpin != null && correctTpin.trim().equals(tpin.trim())) {
                    valid = true;
                }
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("text/plain");
        response.getWriter().write(valid ? "success" : "fail");
    }
}
