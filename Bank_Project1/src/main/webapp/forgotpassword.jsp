<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
 <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(120deg, #f0f4f8, #d9e2ec);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .container {
      background: white;
      padding: 40px 50px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 400px;
      box-sizing: border-box;
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      margin-bottom: 8px;
      color: #555;
      font-weight: 500;
    }

    input[type="email"] {
      padding: 10px 12px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 16px;
    }

    input[type="submit"],
    input[type="reset"] {
      padding: 12px;
      margin-top: 5px;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      color: white;
      background-color: #3498db;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    input[type="reset"] {
      background-color: #e74c3c;
    }

    input[type="submit"]:hover {
      background-color: #2980b9;
      transform: scale(1.03);
    }

    input[type="reset"]:hover {
      background-color: #c0392b;
      transform: scale(1.03);
    }

    .message {
      margin-top: 20px;
      text-align: center;
      font-size: 14px;
      color: green;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Forgot Password</h2>

    <form action="sendotp" method="post">
      <label for="email">Enter Email:</label>
      <input type="email" name="email" id="email" required>

      <input type="submit" value="Send OTP">
      <input type="reset" value="Clear">
    </form>

    <p class="message">
      <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </p>
  </div>
</body>
</html>