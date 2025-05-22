<%@page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<style>
.approve-btn {
	background-color: lightgreen;
	color: white;
	border: none;
	padding:8px 16px;
	margin:7px 4px 0 4px;
	cursor:pointer;
}

.reject-btn {
	background-color: red;
	color: white;
	border: none;
	padding:8px 16px;
	margin:7px 4px 0 5px;
	cursor:pointer;
}
.approve-btn:hover,
.reject-btn:hover{
	box-shadow: 2px 2px 2px black;
}
th{
padding:20px;
background-color:yellow;
}
td{
background-color:#ccc;
padding:10px;
}
.logout-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #f0f0f0;
	padding: 10px 20px;
}

.logout-btn {
	background-color: orange;
	color: white;
	border: none;
	padding: 8px 16px;
	cursor: pointer;
	border-radius: 5px;
	font-weight: bold;
	position: absolute;
	top: 20px;
	right: 20px;
}
</style>

<%

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

HttpSession session2 = request.getSession(false);
if (session == null || session.getAttribute("admin") == null) {
    response.sendRedirect("welcome.jsp");
    return;
}

List<Map<String, String>> pendingUsers = (List<Map<String, String>>) request.getAttribute("pendingUsers");
%>
<div style="overflow: auto; background-color: #f0f0f0; padding: 10px;">
	<form action="LogoutServlet" method="post">
		<input type="submit" value="Logout" class="logout-btn">
	</form>
	<center><h2>Pending User Approvals</h2></center>
</div>

<center>
	
	<table border="1">
		<tr>
			<th>FirstName</th>
			<th>LastName</th>
			<th>Email</th>
			<th>Actions</th>
		</tr>
		<%
		for (Map<String, String> user : pendingUsers) {
		%>
		<tr>
			<td><%=user.get("firstname")%></td>
			<td><%=user.get("lastname")%></td>
			<td><%=user.get("uemail")%></td>
			<td>
				<form action="approve" method="post">
					<input type="hidden" name="id" value="<%=user.get("id")%>" /> <input
						type="submit" name="action" value="approve" class="approve-btn">
					<input type="submit" name="action" value="reject" class="reject-btn">
				</form>
			</td>
		</tr>
		<%
		}
		%>
	</table>
</center>
