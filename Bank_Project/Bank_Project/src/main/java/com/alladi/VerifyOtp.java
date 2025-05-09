package com.alladi;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verifyotp")
public class VerifyOtp extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession hs = request.getSession();
		String userOtp = request.getParameter("otp");
		int actualOtp = (int) hs.getAttribute("otp");
		
		Long otpTime = (Long) hs.getAttribute("otpTime");
		long currentTime = System.currentTimeMillis();
		
		
		if (otpTime == null || (currentTime - otpTime) > 60000) {
			request.setAttribute("error", "OTP expired. Please request a new one.");
			RequestDispatcher rd = request.getRequestDispatcher("verifyotp.jsp");
			rd.forward(request, response);
			return;
		}
		
		if(String.valueOf(actualOtp).equals(userOtp)) {
			response.sendRedirect("resetpassword.jsp");
		}
		else {
			request.setAttribute("error", "Invalid OTP");
			RequestDispatcher rd = request.getRequestDispatcher("verifyotp.jsp");
			rd.forward(request, response);
		}
	}

}
