class BillsController < ApplicationController
  include AsJsonRepresentations
  before_action :set_bill, only: %i[show update destroy]
  before_action :authenticate!

  # GET /bills

  def index
    @bills = authorized_scope(Bill.filter_by(filtering_params)
                 .sort_by(sort_params)
                 .paginate_by(paginate_params),
                              user: current_user)
    authorize @bills
    render json: @bills.as_json(representation: :public)
  end

  # GET /bills/1

  def show
    authorize @bill, user: current_user
    render json: @bill.as_json(presentation: :public)
  end

  # POST /bills

  def create
    @bill = Bill.new(bill_params)
    authorize @bill, user: current_user
    @bill.eraser!
    if @bill.save
      render json: @bill, status: :created, location: @bill
    else
      render json: @bill.errors.details, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bills/1

  def update
    authorize @bill, user: current_user
    if @bill.update(bill_params)
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bills/1

  def destroy
    authorize @bill, user: current_user
    @bill.destroy
  end

  def check_valid_params
    raise(RailsAuthorize::NotAuthorizedError) if check_validated_by_client
    raise(RailsAuthorize::NotAuthorizedError) if check_admin_update_params
  end

  def check_validated_by_client
    (bill_params[:status] == 'validated') && !current_user.has_role?(:client, Bill)
  end

  def check_admin_update_params
    return false unless only_status_in_params && current_user.has_role?(:admin, Bill)

    true
  end

  def only_status_in_params
    bill_params.key?('number') ||
      bill_params.key?('expdate') ||
      bill_params.key?('user_id') ||
      bill_params.key?('tipe') ||
      bill_params.key?('nifreceiver') ||
      bill_params.key?('niftransmiter') ||
      bill_params.key?('concept') ||
      bill_params.key?('totalcount')
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_bill
    @bill = Bill.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  
  def bill_params
    params.require(:bill).permit(:number, :expdate, :tipe, :niftransmitter,
                                 :nifreceiver, :concept, :totalcount, :user_id, :picture)
  end

  def filtering_params
    params.permit({ filter: %i[number concept id higher_than_expdate lower_than_expdate] })
  end

  def sort_params
    params.permit(:sort)
  end

  def paginate_params
    params.permit({ page: %i[number size] })
  end
end
