require "./spec_helper"

module CartSpec
  def self.cart
    @@cart.not_nil!
  end

  def self.setup
    @@cart = Cart.new(CATALOGUE)
  end

  def self.add(a_book)
    cart.add a_book
  end

  def self.expect_to_have(a_quantity)
    cart.list_content.size.should eq a_quantity
  end

  describe Cart do
    before_each do
      setup
    end

    it "lists content" do
      expect_to_have 0
    end

    it "adds a book to cart" do
      add A_BOOK
      expect_to_have 1
    end

    it "adds two different books to cart" do
      add A_BOOK
      add ANOTHER_BOOK
      expect_to_have 2
    end

    it "raises error if book is not in catalogue" do
      expect_raises(ArgumentError, Cart.not_book_in_catalogue_error_description) do
        add NOT_A_BOOK
      end
      expect_to_have 0
    end
  end
end
