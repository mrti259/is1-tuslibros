require "./spec_helper"

module InterfaceSpec
  def self.interface
    @@interface.not_nil!
  end

  def self.setup
    @@interface = Interface.new CATALOGUE
  end

  def self.create_cart
    interface.create_cart
  end

  def self.add(a_book)
    interface.add_book a_book
  end

  def self.expect_to_have(a_quantity)
    interface.list_cart.size.should eq a_quantity
  end

  describe Interface do
    before_each do
      setup
    end

    it "raises error when trying to list content of a non-existent cart" do
      expect_raises(ArgumentError, Interface.non_existent_cart_error_descripcion) do
        expect_to_have 0
      end
    end

    it "creates cart and lists it's content" do
      create_cart
      expect_to_have 0
    end

    it "raises error when trying to add a book to a non-existent cart" do
      expect_raises(ArgumentError, Interface.non_existent_cart_error_descripcion) do
        add A_BOOK
      end
    end

    it "creates cart and adds a book" do
      create_cart
      add A_BOOK
      expect_to_have 1
    end
  end
end
