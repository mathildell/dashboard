class ExpensesController < ApplicationController
  require 'csv'
  before_action :pre_process
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    if params[:person]
      @owner = Person.find_by(name: params[:person].capitalize)
      @expenses = Expense.where(owner: @owner.id)
    end
  end

  # POST /expenses
  # POST /expenses.json
  # def create
  #   @expense = Expense.new(expense_params)
  #   respond_to do |format|
  #     if @expense.save
  #       format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
  #       format.json { render :show, status: :created, location: @expense }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @expense.errors, status: :unprocessable_entity }
  #    end
  #   end
  # end

  def import

    owner = params[:owner]
    file = params[:file_imported]
    import_from_csv(file, owner)

    redirect_to expenses_path
  end


  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  # def update
  #   respond_to do |format|
  #     if @expense.update(expense_params)
  #       format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @expense }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @expense.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


  def import_from_csv(file, owner)
    last_date_entry = (Expense.where(owner: owner).present?) ? Expense.where(owner: owner).order('date DESC').limit(1)[0].date : 0


    csv_text = File.read(file.tempfile)
    csv = CSV.parse(csv_text, :headers => false)
    objects = []
    csv.each do |row|

      expense_date = DateTime.parse(row[0])

      next if expense_date <= last_date_entry

      object = {
          date: expense_date,
          title: row[1],
          description: (row[2].blank?) ? row[1] : row[2],
          amount: row[3].to_f,
          is_splitwise: false,
          owner: owner
      }
      objects << object
    end

    Expense.create(objects)
    #Expense.where('description LIKE ? OR description LIKE ?', '%Transfer to Desjardins Student Cash Back Visa%', '%Bill payment - AccèsD - Internet /Remises pour étudiants Vis%').destroy_all

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :date)
  end

end
