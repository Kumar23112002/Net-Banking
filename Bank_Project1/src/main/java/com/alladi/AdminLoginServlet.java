package com.alladi;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String adminUsername = request.getParameter("username");
        String adminPassword = request.getParameter("password");

        
        String query = "SELECT * FROM registration WHERE uemail = ? AND password = ?";
        try 
        {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root");	        
            PreparedStatement stmt = conn.prepareStatement(query);
                        
            stmt.setString(1, adminUsername);
            stmt.setString(2, adminPassword);
            

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) 
            {
               	String role = rs.getString("role");
               	String uname=rs.getString("uemail");
               	String pass=rs.getString("password");
               	String status=rs.getString("status");
            	HttpSession session = request.getSession();
                session.setAttribute("admin", adminUsername); 
                session.setAttribute("role", role);
                if ("admin".equalsIgnoreCase(role)) 
                {
                    response.sendRedirect(request.getContextPath() + "/approve");
                } 
                else if ("user".equalsIgnoreCase(role)&&uname.equals(adminUsername)&&pass.equals(adminPassword)&&"approved".equals(status)) 
                {
                    response.sendRedirect(request.getContextPath() + "/userdashboard.jsp");
                }
                              
            } 
            else 
            {
                request.setAttribute("errorMessage", "Invalid username or password.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp"); 
                dispatcher.forward(request, response);
            }

        }
        catch(Exception e)
        {
        	e.printStackTrace();
        }
    }
}