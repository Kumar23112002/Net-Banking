<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: lightgreen;
	margin: 0;
	padding: 0;
}

.container {
	width: 300px;
	height:320px;
	padding: 35px;
	background-color: white;
	margin: 100px auto;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
}

label {
	font-size: 14px;
}

input[type="text"], input[type="password"] {
	width: 93%;
	padding: 10px;
	margin: 10px 0;
	border: 1px solid lightgrey;
	border-radius: 4px;
}

input[type="submit"] {
	width: 100%;
	padding: 10px;
	background-color: orange;
	border: none;
	color: white;
	border-radius: 4px;
	cursor: pointer;
	outline: 2px solid orange;
	outline-offset: 4px; 
	margin-top:40px;
}

input[type="submit"]:hover {
	background-color: blue;
	outline: 2px solid blue;
}

.error-message {
	color: red;
	text-align: center;
	margin-bottom: 10px;
}
a{
font-size:12px;
margin-left:210px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Login</h2>

		<h3 class="error-message"><%=request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : ""%></h3>

		<form action="adminLogin" method="post">
			<label for="username">UserName :</label>
			<input type="text" id="username" name="username" placeholder="Enter username" required ><br>
			
			<label for="password">Password :</label>
			<input type="password" id="password" name="password" placeholder="Enter password" required><br>
			
			<a href="forgotpassword.jsp" >Forgot password</a>
			
			<input type="submit" value="Login">
		</form>
	</div>
</body>
</html>