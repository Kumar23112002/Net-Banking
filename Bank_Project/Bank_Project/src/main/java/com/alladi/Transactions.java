package com.alladi;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/transactions")
public class Transactions extends HttpServlet {

	private static final String driver = "com.mysql.cj.jdbc.Driver";
	private static final String url = "jdbc:mysql://localhost:3306/praveen";
	private static final String userName = "root";
	private static final String password = "root";
	private Connection con = null;
	private Statement stmt = null;

	public void init(ServletConfig config) throws ServletException {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userName, password);
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		try {
			String uemail = (String) request.getSession(false).getAttribute("admin");

			if (uemail == null) {
				out.println("Session expired. Please login again.");
				return;
			}

			PreparedStatement ps = con.prepareStatement("SELECT accountno FROM account WHERE uemail = ?");
			ps.setString(1, uemail);
			ResultSet accountRs = ps.executeQuery();

			int accountNumber = -1;
			if (accountRs.next()) {
				accountNumber = accountRs.getInt("accountno");
			} else {
				out.println("Account not found for user: " + uemail);
				return;
			}

			PreparedStatement transactionStmt = con
					.prepareStatement("SELECT * FROM transactions WHERE sender_id = ? OR receiver_id = ?");
			transactionStmt.setInt(1, accountNumber);
			transactionStmt.setInt(2, accountNumber);
			ResultSet rs = transactionStmt.executeQuery();

			out.println("<h1>My Transactions</h1>");
			out.println("<table border='1'>");
			out.println(
					"<tr><th>Transaction Id</th><th>Sender Account No</th><th>Receiver Account No</th><th>Amount</th><th>Transaction Time</th></tr>");

			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + rs.getInt("transaction_id") + "</td>");
				out.println("<td>" + rs.getInt("sender_id") + "</td>");
				out.println("<td>" + rs.getInt("receiver_id") + "</td>");
				out.println("<td>" + rs.getDouble("amount") + "</td>");
				out.println("<td>" + rs.getTimestamp("transaction_time") + "</td>");
				out.println("</tr>");
			}

			out.println("</table>");

		} catch (SQLException e) {
			e.printStackTrace();
			out.println("Database Error!");
		}
	}
}