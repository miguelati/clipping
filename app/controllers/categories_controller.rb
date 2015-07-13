# encoding: UTF-8

class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /categories
  # GET /categories.json
  def index
		
		@selected = params[:entity]
		unless current_user.is_admin?
			@entities = Entity.where(id: current_user.entities)
		else
			@entities = Entity.all
		end
		
		if @selected.nil?
			@categories = Category.includes(:entity).where(entity_id: @entities.first.id).page(params[:page])
		else
			@categories = Category.includes(:entity).where(entity_id: @selected).page(params[:page])
		end
		
		redirect_to categories_path if @entities.map {|o| o.id }.include? params[:entity]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: t("controller.message") }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
  
  # POST /categories/by_entity/1
  def by_entity
    @categories = Category.where(entity_id: params[:entity_id])
  end
end
