<%@ page import="bean.Collection" %>
<%@ page import="dao.CollectionDao" %>
<%@ page import="bean.Collection" %>

<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* Your CSS styles */
.navbar-brand {
    flex-grow: 1;
    font-size: 1.5rem;
    text-align: left;
}

.navbar-nav .nav-item {
    margin-right: 10px;
}

.icon-color {
    color: #000000;
}

.btn-black {
    color: #000000;
    border-color: #000000;
    background-color: #ffffff;
}

.btn-black:hover {
    color: #000000;
    background-color: #f0f0f0;
    border-color: #000000;
}

.form-control {
    border-color: #4caf50;
}

footer {
    background-color: #001f3f; /* Navy blue */
    padding: 40px 0;
    color: #ffffff; /* White text color for contrast */
    border-top: 1px solid #dee2e6;
}

.footer-content {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    flex-wrap: wrap;
}

.footer-section {
    flex: 1;
    min-width: 200px;
}

.footer-section h5 {
    font-weight: bold;
    margin-bottom: 15px;
}

.footer-section ul {
    list-style: none;
    padding: 0;
}

.footer-section ul li {
    margin-bottom: 10px;
}

.footer-section a {
    color: #ffffff; /* White link color */
    text-decoration: none;
}

.footer-section a:hover {
    text-decoration: underline;
}

.social-icons a {
    color: #ffffff; /* White icon color */
    font-size: 20px;
    margin-right: 10px;
}

.social-icons a:hover {
    color: #adb5bd; /* Light gray on hover */
}

.card-custom {
    border: 1px solid #dee2e6;
    border-radius: .375rem;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <!-- Your navigation bar code -->
    </nav>
    
    <div class="container mt-4">
        <%
            String collectionIdStr = request.getParameter("collectionId");
            if (collectionIdStr != null) {
                try {
                    int collectionId = Integer.parseInt(collectionIdStr);
                    CollectionDao collectionDAO = new CollectionDao();
                    Collection collection = collectionDAO.getCollectionById(collectionId);
                    if (collection != null) {
        %>
                        <h2><%= collection.getCollectionName() %></h2>
        <%
                    } else {
        %>
                        <p>No details found for the selected collection.</p>
        <%
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
        %>
                    <p>Invalid collection ID format.</p>
        <%
                } catch (SQLException e) {
                    e.printStackTrace();
        %>
                    <p>Error retrieving collection details.</p>
        <%
                }
            } else {
        %>
            <p>No collection ID provided.</p>
        <%
            }
        %>
    </div>
    
    <footer>
        <div class="container footer-content">
            <div class="footer-section">
                <h5>About Us</h5>
                <ul>
                    <li><a href="#">Company Info</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h5>Customer Service</h5>
                <ul>
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Returns</a></li>
                    <li><a href="#">Shipping</a></li>
                </ul>
            </div>
            <div class="footer-section social-icons">
                <h5>Follow Us</h5>
                <a href="#" class="fab fa-facebook-f"></a>
                <a href="#" class="fab fa-twitter"></a>
                <a href="#" class="fab fa-instagram"></a>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
