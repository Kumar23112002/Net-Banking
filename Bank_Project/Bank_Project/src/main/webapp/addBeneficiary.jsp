<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 20px;
}

h2 {
	color: #333;
	text-align: center;
}

form {
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	max-width: 400px;
	margin: auto;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

input[type="number"], input[type="text"], input[type="submit"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type="submit"] {
	background-color: #007bff;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 16px;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<h2>Add Beneficiary</h2>
	<form action="addBeneficiary" method="post">
		<label>Your Account ID:</label> <input type="number" name="account_id" required><br>
		<label>Beneficiary Account ID: </label> <input type="number" name="beneficiary_id" required><br>
		<label>Name:</label><input type="text" name="name"><br> <input type="submit" value="Add Beneficiary">
	</form>



</body>
</html>