
require 'rubygems'
require 'sqlite3'

#DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))



@ingredients = ["1-2 tsp gochugaru", "2 tsp rice vinegar", "1 tsp toasted sesame oil"]
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
p @ingredients




=begin
@recipe_name = 'Korean Cucumber Salad'

@recipe_id = DB.execute "SELECT recipe_id FROM recipes WHERE recipe_name='#{@recipe_name}'"

@ingredients.each do |ingredient|
  @ing_id = DB.execute "SELECT ing_id FROM ingredients WHERE ing='#{ingredient[2]}'"
  DB.execute "INSERT INTO recipe_rel (recipe_id, ing_id, amount, unit) VALUES('#{@recipe_id[0][0]}', '#{@ing_id[0][0]}', '#{ingredient[0]}', '#{ingredient[1]}')"
end

2 teaspoons rice vinegar
1-2 teaspoons gochugaru
1 teaspoon toasted sesame oil
1 teaspoon toasted sesame seeds
1/2 teaspoon salt
1/2 teaspoon sugar
1 scallion, chopped
2 Kirby cucumbers, sliced 1/8-inch thick
=end