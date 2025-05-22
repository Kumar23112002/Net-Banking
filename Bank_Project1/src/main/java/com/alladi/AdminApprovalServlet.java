package com.alladi;

import java.io.IOException;
import java.util.*;
import java.sql.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/approve")
public class AdminApprovalServlet extends HttpServlet 
{
	
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
	        String query = "SELECT id, firstname, lastname, uemail FROM registration WHERE status = 'pending'";
	        List<Map<String, String>> pendingUsers = new ArrayList<>();

	        try 
	        {
	        	Class.forName("com.mysql.cj.jdbc.Driver");
	        	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root");	        
	             Statement stmt = conn.createStatement();
	             ResultSet rs = stmt.executeQuery(query);

	            while (rs.next())
	            {
	                Map<String, String> user = new HashMap<>();
	                user.put("id", rs.getString("id"));
	                user.put("firstname", rs.getString("firstname"));
	                user.put("lastname", rs.getString("lastname"));
	                user.put("uemail", rs.getString("uemail"));
	                pendingUsers.add(user);
	            }
	        } 
	        catch (Exception e) 
	        {
	            System.out.println(e);
			}

	       
	        request.setAttribute("pendingUsers", pendingUsers);

	       
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin_dashboard.jsp");
	        dispatcher.forward(request, response);
	    }


	   
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String userId = request.getParameter("id");
	        String action = request.getParameter("action");  

	        if ("approve".equals(action)) {
	            updateUserStatus(userId, "approved");
	        } else if ("reject".equals(action)) {
	            updateUserStatus(userId, "rejected");
	        }

	        System.out.println("Redirecting to /approve");
	        response.sendRedirect(request.getContextPath() + "/approve");
	        System.out.println("Redirect statement executed");
	    }

	    private void updateUserStatus(String userId, String status) 
	    {
	        String query = "UPDATE registration SET status = ? WHERE id = ?";
	        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root");
	             PreparedStatement stmt = conn.prepareStatement(query)) 
	        {

	            stmt.setString(1, status);
	            stmt.setString(2, userId);

	            stmt.executeUpdate();
	        }
	        catch (SQLException e) 
	        {
	            e.printStackTrace();
	        }
	    }
	}



