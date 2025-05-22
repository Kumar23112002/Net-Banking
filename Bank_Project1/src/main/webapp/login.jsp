<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #d9f99d, #a5f3fc);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      width: 90%;
      max-width: 350px;
      padding: 35px;
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
      transition: transform 0.3s ease-in-out;
    }

    .container:hover {
      transform: translateY(-5px);
    }

    h2 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 20px;
    }

    label {
      font-size: 14px;
      color: #555;
      display: block;
      margin-top: 10px;
    }

    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-top: 6px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }

    input[type="submit"] {
      width: 100%;
      padding: 10px;
      background-color: #f97316;
      border: none;
      color: white;
      font-weight: bold;
      border-radius: 6px;
      cursor: pointer;
      margin-top: 20px;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #3b82f6;
    }

    .error-message {
      color: red;
      text-align: center;
      margin-bottom: 12px;
      font-size: 14px;
    }

    a {
      display: block;
      text-align: right;
      font-size: 13px;
      color: #007bff;
      text-decoration: none;
      margin-top: 5px;
    }

    a:hover {
      text-decoration: underline;
    }

    @media (max-width: 400px) {
      .container {
        padding: 25px 20px;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Login</h2>

    <h3 class="error-message">
      <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
    </h3>

    <form action="adminLogin" method="post">
      <label for="username">Username:</label>
      <input type="text" id="username" name="username" placeholder="Enter username" required>

      <label for="password">Password:</label>
      <input type="password" id="password" name="password" placeholder="Enter password" required>

      <a href="forgotpassword.jsp">Forgot password?</a>

      <input type="submit" value="Login">
    </form>
  </div>
</body>
</html>
