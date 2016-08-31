DBNAME = "recipes.sqlite"

DB = SQLite3::Database.new( DBNAME )
DB.execute("CREATE TABLE recipe(recipe_id, recipe_name")
DB.execute("CREATE TABLE ingredients(ing_id, ing")
DB.execute("CREATE TABLE recipe_ing_rel(recipe_id, in_id, amount, unit")