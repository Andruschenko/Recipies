class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    # us pry gem
    #binding.pry
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    #binding.pry
    @recipe = Recipe.new(recipe_params)
    # until user authentification is coded, hard code this line
    @recipe.chef = Chef.find(3)  # always take chef with id 2 for now

    if @recipe.save
      flash[:success] = "Your recipe was created successfully!"
      redirect_to recipes_path
    else
      render :new   # or: render the 'new' template
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  private

    def recipe_params
      # Strong parameters - have to be declared explicitly (whitelabel parameters)
      # require only recipe field in params and only permit certain of its fields
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end

end