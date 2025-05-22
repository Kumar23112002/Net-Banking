package com.alladi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addBeneficiary")
public class AddBeneficiaryServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int accountId = Integer.parseInt(request.getParameter("account_id"));
		int beneficiaryId = Integer.parseInt(request.getParameter("beneficiary_id"));
		String name = request.getParameter("name");

		try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root")) {
			String sql = "INSERT INTO beneficiaries (accountno, beneficiary_account_no,name) VALUES (?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, accountId);
			stmt.setInt(2, beneficiaryId);
			stmt.setString(3, name);
			int rows = stmt.executeUpdate();
			response.getWriter().println(rows > 0 ? "Beneficiary added" : "Error adding beneficiary.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
