class Recipe

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
    @ingredients
  end

  def recipe_instructions
    puts "Enter recipe instructions:"
    @instructions = $stdin.gets.chomp
  end

  def write_to_file
    @target_file = open('recipes.txt', 'a+')
    @target_file.write "#{@recipe_name}\nIngredients\n"
    @ingredients.each do |ingredient|
      @target_file.puts("\t\*" + ingredient)
    end
    @target_file.write("\nInstructions:\n#{@instructions}\n\n-----\n")
    @target_file.close
  end

  def read_file
    file = File.open('../recipes/recipes.txt')
    contents = file.read
    array = contents.split(/(?=rec10)/)
    puts array[1]
  end

  def run
    recipe_name
    recipe_ingredients
    recipe_instructions
    write_to_file
    read_file
  end
end