class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories.includes(:expenses)
    @recent_expenses = Expense.most_recent(current_user).includes(:categories)
    @ancient_expenses = Expense.most_ancient(current_user).includes(:categories)
    @expenses = (@recent_expenses + @ancient_expenses).uniq
  end

  def all(_index)
    @expenses = Expense.all
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @user = current_user
    @expense = @user.expenses.new
  end

  def most_recent
    @expenses = current_user.expenses.order(created_at: :desc)
    render :index
  end

  def most_ancient
    @expenses = current_user.expenses.order(created_at: :asc)
    render :index
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses or /expenses.json
  def create
    @expense = current_user.expenses.new(expense_params.except(:category_ids))

    params[:expense][:category_ids].each do |category_id|
      next if category_id.empty?

      @expense.category_id = category_id.to_i
      @expense.group_entities.build(category_id: category_id.to_i)
    end

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_path(@expense), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_path, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :created_at, category_ids: [])
  end
end
