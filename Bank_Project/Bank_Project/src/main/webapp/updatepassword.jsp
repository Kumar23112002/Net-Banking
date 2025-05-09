<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Password Successfully</title>
<style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #e0f8e9, #c3f0d7);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      background-color: #ffffff;
      padding: 40px 60px;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      text-align: center;
      max-width: 500px;
      width: 90%;
    }

    h1 {
      color: #2e7d32;
      margin-bottom: 30px;
      font-size: 28px;
    }

    a {
      display: inline-block;
      margin-top: 15px;
      padding: 12px 25px;
      font-size: 16px;
      background-color: #2e7d32;
      color: white;
      text-decoration: none;
      border-radius: 8px;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    a:hover {
      background-color: #1b5e20;
      transform: scale(1.05);
    }

    .emoji {
      font-size: 60px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

  <div class="container">
    <div class="emoji">✅</div>
    <h1>Your password has been reset successfully!</h1>
    <a href="login.jsp">Go to Login Page</a>
  </div>

</body>
</html>