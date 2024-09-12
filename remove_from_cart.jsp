<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Cartbean"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
	String productIdStr = request.getParameter("productId");
	if (productIdStr != null) {
		int productId = Integer.parseInt(productIdStr);

		// Get the cart from session
		HttpSession httpsession = request.getSession(false);
		List<Cartbean> cartItems = (List<Cartbean>) session.getAttribute("cartItems");

		if (cartItems != null) {
			Cartbean itemToRemove = null;

			// Find the item to remove
			for (Cartbean item : cartItems) {
				if (item.getProductId() == productId) {
					itemToRemove = item;
					break;
				}
			}

			if (itemToRemove != null) {
				cartItems.remove(itemToRemove);
			}
		}
	}

	// Redirect back to cart view
	response.sendRedirect("view_cart.jsp");
%>
