require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

@ingredients = [["2", "tsp", "rice vinegar"], ["1-2", "tsp", "gochugaru"]]
@recipe_name = 'Korean Cucumber Salad'

@recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name='#{@recipe_name}'"

@ingredients.each do |ingredient|
  @ing_id = DB.execute "SELECT ing_id FROM ingredients WHERE ing='#{ingredient[2]}'"
  DB.execute "INSERT INTO recipe_rel (recipe_id, ing_id, amount, unit) VALUES('#{@recipe_id[0][0]}', '#{@ing_id[0][0]}', '#{ingredient[0]}', '#{ingredient[1]}')"
end