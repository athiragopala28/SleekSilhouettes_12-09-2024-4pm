<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Cartbean"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<html>
<head>
<title>Shopping Cart</title>
<style>
.cart-table {
	width: 100%;
	border-collapse: collapse;
}

.cart-table th, .cart-table td {
	border: 1px solid #ddd;
	padding: 8px;
}

.cart-table th {
	background-color: #f2f2f2;
	text-align: left;
}
</style>
</head>
<body>

	<h2>Your Cart</h2>

	<%
		HttpSession httpsession = request.getSession(false);
		List<Cartbean> cartItems = (List<Cartbean>) session.getAttribute("cart_items");
		double totalAmount = 0;
	%>

	<%
		if (cartItems != null && !cartItems.isEmpty()) {
	%>
	<table class="cart-table">
		<tr>
			<th>Product Name</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Total</th>
			<th>Action</th>
		</tr>
		<%
			for (Cartbean item : cartItems) {
					totalAmount += item.getTotalPrice();
		%>
		<tr>
			<td><%=item.getName()%></td>
			<td><%=item.getPrice()%></td>
			<td><%=item.getQuantity()%></td>
			<td><%=item.getTotalPrice()%></td>
			<td><a
				href="remove_from_cart.jsp?productId=<%=item.getProductId()%>">Remove</a></td>
		</tr>
		<%
			}
		%>
	</table>

	<h3>
		Total Amount: ₹<%=totalAmount%></h3>
	<form action="CheckoutCart.jsp" method="post">
		<button type="submit">Checkout</button>
	</form>

	<%
		} else {
	%>
	<p>Your cart is empty!</p>
	<%
		}
	%>

</body>
</html>
