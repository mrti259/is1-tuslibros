require "./cart"

class Interface
  @cart : Cart?

  def initialize(@catalogue : Catalogue)
  end

  def list_cart
    assert_cart_exists @cart
    @cart.not_nil!.list_content
  end

  def create_cart
    @cart = Cart.new(@catalogue)
  end

  def add_book(a_book : String)
    assert_cart_exists @cart
    @cart.not_nil!.add a_book
  end

  private def assert_cart_exists(a_cart)
    return unless a_cart.nil?
    raise ArgumentError.new self.class.non_existent_cart_error_descripcion
  end

  def self.non_existent_cart_error_descripcion : String
    "Non-existent cart"
  end
end
