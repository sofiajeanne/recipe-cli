require 'rubygems'
require 'sqlite3'

# INITIALIZERS
# DBNAME = "recipes.sqlite"
# File.delete(DBNAME) if File.exists?DBNAME

# DB = SQLite3::Database.new( DBNAME )
# DB = "recipes.sqlite"
# DB.execute("CREATE TABLE recipe(recipe_id INTEGER PRIMARY KEY, recipe_name TEXT, instructions TEXT)")
# DB.execute("CREATE TABLE ingredients(ing_id INTEGER PRIMARY KEY, ing TEXT)")
# DB.execute("CREATE TABLE recipe_rel(row_id INTEGER PRIMARY KEY, recipe_id INT, ing_id INT, amount TEXT, unit TEXT)")

# DB = SQLite3::Database.open "recipes.sqlite"
# DB.execute "INSERT INTO recipe VALUES(1, 'Korean Cucumber Salad')"

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

class AddRecipe

  def recipe_name
    puts "Enter recipe name"
    recipe_name = $stdin.gets.chomp
    @recipe_name = recipe_name
  end

  def recipe_ingredients
    @ingredients = []
    loop do
      puts "Enter all ingredients, then type 'done'"
      ingredient = $stdin.gets.chomp
      @ingredients << ingredient
      break if ingredient == "done"
    end
    @ingredients.pop
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
  end

  def recipe_instructions
    puts "Enter instructions"
    instructions = $stdin.gets.chomp
    @instructions = instructions
  end

  def add_recipe
    DB.execute "INSERT INTO recipes(recipe_id, recipe_name, instructions) VALUES(NULL, \"#{@recipe_name}\", \"#{@instructions}\")"
  end

  def add_ingredients
    @existing = []
    @ingredient_list = []
    @ingredients.each do |ing|
      @ingredient_list << ing[2]
    end
    @ingredient_list.each do |ing|
      ingredient = DB.execute "SELECT ing FROM ingredients WHERE ing=\"#{ing}\""
      @existing << ingredient
    end
    @existing.each do |ing|
      if ing == []
        @existing.delete(ing)
      end
    end
    @existing.map! do |x|
      x[0][0]
    end
    @to_add = @ingredient_list - @existing
    @to_add.each do |ingredient|
      DB.execute "INSERT INTO ingredients(ing_id, ing) VALUES(NULL, \"#{ingredient}\")"
    end
  end

  def add_rels
    @recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name='#{@recipe_name}'"
    @ingredients.each do |ingredient|
      @ing_id = DB.execute "SELECT ing_id FROM ingredients WHERE ing='#{ingredient[2]}'"
      DB.execute "INSERT INTO recipe_rel (row_id, recipe_id, ing_id, amount, unit) VALUES(NULL, '#{@recipe_id[0][0]}', '#{@ing_id[0][0]}', \"#{ingredient[0]}\", \"#{ingredient[1]}\")"
    end
  end
  
  def run
    recipe_name
    recipe_ingredients
    recipe_instructions
    add_recipe
    add_ingredients
    add_rels
  end

end


class GetRecipe

  def get_recipe_input
    puts "Please enter the recipe you're looking for"
    @recipe_name = $stdin.gets.chomp
  end

  def get_recipe_id
    @recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name=\"#{@recipe_name}\""
    @recipe_id = @recipe_id[0][0]
  end

  def get_instructions
    @instructions = DB.execute "SELECT instructions FROM recipes WHERE recipe_name=\"#{@recipe_name}\""
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

  def fetch
    get_recipe_input
    get_recipe_id
    get_instructions
    get_ingredients
  end

  def display
    puts @recipe_name
    puts @ingredient_list
    puts @instructions
  end

end

class Access

  def self.index
    DB.execute "SELECT recipe_name FROM recipes"
  end

  def self.alphabetical_index
    @recipes = DB.execute "SELECT recipe_name FROM recipes"
    puts @recipes.flatten.sort
  end

  def self.recipes_including(ingredient)
    @ing_id = DB.execute "SELECT ing_id from ingredients WHERE ing=\"#{ingredient}\""
    @ing_id = @ing_id.join("")
    @recipe_ids = DB.execute "SELECT recipe_id FROM recipe_rel where ing_id=#{@ing_id}"
    @recipes = []
    @recipe_ids.flatten.map do |id|
      recipe = DB.execute "SELECT recipe_name FROM recipes WHERE recipe_id=#{id}"
      @recipes << recipe
    end
    puts @recipes.sort
  end

end

=begin
open ingredients table
**iterate over array to check if ingredient exists in db
**return ingredients with matching words as potential matches
**  if there's a match, take ingredient_id
  elsif none match, insert 
    ingredient id (NULL)
    ingredient_name
=end