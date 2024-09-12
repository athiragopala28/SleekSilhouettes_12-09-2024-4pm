package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Cartbean;
import dbconnection.DBConnection;

public class CartDao {

	// Method to check if a cart item already exists for a given user and product
	public boolean isCartItemExists(int userId, int productId) throws SQLException {
		String query = "SELECT COUNT(*) FROM cart_items WHERE user_id = ? AND product_id = ?";
		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, userId);
			statement.setInt(2, productId);

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					return resultSet.getInt(1) > 0; // Return true if the cart item exists
				}
			}
		}
		return false; // Return false if the cart item does not exist
	}

	// Method to insert a new cart item
	public boolean insertCartItem(Cartbean cartItem, int userId) throws SQLException {
		if (isCartItemExists(userId, cartItem.getProductId())) {
			return false; // Cart item already exists, do not insert
		}

		String query = "INSERT INTO cart_items (user_id, product_id, product_name, price, quantity) VALUES (?, ?, ?, ?, ?)";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, userId);
			statement.setInt(2, cartItem.getProductId());
			statement.setString(3, cartItem.getName());
			statement.setDouble(4, cartItem.getPrice());
			statement.setInt(5, cartItem.getQuantity());

			int rowsAffected = statement.executeUpdate();
			return rowsAffected > 0; // Return true if the insert was successful
		}
	}

	// Method to update the quantity of an existing cart item
	public boolean updateCartItem(Cartbean cartItem, int userId) throws SQLException {
		String query = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND product_id = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, cartItem.getQuantity());
			statement.setInt(2, userId);
			statement.setInt(3, cartItem.getProductId());

			int rowsUpdated = statement.executeUpdate();
			return rowsUpdated > 0; // Return true if the update was successful
		}
	}

	// Method to retrieve all cart items for a specific user
	public List<Cartbean> getCartItemsByUserId(int userId) throws SQLException {
		String query = "SELECT * FROM cart_items WHERE user_id = ?";
		List<Cartbean> cartItems = new ArrayList<>();

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, userId);

			try (ResultSet resultSet = statement.executeQuery()) {
				while (resultSet.next()) {
					Cartbean item = new Cartbean();
					item.setProductId(resultSet.getInt("product_id"));
					item.setName(resultSet.getString("product_name"));
					item.setPrice(resultSet.getDouble("price"));
					item.setQuantity(resultSet.getInt("quantity"));
					cartItems.add(item);
				}
			}
		}
		return cartItems;
	}

	// Method to delete a specific cart item
	public boolean deleteCartItem(int userId, int productId) throws SQLException {
		String query = "DELETE FROM cart_items WHERE user_id = ? AND product_id = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, userId);
			statement.setInt(2, productId);

			int rowsDeleted = statement.executeUpdate();
			return rowsDeleted > 0; // Return true if the delete was successful
		}
	}

	// Method to clear all cart items for a specific user
	public boolean clearCartByUserId(int userId) throws SQLException {
		String query = "DELETE FROM cart_items WHERE user_id = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, userId);

			int rowsDeleted = statement.executeUpdate();
			return rowsDeleted > 0; // Return true if all cart items were deleted
		}
	}

	// Method to count the total number of cart items for a user
	public int getCartItemCount(int userId) throws SQLException {
		String query = "SELECT COUNT(*) FROM cart_items WHERE user_id = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, userId);

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next()) {
					return resultSet.getInt(1); // Return the total count of cart items
				}
			}
		}
		return 0;
	}
}
