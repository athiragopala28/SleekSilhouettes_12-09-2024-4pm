<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Cartbean"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.PrintWriter"%>

<html>
<head>
<title>Order Confirmation</title>
</head>
<body>
	<h2>Order Confirmation</h2>
	<%
		HttpSession httpsession = request.getSession();
		List<Cartbean> cartItems = (List<Cartbean>) session.getAttribute("cart_items");

		if (cartItems != null && !cartItems.isEmpty()) {
			// Process the order (e.g., save to database, send confirmation email, etc.)
			// For this example, we'll just clear the cart

			double totalCartPrice = 0.0;
			for (Cartbean item : cartItems) {
				totalCartPrice += item.getTotalPrice();
				// Here you would typically save each item to an order record in the database
			}

			// Clear the cart
			session.removeAttribute("cart_items");

			// Display order confirmation
			out.print("<p>Thank you for your order!</p>");
			out.print("<p>Total Order Price: <strong>" + totalCartPrice + "</strong></p>");
			out.print(
					"<p>Your order has been successfully placed. You will receive an email confirmation shortly.</p>");
			out.print("<a href='index.jsp'>Return to Home Page</a>");
		} else {
			// Handle the case where the cart is empty
			out.print("<p>Your cart is empty. Please <a href='index.jsp'>continue shopping</a>.</p>");
		}
	%>
</body>
</html>
