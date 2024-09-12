<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Cartbean"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<style>
body {
	font-family: Arial, sans-serif;
	padding: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid black;
}

th, td {
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.total {
	text-align: right;
	font-size: 18px;
}

.checkout-button {
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}

.checkout-button:hover {
	background-color: #45a049;
}
</style>
</head>
<body>

	<h1>Checkout</h1>

	<%
		HttpSession httpsession = request.getSession();
		List<Cartbean> cartItems = (List<Cartbean>) session.getAttribute("cart_items");
		double total = 0.0;

		if (cartItems != null && !cartItems.isEmpty()) {
	%>

	<table>
		<thead>
			<tr>
				<th>Product ID</th>
				<th>Name</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Subtotal</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (Cartbean item : cartItems) {
						double subtotal = item.getPrice() * item.getQuantity();
						total += subtotal;
			%>
			<tr>
				<td><%=item.getProductId()%></td>
				<td><%=item.getName()%></td>
				<td>₹<%=String.format("%.2f", item.getPrice())%></td>
				<td><%=item.getQuantity()%></td>
				<td>₹<%=String.format("%.2f", subtotal)%></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>

	<p class="total">
		Total: ₹<%=String.format("%.2f", total)%></p>

	<form action="ProcessOrder.jsp" method="post">
		<button type="submit" class="checkout-button">Proceed to
			Checkout</button>
	</form>

	<%
		} else {
	%>
	<p>
		Your cart is empty. <a href="addproduct.jsp">Continue Shopping</a>
	</p>
	<%
		}
	%>

</body>
</html>
