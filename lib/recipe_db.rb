require 'rubygems'
require 'sqlite3'

# DBNAME = "recipes.sqlite"
# File.delete(DBNAME) if File.exists?DBNAME

# DB = SQLite3::Database.new( DBNAME )
# DB = "recipes.sqlite"
# DB.execute("CREATE TABLE recipe(recipe_id INTEGER PRIMARY KEY, recipe_name TEXT, instructions TEXT)")
# DB.execute("CREATE TABLE ingredients(ing_id INTEGER PRIMARY KEY, ing TEXT)")
# DB.execute("CREATE TABLE recipe_ing_rel(recipe_id INT, ing_id INT, amount REAL, unit TEXT)")

# DB = SQLite3::Database.open "recipes.sqlite"
# DB.execute "INSERT INTO recipe VALUES(1, 'Korean Cucumber Salad')"


DB = SQLite3::Database.open (File.expand_path(__FILE__) + "/recipes.sqlite")

class Recipe

  def recipe_name
    puts "Enter recipe name"
    recipe_name = $stdin.gets.chomp
    @recipe_name = recipe_name
  end

  def recipe_instructions
    puts "Enter instructions"
    instructions = $stdin.gets.chomp
    @instructions = instructions
  end

  def add_to_db
    DB.execute "INSERT INTO recipes(recipe_name, instructions) VALUES('#{@recipe_name}', '#{@instructions}')"
  end

  def run
    recipe_name
    recipe_instructions
    add_to_db
  end

end

Recipe.new.run

=begin
open recipes table
  insert recipe id
  recipe_name
  instructions

open ingredients table
iterate over array to check if ingredient exists in db
return ingredients with matching words as potential matches
  if there's a match, take ingredient_id
  elsif none match, insert 
    ingredient id
    ingredient_name

open recipe_ing_rel table
for each ingredient insert
  recipe id (matched to recipe_name)
  ingredient id (matched to ing)
  amount
  unit
=end