
require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

def recipe_ingredients
=begin
  @ingredients = []
  loop do
    puts "Enter all ingredients, then type 'done'"
    ingredient = $stdin.gets.chomp
    @ingredients << ingredient
    if ingredient == "done"
      break
    end
  end
  @ingredients.pop
  @ingredients.map! {|ingredient| ingredient.split}
=end
  @ingredients.each do |element|
    if element.size == 4
      element[2].concat(" #{element[3]}")
      element.pop
    elsif element.size == 5
      element[2].concat(" #{element[3]}").concat(" #{element[4]}")
      element.pop(2)
  end
end