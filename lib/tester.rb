
require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

@recipe_name = "Pancakes"

@recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name=#{@recipe_name}"

puts @recipe_id