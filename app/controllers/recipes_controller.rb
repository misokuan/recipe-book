class RecipesController < ApplicationController
  def new
    @cookbook = Cookbook.find(params[:cookbook_id])
  	@recipe = Recipe.new
  end

  def create
  	params.permit!
  	@recipe = Recipe.create(cookbook_id: params[:cookbook_id])
  	@recipe.update(params[:recipe])
  	redirect_to cookbook_path(params[:cookbook_id])
  end

  def edit
    @cookbook = Cookbook.find(params[:cookbook_id])    
  	@recipe = Recipe.find(params[:id])
  end

  def update
  	params.permit!
  	@recipe = Recipe.find(params[:id])
  	@recipe.update(params[:recipe])
  	redirect_to cookbook_path(@recipe.cookbook)
  end

  def show
    @cookbook = Cookbook.find(params[:cookbook_id])    
  	@recipe = Recipe.find(params[:id])
  end

  def destroy
    @cookbook = Recipe.find(params[:id]).cookbook
  	Recipe.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to cookbook_path(@cookbook) }
      format.js { }
    end
  end
  
end
