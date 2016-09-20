
require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

@recipe_id = 5

def get_ingredients
  @ingredient_id = DB.execute "SELECT ing_id FROM recipe_rel WHERE recipe_id=#{@recipe_id}"
  @ingredient_id.flatten!
  @ingredient_names = []
  @ingredient_id.each do |id|
    ingredient = DB.execute "SELECT ing FROM ingredients WHERE ing_id=#{id}"
    @ingredient_names << ingredient
  end
  @ingredient_names.flatten!
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

puts get_ingredients