<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Cartbean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%
	// Retrieve parameters from request
	String productIdStr = request.getParameter("productId");
	String name = request.getParameter("name");
	String priceStr = request.getParameter("price");

	// Check if all required parameters are present
	if (productIdStr != null && !productIdStr.isEmpty() && name != null && !name.isEmpty() && priceStr != null
			&& !priceStr.isEmpty()) {
		try {
			// Parse parameters
			int productId = Integer.parseInt(productIdStr);
			double price = Double.parseDouble(priceStr);

			// Retrieve existing cart items from session
			HttpSession httpsession = request.getSession();
			List<Cartbean> cartItems = (List<Cartbean>) session.getAttribute("cart_items");

			if (cartItems == null) {
				cartItems = new ArrayList<>();
				session.setAttribute("cart_items", cartItems);
			}

			// Check if the item already exists in the cart
			Cartbean existingItem = null;
			for (Cartbean item : cartItems) {
				if (item.getProductId() == productId) {
					existingItem = item;
					break;
				}
			}

			// If item exists, update quantity; otherwise, add a new item
			if (existingItem != null) {
				existingItem.setQuantity(existingItem.getQuantity() + 1);
			} else {
				Cartbean newItem = new Cartbean();
				newItem.setProductId(productId);
				newItem.setName(name);
				newItem.setPrice(price);
				newItem.setQuantity(1);
				cartItems.add(newItem);
			}

			// Redirect to the cart page with success message
			out.print("<script type='text/javascript'>");
			out.print("alert('Item added to cart successfully.');");
			out.print("window.location.href = 'view_cart.jsp';");
			out.print("</script>");

		} catch (NumberFormatException e) {
			// Handle parsing errors
			out.print("<script type='text/javascript'>");
			out.print("alert('Error: Invalid number format. Please check the provided data.');");
			out.print("window.location.href = 'add_to_cart.jsp';");
			out.print("</script>");
			e.printStackTrace();
		}
	} else {
		// Handle missing parameters
		out.print("<script type='text/javascript'>");
		out.print("alert('Error: Missing required parameters. Please ensure all fields are filled out.');");
		out.print("window.location.href = 'add_to_cart.jsp';");
		out.print("</script>");
	}
%>
