<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>
<%@ page session="false"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("admin") == null) {
    response.sendRedirect("welcome.jsp");
    return;
}

String username = (String) session.getAttribute("admin");
String firstName = "";
String lastName = "";
String email = "";
String mobileNo = "";
String address = "";
String role = "";
String status = "";
Double balance = 0.0;
String photoBase64 = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/praveen", "root", "root");

    PreparedStatement ps = conn.prepareStatement(
    "SELECT firstname, lastname, uemail, mobileno, address, photo, role, status FROM registration WHERE uemail = ?");
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        firstName = rs.getString("firstname");
        lastName = rs.getString("lastname");
        email = rs.getString("uemail");
        mobileNo = rs.getString("mobileno");
        address = rs.getString("address");
        role = rs.getString("role");
        status = rs.getString("status");

        byte[] photoBytes = rs.getBytes("photo");
        if (photoBytes != null) {
            photoBase64 = java.util.Base64.getEncoder().encodeToString(photoBytes);
        }
    }

    PreparedStatement psBalance = conn.prepareStatement("SELECT balance FROM account WHERE uemail = ?");
    psBalance.setString(1, username);
    ResultSet rsBalance = psBalance.executeQuery();
    if (rsBalance.next()) {
        balance = rsBalance.getDouble("balance");
    }

    rs.close();
    rsBalance.close();
    ps.close();
    psBalance.close();
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>User Dashboard</title>
<style>
  *, *::before, *::after {
    box-sizing: border-box;
  }
  body {
    margin: 0;
    padding: 0;
    font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: #222;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  .navbar {
    background: rgba(255 255 255 / 0.12);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    color: white;
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
    position: sticky;
    top: 0;
    z-index: 1000;
    user-select: none;
  }
  .navbar h1 {
    font-weight: 700;
    font-size: 1.75rem;
    letter-spacing: 1px;
    text-shadow: 1px 1px 8px rgba(0,0,0,0.3);
  }
  .logout-button {
    background: #e94560;
    border: none;
    padding: 0.75rem 1.8rem;
    border-radius: 30px;
    color: #fff;
    font-weight: 700;
    font-size: 1.1rem;
    box-shadow: 0 6px 15px rgba(233, 69, 96, 0.5);
    cursor: pointer;
    transition: background 0.3s ease, box-shadow 0.3s ease;
    text-transform: uppercase;
  }
  .logout-button:hover {
    background: #c42f4b;
    box-shadow: 0 8px 20px rgba(196, 47, 75, 0.6);
  }
  
  .main-content {
    max-width: 960px;
    margin: 2rem auto 4rem;
    background: rgba(255 255 255 / 0.15);
    border-radius: 25px;
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    box-shadow: 0 8px 32px rgba(0 0 0 / 0.1);
    padding: 3rem 2.5rem;
    text-align: center;
    color: #fefefe;
    user-select: none;
  }
  .welcome-text {
    font-size: 3.75rem;
    font-weight: 900;
    margin-bottom: 1.25rem;
    text-shadow: 0 2px 12px rgba(0,0,0,0.4);
  }

  .actions-nav {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 2rem;
    margin-top: 1rem;
  }
  .actions-nav a,
  .actions-nav button {
    display: inline-flex;
    align-items: center;
    gap: 12px;
    padding: 1.1rem 2.2rem;
    border-radius: 40px;
    font-weight: 700;
    font-size: 1.2rem;
    letter-spacing: 0.04em;
    background: linear-gradient(135deg, #ff61a6, #da22ff);
    color: #fff;
    border: none;
    cursor: pointer;
    box-shadow: 0 10px 20px rgba(218, 34, 255, 0.4);
    text-decoration: none;
    transition:
      background 0.3s ease,
      transform 0.25s ease,
      box-shadow 0.3s ease;
    user-select: none;
    white-space: nowrap;
    min-width: 180px;
    justify-content: center;
  }
  .actions-nav a:hover,
  .actions-nav button:hover {
    background: linear-gradient(135deg, #da22ff, #ff61a6);
    transform: translateY(-4px);
    box-shadow: 0 15px 30px rgba(218, 34, 255, 0.6);
  }

  .actions-nav a::before,
  .actions-nav button::before {
    font-size: 1.8rem;
  }
  .modal {
    position: fixed;
    top: 50%;
    left: 50%;
    width: 420px;
    max-width: 90vw;
    max-height: 75vh;
    background: white;
    border-radius: 25px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.35);
    padding: 2.5rem 3rem;
    transform: translate(-50%, -50%) scale(0.8);
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s ease 0s, transform 0.3s ease 0s;
    overflow-y: auto;
    z-index: 1050;
  }
  .modal.show {
    opacity: 1;
    pointer-events: auto;
    transform: translate(-50%, -50%) scale(1);
  }

  .modal-content {
    position: relative;
    color: #333;
  }
  .close-button {
    position: absolute;
    top: 15px;
    right: 20px;
    font-size: 32px;
    font-weight: 900;
    color: #d33f49;
    cursor: pointer;
    user-select: none;
    transition: color 0.25s ease;
  }
  .close-button:hover {
    color: #a72834;
  }

  .profile-photo {
    display: block;
    margin: 0 auto 1.8rem;
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    box-shadow: 0 6px 25px rgba(0,0,0,0.2);
    border: 5px solid #da22ff;
  }

  .modal-content p {
    font-weight: 600;
    font-size: 1.1rem;
    margin: 1rem 0;
  }
  .modal-content p strong {
    color: #7b2ff7;
  }
  .modal-content a {
    margin-left: 14px;
    font-size: 0.9rem;
    font-weight: 700;
    text-decoration: none;
    color: #9a4dff;
    cursor: pointer;
    transition: border-bottom-color 0.3s ease;
    border-bottom: 2px solid transparent;
  }
  .modal-content a:hover {
    border-bottom-color: #7b2ff7;
  }
  
  .overlay-popup {
    position: fixed;
    inset: 0;
    background: rgba(123, 47, 247, 0.8);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 1100;
  }
  .overlay-popup.show {
    display: flex;
  }
  .overlay-content {
    background: #fff;
    border-radius: 20px;
    width: 350px;
    max-width: 90vw;
    padding: 2rem 2.8rem;
    box-shadow: 0 18px 40px rgba(123, 47, 247, 0.5);
    position: relative;
    text-align: center;
    font-size: 1.15rem;
    font-weight: 600;
    color: #5216a0;
  }
  .overlay-content h2 {
    margin-bottom: 1.5rem;
    font-size: 1.9rem;
    font-weight: 800;
  }
  .overlay-content button {
    margin-top: 1.6rem;
    background: linear-gradient(45deg, #7b2ff7, #ac33ff);
    border: none;
    padding: 0.9rem 2rem;
    border-radius: 30px;
    font-weight: 700;
    font-size: 1.2rem;
    color: white;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(123, 47, 247, 0.6);
    transition: background 0.3s ease, box-shadow 0.3s ease;
    user-select: none;
  }
  .overlay-content button:hover {
    background: linear-gradient(45deg, #ac33ff, #7b2ff7);
    box-shadow: 0 12px 35px rgba(172, 51, 255, 0.75);
  }
  .overlay-content .close-btn {
    position: absolute;
    top: 12px;
    right: 18px;
    font-size: 28px;
    font-weight: 900;
    color: #bb2eff;
    cursor: pointer;
    user-select: none;
    transition: color 0.3s ease;
  }
  .overlay-content .close-btn:hover {
    color: #7600b8;
  }

  .change-form-content form input[type=text],
  .change-form-content form input[type=password] {
    font-size: 1.1rem;
    padding: 0.7rem 1rem;
    border-radius: 20px;
    border: 2px solid #da22ff;
    transition: border-color 0.3s ease;
    width: 100%;
  }
  .change-form-content form input[type=text]:focus,
  .change-form-content form input[type=password]:focus {
    border-color: #7b2ff7;
    outline: none;
  }
  .change-form-content form button {
    width: 100%;
    margin-top: 1rem;
    background: linear-gradient(45deg, #7b2ff7, #ac33ff);
    color: white;
    font-weight: 700;
    font-size: 1.2rem;
    padding: 0.9rem 2rem;
    border-radius: 30px;
    border: none;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(123, 47, 247, 0.6);
    transition: background 0.3s ease, box-shadow 0.3s ease;
    user-select: none;
  }
  .change-form-content form button:hover {
    background: linear-gradient(45deg, #ac33ff, #7b2ff7);
    box-shadow: 0 12px 35px rgba(172, 51, 255, 0.75);
  }

  #tpinError {
    color: #e94560;
    margin-top: 0.8rem;
    font-size: 1rem;
    min-height: 22px;
    font-weight: 700;
  }

  @media (max-width: 768px) {
    .navbar {
      flex-direction: column;
      gap: 0.75rem;
      padding: 1.2rem 1.5rem;
    }
    .navbar h1 {
      font-size: 1.5rem;
    }
    .logout-button {
      padding: 0.6rem 1.5rem;
      font-size: 1rem;
    }
    .main-content {
      margin: 1.5rem 1rem 3rem;
      padding: 2rem 1.5rem;
      font-size: 1rem;
    }
    .welcome-text {
      font-size: 2.8rem;
    }
    .actions-nav a,
    .actions-nav button {
      min-width: 140px;
      font-size: 1rem;
      padding: 0.9rem 1.6rem;
    }
  }

  @media (max-width: 480px) {
    .actions-nav {
      flex-direction: column;
      gap: 1.2rem;
    }
    .actions-nav a,
    .actions-nav button {
      min-width: 100%;
    }
    .profile-photo {
      width: 120px;
      height: 120px;
    }
  }
</style>

<script>
  function openModal() {
    console.log("Opening profile modal");
    document.getElementById("profileModal").classList.add("show");
  }
  function closeModal() {
    console.log("Closing profile modal");
    document.getElementById("profileModal").classList.remove("show");
  }

  function openBalancePopup() {
    console.log("Opening TPIN popup for balance check");
    document.getElementById('tpinPopup').classList.add('show');
  }
  function closeTpinPopup() {
    console.log("Closing TPIN popup");
    document.getElementById('tpinPopup').classList.remove('show');
    document.getElementById('tpinInput').value = '';
    document.getElementById('tpinError').innerText = '';
  }
  function verifyTpin(event) {
    event.preventDefault();
    var tpin = document.getElementById('tpinInput').value;
    var pin = new XMLHttpRequest();
    pin.open("POST", "VerifyTpinServlet", true);
    pin.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    pin.onreadystatechange = function() {
      if (pin.readyState === XMLHttpRequest.DONE) {
        if (pin.status === 200) {
          if (pin.responseText.trim() === "success") {
            closeTpinPopup();
            document.getElementById('balancePopup').classList.add('show');
          } else {
            document.getElementById('tpinError').innerText = "Invalid TPIN. Try again.";
          }
        }
      }
    };
    pin.send("tpin=" + encodeURIComponent(tpin));
  }
  function closeBalancePopup() {
    console.log("Closing balance popup");
    document.getElementById('balancePopup').classList.remove('show');
  }

  function openChangeForm(type) {
    document.getElementById('changeFormModal').classList.add('show');
    document.getElementById('updateType').value = type;
    document.getElementById('changeField').placeholder = type === 'mobile' ? 'New Mobile Number' : 'New Address';
    document.getElementById('changeField').value = '';
  }
  function closeChangeForm() {
    document.getElementById('changeFormModal').classList.remove('show');
  }

  
  if (window.history && window.history.pushState) {
        window.history.pushState(null, null, window.location.href);
        window.onpopstate = function() {
          window.history.go(1);
        };
  }
</script>
</head>
<body>

  <header class="navbar" role="banner">
    <h1>Welcome, <%=firstName%></h1>
    <form action="LogoutServlet" method="post" aria-label="Logout form">
      <input type="submit" class="logout-button" value="&#9211; Logout" aria-label="Logout button" />
    </form>
  </header>

  <main class="main-content" role="main" aria-label="User dashboard content">
    <h2 class="welcome-text" aria-label="Greeting">Hello, <%=firstName%> <%=lastName%>!</h2>
    <nav class="actions-nav" aria-label="User dashboard main actions">
      <a href="javascript:void(0);" onclick="openModal()" aria-haspopup="dialog" aria-controls="profileModal">&#128100; Profile</a>
      <a href="addBeneficiary.jsp">&#10133; Add Beneficiary</a>
      <a href="transfer.jsp">&#128184; Transfer</a>
      <a href="transactions">&#128196; Transactions</a>
      <button onclick="openBalancePopup()">&#8377; Check Balance</button>
    </nav>
  </main>

  <div id="profileModal" class="modal" role="dialog" aria-modal="true" aria-labelledby="profileTitle" tabindex="-1">
    <div class="modal-content">
      <span class="close-button" onclick="closeModal()" aria-label="Close profile modal">&#215;</span>
      <h2 id="profileTitle">Profile Details</h2>
      <img src="data:image/jpeg;base64,<%=photoBase64%>" alt="Profile Photo" class="profile-photo" />
      <p><strong>First Name:</strong> <%=firstName%></p>
      <p><strong>Last Name:</strong> <%=lastName%></p>
      <p><strong>Email:</strong> <%=email%></p>
      <p><strong>Mobile No:</strong> <%=mobileNo%> <a href="javascript:void(0);" onclick="openChangeForm('mobile')" aria-label="Change mobile number">Change</a></p>
      <p><strong>Address:</strong> <%=address%> <a href="javascript:void(0);" onclick="openChangeForm('address')" aria-label="Change address">Change</a></p>
      <p><strong>Role:</strong> <%=role%></p>
      <p><strong>Status:</strong> <%=status%></p>
    </div>
  </div>

  <div id="balancePopup" class="overlay-popup" role="alertdialog" aria-modal="true" aria-labelledby="balanceTitle" tabindex="-1">
    <div class="overlay-content">
      <h2 id="balanceTitle">Your Current Balance</h2>
      <p>&#8377;<%=balance%></p>
      <button onclick="closeBalancePopup()">Close</button>
    </div>
  </div>

  <div id="changeFormModal" class="overlay-popup" role="dialog" aria-modal="true" aria-labelledby="changeFormTitle" tabindex="-1">
    <div class="overlay-content change-form-content">
      <span class="close-btn" onclick="closeChangeForm()" aria-label="Close update form">&times;</span>
      <h2 id="changeFormTitle">Update Information</h2>
      <form action="UpdateProfileServlet" method="post">
        <input type="hidden" id="updateType" name="updateType" aria-hidden="true" />
        <input type="text" id="changeField" name="newField" required autocomplete="off" aria-required="true" />
        <button type="submit">Update</button>
      </form>
    </div>
  </div>

  <div id="tpinPopup" class="overlay-popup" role="dialog" aria-modal="true" aria-labelledby="tpinTitle" tabindex="-1">
    <div class="overlay-content">
      <span class="close-btn" onclick="closeTpinPopup()" aria-label="Close TPIN popup">&times;</span>
      <h2 id="tpinTitle">Enter Transaction PIN</h2>
      <form id="tpinForm" onsubmit="verifyTpin(event)" novalidate>
        <input type="password" id="tpinInput" placeholder="Enter TPIN" required autocomplete="off" aria-required="true" />
        <div id="tpinError" role="alert" aria-live="assertive"></div>
        <button type="submit">Submit</button>
      </form>
    </div>
  </div>
</body>
</html>
