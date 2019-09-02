class IncomesController < ApplicationController
  before_action :pre_process
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def index
    if params[:person]
      @owner = Person.find_by(name: params[:person].capitalize)
      @incomes = Income.where(owner: @owner.id)
    else
      @incomes = Income.all
    end
  end

  def new
    @income = Income.new
  end

  def import
    render 'incomes/import'
  end

  def import_func

    owner = params[:owner]
    file = params[:file_imported]
    import_from_csv(file, owner)

    redirect_to incomes_path
  end

  def edit
  end

  def create
    @income = Income.new(income_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to @income, notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to incomes_url, notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def import_from_csv(file, owner)
    last_date_entry = (Income.where(owner: owner).present?) ? Income.where(owner: owner).order('date DESC').limit(1)[0].date : 0

    # Income(origin: string, owner: string, amount: float, date: date)

    csv_text = File.read(file.tempfile)
    csv = CSV.parse(csv_text, :headers => false)
    objects = []
    csv.each do |row|

      expense_date = DateTime.parse(row[0])

      next if expense_date <= last_date_entry

      object = {
          date: expense_date,
          origin: row[1],
          title: row[2],
          amount: row[3].to_f,
          owner: owner
      }
      objects << object
    end

    Income.create(objects)
    #Income.where('description LIKE ? OR description LIKE ?', '%Transfer to Desjardins Student Cash Back Visa%', '%Bill payment - AccèsD - Internet /Remises pour étudiants Vis%').destroy_all

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_income
    @income = Income.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def income_params
    params.require(:income).permit(:owner, :origin, :title, :amount, :date)
  end

end
