require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    # Testing after association between chefs and recipes was established
    # @chef = Chef.new(chefname: "Zacherl", email: "zach@erl.de")   # chef_id does not hit database
    @chef = Chef.create(chefname: "Zacherl", email: "zach@erl.de")
    @recipe = @chef.recipes.build(name: "vegetable burka", summary: "The best thing you can eat",
                         description: "heat oil, add garlic, stir fry it, add salt then add main ingredent and enjoy.")


    # Testing before association between chefs and recipes was established
    # @recipe = Recipe.new(name: "vegetable burka", summary: "The best thing you can eat",
    #                     description: "heat oil, add garlic, stir fry it, add salt then add main ingredent and enjoy.")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "name length should not be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end

  test "name length should not be too short" do
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end

  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end

  test "summary length should not be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end

  test "summary length should not be too short" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end

  test "description must be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description should not be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

  test "description should not be too short" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end

end