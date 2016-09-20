
require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

class AddRecipe

  #def recipe_instructions
  #  puts "Enter instructions"
  #  instructions = $stdin.gets.chomp
  #  @instructions = instructions
  #end

#lesson: you can have apostrophes within your instructions. because 
  def add_recipe
    @instructions = "Combine dry ingredients and any add-ins you'd like. Mix in water until well combined. Let rest 12 to 18 hours. Once proofed, fold out onto a floured board and fold over itself a few times. Let rest 15 minutes, then shape into a boule and place seam down to rise for 1 to 2 hours, until dough does not spring back readily when poked. Preheat oven at 450 for 30 minutes with pot inside. Bake for 30 minutes covered, then 15 minutes uncovered. Let cool(really)."

    DB.execute "INSERT INTO recipes(recipe_id, recipe_name, instructions) VALUES(NULL, 'x', \"#{@instructions}\")"
  end

  def run
    #recipe_instructions
    add_recipe
  end
  
end

add = AddRecipe.new
add.run

