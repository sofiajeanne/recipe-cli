array = [["1", "tsp", "pure", "grated", "ginger"], ["1", "TBSP", "minced", "garlic"]]
array.map do |element|
  full_ing = element[2].concat(" #{element[3]}")
  element.pop
end

p array