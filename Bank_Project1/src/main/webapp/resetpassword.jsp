<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>
<style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #ece9e6, #ffffff);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      background-color: #fff;
      padding: 40px 50px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 450px;
      box-sizing: border-box;
    }

    h2 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 30px;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      font-weight: 500;
      margin-bottom: 6px;
      color: #34495e;
    }

    input[type="password"] {
      padding: 10px 12px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 16px;
    }

    input[type="submit"] {
      padding: 12px;
      font-size: 16px;
      font-weight: bold;
      color: #fff;
      background-color: #27ae60;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    input[type="submit"]:hover {
      background-color: #219150;
      transform: scale(1.03);
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>&#128272; Reset Password</h2>
    
    <form action="updatepassword" method="post">
      <label for="newpassword">Enter New Password:</label>
      <input type="password" id="newpassword" name="newpassword" required>

      <label for="conpassword">Confirm Password:</label>
      <input type="password" id="conpassword" name="conpassword" required>

      <input type="submit" value="Update Password">
    </form>
  </div>

</body>
</html>