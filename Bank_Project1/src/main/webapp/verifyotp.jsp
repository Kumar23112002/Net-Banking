<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify Otp</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f2f2f2;
        padding: 50px;
        text-align: center;
    }

    h2 {
        color: #333;
    }

    #timer {
        font-size: 20px;
        margin-bottom: 20px;
    }

    input[type="text"] {
        padding: 10px;
        width: 250px;
        margin: 10px auto;
        font-size: 16px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    button {
        padding: 10px 20px;
        font-size: 16px;
        margin: 10px;
        background-color: #007BFF;
        border: none;
        border-radius: 5px;
        color: white;
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3;
    }

    .error-message {
        color: red;
        font-weight: bold;
        margin-top: 15px;
    }
</style>

  
  <script>
        let timer = 60; // 60 seconds

        function startCountdown() {
            const countdown = document.getElementById("timer");
            const interval = setInterval(function () {
                if (timer <= 0) {
                    clearInterval(interval);
                    countdown.innerHTML = "&#x23F3; OTP expired. Please request a new one.";
                    document.getElementById("otpForm").style.display = "none";
                    document.getElementById("resendForm").style.display = "block";
                } else {
                    countdown.innerHTML = "&#x23F0; Time remaining: " + timer + " seconds";
                    timer--;
                }
            }, 1000);
        }

        window.onload = startCountdown;
    </script>
</head>
<body>

    <h2>OTP Verification</h2>

    
    <div id="timer" style="font-weight: bold; color: red;"></div>

    
    <form id="otpForm" action="verifyotp" method="post">
        <input type="text" name="otp" placeholder="Enter your OTP" required />
        <button type="submit">Verify OTP</button>
    </form>

    
    <form id="resendForm" action="sendotp" method="post" style="display: none;">
        <input type="hidden" name="email" value="${sessionScope.email}" />
        <button type="submit">Resend OTP</button>
    </form>

    
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

</body>
</html>