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

@WebServlet("/updatepassword")
public class UpdatePassword extends HttpServlet {

	private static final String Driver = "com.mysql.cj.jdbc.Driver";
	private static final String url = "jdbc:mysql://localhost:3306/praveen";
	private static final String username = "root";
	private static final String password = "root";

	private Connection con;
	private PreparedStatement ps;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String newPassword = request.getParameter("newpassword");

		String connewPassword = request.getParameter("conpassword");

		String email = (String) request.getSession().getAttribute("email");

		try {

			Class.forName(Driver);
			con = DriverManager.getConnection(url, username, password);

			if (newPassword.equals(connewPassword)) {
				PreparedStatement ps = con.prepareStatement("UPDATE registration SET password=?, conpassword=? WHERE uemail=?");
				ps.setString(1, newPassword);
				ps.setString(2, connewPassword);
				ps.setString(3, email);

				int rows = ps.executeUpdate();

				if (rows > 0) {
					response.sendRedirect("updatepassword.jsp");
				} else {
					response.getWriter().write("Password update failed. User not found.");
				}

			}

		} catch (Exception e) {
			throw new ServletException("Error initializing servlet: " + e.getMessage(), e);
		}
	}

}
