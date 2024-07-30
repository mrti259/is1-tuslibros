require "./catalogue"

class Cart
  @content = Array(String).new

  def initialize(@catalogue : Catalogue)
  end

  def list_content : Array(String)
    @content.to_a
  end

  def add(a_book : String) : Nil
    assert_is_in_catalogue a_book
    @content << a_book
  end

  private def assert_is_in_catalogue(a_book : String) : Nil
    return if @catalogue.includes? a_book
    raise ArgumentError.new self.class.not_book_in_catalogue_error_description
  end

  def self.not_book_in_catalogue_error_description : String
    "Book not in catalogue"
  end
end
