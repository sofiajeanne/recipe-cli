
require 'rubygems'
require 'sqlite3'


DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

def get_recipe_name
  puts "Please enter the recipe you're looking for"
  recipe_name = $stdin.gets.chomp
  @recipe_name = recipe_name
end

#fix whatever is going on here
def get_recipe_id
  @recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name='#{@recipe_name}'"
  @recipe_id = @recipe_id[0][0]
end

def get_instructions
  @instructions = DB.execute "SELECT instructions FROM recipes WHERE recipe_name='#{@recipe_name}'"
end

def get_ingredients
  @ingredient_id = DB.execute "SELECT ing_id FROM recipe_rel WHERE recipe_id=#{@recipe_id}"
  @ingredient_id.map! do |ing|
    ing[0]
  end
  @ingredient_names = []
  @ingredient_id.each do |id|
    ingredient = DB.execute "SELECT ing FROM ingredients WHERE ing_id=#{id}"
    @ingredient_names << ingredient
  end
  @ingredient_names.map! do |ing|
    ing[0][0]
  end
  @ing_hash = Hash[@ingredient_id.zip @ingredient_names]
  @ingredient_list = DB.execute "SELECT ing_id, amount, unit FROM recipe_rel WHERE recipe_id=#{@recipe_id}"
  @ingredient_list.each do |ing|
    ing[0] = @ing_hash[ing[0]]
    ing.rotate!
  end
  @ingredient_list.map! do |ing|
    ing.join(" ")
  end
end

def fetch_recipe
  get_recipe_name
  get_recipe_id
  get_instructions
  get_ingredients
end

def display_recipe
  fetch_recipe
  puts @recipe_name
  puts @ingredient_list
  puts @instructions
end

puts fetch_recipe

=begin
@ingredient_names.each_with_index do |ing, i|
  puts "#{ing}: index #{i}"
end

@ingredients = ["2 tsp rice vinegar", "1-2 tsp gochugaru", "1 tsp toasted sesame oil", "1 tsp toasted sesame seeds", "1/2 tsp salt", "1/2 tsp sugar", "1 x scallions", "2 x cucumber"]
@ingredients.map! {|ingredient| ingredient.split}
@ingredients.each do |element|
  if element.size == 4
    element[2].concat(" #{element[3]}")
    element.pop
  elsif element.size == 5
    element[2].concat(" #{element[3]}").concat(" #{element[4]}")
    element.pop(2)
  end
end

@recipe_name = 'Korean Cucumber Salad'

@recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name='#{@recipe_name}'"

@ingredients.each do |ingredient|
  @ing_id = DB.execute "SELECT ing_id FROM ingredients WHERE ing='#{ingredient[2]}'"
  DB.execute "INSERT INTO recipe_rel (row_id, recipe_id, ing_id, amount, unit) VALUES(NULL, '#{@recipe_id[0][0]}', '#{@ing_id[0][0]}', '#{ingredient[0]}', '#{ingredient[1]}')"
=end