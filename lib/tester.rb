
require 'rubygems'
require 'sqlite3'

DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))


@ingredients = [["1", "x", "egg"], ["3", "tsp", "sugar"], ["6", "cups", "apples"], ["4", "tbsp", "curry"]]

def add_ingredients
  @existing = []
  @ingredient_list = []
  @ingredients.each do |ing|
    @ingredient_list << ing[2]
  end
  @ingredient_list.each do |ing|
    ingredient = DB.execute "SELECT ing FROM ingredients WHERE ing='#{ing}'"
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
  #in progress
  @to_add = @ingredient_list - @existing
  @to_add.each do |ingredient|
    DB.execute "INSERT INTO ingredients(ing_id, ing) VALUES(NULL, '#{ingredient}')"
  end
end

add_ingredients