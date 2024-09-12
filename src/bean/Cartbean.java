package bean;

public class Cartbean {
	private int productId;
	private String name;
	private double price;
	private int quantity;

	// Getters and Setters
	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	// Method to calculate total price of this item
	public double getTotalPrice() {
		return price * quantity;
	}

	@Override
	public String toString() {
		return "Cartbean [productId=" + productId + ", name=" + name + ", price=" + price + ", quantity=" + quantity
				+ "]";
	}
	
}
