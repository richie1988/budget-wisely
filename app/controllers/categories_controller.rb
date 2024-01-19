class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[new create]
  before_action :set_category, only: %i[show edit update destroy]

  def index
    # @user = User.find(params[:user_id])
    @categories = Category.includes(:expenses).where(user_id: current_user.id)
  end

  # GET /categories/1 or /categories/1.json
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
  end

  # GET /categories/new
  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /users/1/categories or /categories.json
  def create
    @category = Category.new(category_params)
    @category.user = @user

    if params[:category][:icon]
      uploaded_io = params[:category][:icon]
      @category.icon_data = uploaded_io.read
    end

    respond_to do |format|
      if @category.save
        format.html { redirect_to user_category_url(@user, @category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = current_user
    return if @user

    store_location
    redirect_to new_user_session_path, alert: 'You need to sign in or sign up before continuing.'
  end

  def store_location
    session[:return_to] = request.fullpath if request.get?
  end

  def after_sign_in_path_for(resource)
    session[:return_to] || super
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :user_id, :icon_data)
  end
end
