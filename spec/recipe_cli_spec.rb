require 'stringio'
require_relative '../recipe_cli.rb'

describe Recipe do

  describe '#recipe_name' do
    before do
      @input = $stdin
      $stdin = StringIO.new("Banana Bread\n")
    end

    after do
      $stdin = @input
    end

    it 'stores the recipe name as a variable' do
      expect(subject.recipe_name).to be == "Banana Bread"
    end
  end

  describe '#recipe_ingredients' do
    before(:each) do
      @input = $stdin
      $stdin = StringIO.new("1 cup flour\ndone\n")
    end

    after(:each) do
      $stdin = @input
    end

    it 'stores the recipe name as a variable' do
      expect(subject.recipe_ingredients).to be == ["1 cup flour"]
    end
  end

  describe '#recipe_instructions' do
    before do
      @input = $stdin
      $stdin = StringIO.new("Bake for 1 hour at 350 degrees.\n")
    end

    after do
      $stdin = @input
    end

    it 'stores the recipe name as a variable' do
      expect(subject.recipe_instructions).to be == "Bake for 1 hour at 350 degrees."
    end
  end
end

=begin
only need to define subject if it requires parameters (or you want to control them) 
=end