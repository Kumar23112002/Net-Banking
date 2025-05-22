package com.alladi;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sendotp")
public class SendOtp extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String email = request.getParameter("email");
		int otp = new Random().nextInt(9000)+1000;
		
		String to = email;		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		Session s = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("vkpraveen216@gmail.com", "jnebkoxisnciurpw");
																								
			}
		});
		// compose message
		try {
			MimeMessage message = new MimeMessage(s);
			message.setFrom(new InternetAddress(email));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject("My Bank of India");
			message.setText("Welcome to My Bank of India your OTP for registartion is " + otp+" Thank you Registering");
			// send message
			Transport.send(message);
			System.out.println("message sent successfully");
		}catch (MessagingException e) {
			throw new RuntimeException(e);
		}



		HttpSession session = request.getSession();
		session.setAttribute("email", email);
		session.setAttribute("otp", otp);
		session.setAttribute("otpTime", System.currentTimeMillis());
		System.out.println(otp);
		
		request.setAttribute("message","OTP sent to your email.");
		RequestDispatcher rd = request.getRequestDispatcher("verifyotp.jsp");
		rd.forward(request, response);
		
		
	}

}
