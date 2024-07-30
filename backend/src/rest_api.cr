require "./interface"

record Response, status_code : Int32, content : String

class RestApi
  def initialize(catalogue : Catalogue)
    @interface = Interface.new catalogue
  end

  def create_cart
    handle do
      @interface.create_cart
      "ID_DEL_CARRITO"
    end
  end

  def add_to_cart(query : Hash(String, String))
    handle do
      @interface.add_book query["bookIsbn"]
      "OK"
    end
  end

  def list_cart
    handle do
      content = @interface.list_cart
      String.build do |sb|
        content.each_with_index do |isbn, index|
          sb << "|" if index > 0
          sb << isbn
          sb << "|1"
        end
      end
    end
  end

  private def handle
    Response.new 200, "0|#{yield}"
  rescue error
    Response.new 400, "1|#{error.message}"
  end
end
