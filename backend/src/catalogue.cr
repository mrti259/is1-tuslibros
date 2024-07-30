require "json"

class Catalogue
  def initialize(@content : Array(String))
  end

  def includes?(a_book : String) : Bool
    @content.includes? a_book
  end

  def self.from_file(filename : String)
    content = File.read filename
    data = JSON.parse content
    books = data.as_a.map do |item|
      item["isbn"].as_s
    end
    new books
  end
end
