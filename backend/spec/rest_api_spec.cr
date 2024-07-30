require "./spec_helper"

module RestApiSpec
  def self.rest_api
    @@rest_api.not_nil!
  end

  def self.setup
    @@rest_api = RestApi.new(CATALOGUE)
  end

  def self.create_cart
    rest_api.create_cart
  end

  def self.add_to_cart(a_book : String)
    rest_api.add_to_cart({
      "bookIsbn" => a_book,
      "cartId"   => "",
    })
  end

  def self.list_cart
    rest_api.list_cart
  end

  def self.expect_succeded_with_content(content)
    expect_with_status_code_and_content(200, "0|#{content}") do
      yield
    end
  end

  def self.expect_error_with_content(content)
    expect_with_status_code_and_content(400, "1|#{content}") do
      yield
    end
  end

  def self.expect_with_status_code_and_content(status_code, content)
    response = yield
    response.status_code.should eq status_code
    response.content.should eq content
  end

  describe RestApi do
    before_each do
      setup
    end
    it "serialize create_cart on succeded" do
      expect_succeded_with_content "ID_DEL_CARRITO" do
        create_cart
      end
    end

    it "serialize adds_to_cart on error" do
      expect_error_with_content(Interface.non_existent_cart_error_descripcion) do
        add_to_cart A_BOOK
      end
    end

    it "serialize adds_to_cart on succeded" do
      expect_succeded_with_content "OK" do
        create_cart
        add_to_cart A_BOOK
      end
    end

    it "serialize list_cart on error" do
      expect_error_with_content (Interface.non_existent_cart_error_descripcion) do
        list_cart
      end
    end

    it "serialize list_cart on succeded" do
      expect_succeded_with_content("") do
        create_cart
        list_cart
      end
    end

    it "serialize list_cart with a book" do
      expect_succeded_with_content("#{A_BOOK}|1") do
        create_cart
        add_to_cart A_BOOK
        list_cart
      end
    end

    it "serialize list_cart with two books" do
      expect_succeded_with_content("#{A_BOOK}|1|#{ANOTHER_BOOK}|1") do
        create_cart
        add_to_cart A_BOOK
        add_to_cart ANOTHER_BOOK
        list_cart
      end
    end
  end
end
