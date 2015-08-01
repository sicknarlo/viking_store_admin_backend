class Admin::CategoriesController < AdminController

  def index
    @categories = Category.order(:id => :asc)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(whitelisted_params)
    if @category.save
      flash[:success] = "New Category Created"
      redirect_to [:admin, categories_path]
    else
      flash[:error] = @category.errors.full_messages.first
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(whitelisted_params)
      flash[:success] = "Category Updated"
      redirect_to [:admin, categories_path]
    else
      flash[:error] = @category.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "Category Deleted"
      redirect_to [:admin, categories_path]
    else
      flash[:error] = @category.errors.full_messages.first
      render :edit
    end
  end

  private

  def whitelisted_params
    params.require(:category).permit(:name, :description)
  end

end
