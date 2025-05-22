<!DOCTYPE html>
<html>
<head>
  <title>Welcome</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: Arial, sans-serif;
      display: flex;
      flex-direction: column;
    }

    header {
      background-color: #35495e;
      color: #fff;
      padding: 16px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
    }

    nav {
      display: flex;
      flex-wrap: wrap;
    }

    nav a {
      color: #fff;
      text-decoration: none;
      margin: 0 12px 8px 0;
    }

    nav a:hover {
      text-decoration: underline;
    }

    .button-group {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 8px;
    }

    .button-group input[type="button"] {
      cursor: pointer;
      padding: 8px 12px;
      background-color: #ffffff;
      color: #35495e;
      border: none;
      border-radius: 4px;
      font-weight: bold;
    }

    main {
      flex: 1;
      background: url("https://img.freepik.com/premium-vector/online-banking-technology-concept-illustration-bank-electric-circuit-lines-background_387612-43.jpg?semt=ais_hybrid&w=740");
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .content-box {
      background-color: rgba(255, 255, 255, 0.7);
      color: #333;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      max-width: 600px;
      width: 100%;
      text-align: center;
    }

    footer {
      background-color: #222;
      color: #fff;
      text-align: center;
      padding: 10px;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      header {
        flex-direction: column;
        align-items: flex-start;
      }

      .button-group {
        justify-content: flex-start;
        width: 100%;
      }

      nav {
        width: 100%;
        justify-content: flex-start;
        margin-bottom: 8px;
      }

      .content-box {
        padding: 20px;
      }
    }
  </style>
</head>
<body>

  <header>
    <nav>
      <a href="#" onclick="showContent('home')">Home</a>
      <a href="#" onclick="showContent('contact')">Contact</a>
      <a href="#" onclick="showContent('about')">About</a>
    </nav>
    <div class="button-group">
      <a href="reg.html"><input type="button" value="SignUp"></a>
      <a href="login.jsp"><input type="button" value="Login"></a>
    </div>
  </header>

  <main>
    <div id="main-content" class="content-box">
      <h1>Welcome to My Bank</h1>
      <p>Your trusted partner in digital banking.</p>
    </div>
  </main>

  <footer>
    <p>&copy; 2002 My Bank Website. All rights reserved.</p>
  </footer>

  <script>
    function showContent(page) {
      const contentBox = document.getElementById("main-content");

      if (page === "home") {
        contentBox.innerHTML = `
          <h1>Welcome to My Bank</h1>
          <p>Your trusted partner in digital banking.</p>
        `;
      } else if (page === "contact") {
        contentBox.innerHTML = `
          <h1>Contact Us</h1>
          <p>Email: support@mybank.com</p>
          <p>Phone: +1-800-123-4567</p>
        `;
      } else if (page === "about") {
        contentBox.innerHTML = `
          <h1>About Us</h1>
          <p><strong>My Bank</strong> has been a trusted financial partner for individuals and businesses since 2002. We are dedicated to delivering cutting-edge digital banking services with a human touch.</p>
          
          <h2>Our Mission</h2>
          <p>To empower our customers by offering secure, accessible, and innovative financial solutions that simplify their lives.</p>

          <h2>What We Offer</h2>
          <ul style="text-align: left; margin: 0 auto; max-width: 500px;">
            <li>&#10004; Online and Mobile Banking</li>
            <li>&#10004; Savings and Current Accounts</li>
            <li>&#10004; Personal and Business Loans</li>
            <li>&#10004; Investment and Wealth Management</li>
            <li>&#10004; 24/7 Customer Support</li>
          </ul>

          <h2>Our Values</h2>
          <p>We believe in transparency, security, innovation, and putting our customers first — always.</p>

          <p>Join over 2 million satisfied customers who trust My Bank with their financial future.</p>
        `;
      }
    }
  </script>

</body>
</html>
