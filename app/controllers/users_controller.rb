class UsersController < ApplicationController
  include AsJsonRepresentations
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate!

  # GET /users
  def index
    @users = User.filtrate(filtering_params)
                .sort(sort_params)
                .pagination_query(paginate_params)
    render json: @users.as_json(representation: :public)
  end

  # GET /users/1
  def show
    render json: @user.as_json(representation: :public)
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors.details, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :dni, :password)
  end

  def filtering_params
    params.permit({ filter: %i[name email] })[:filter]
  end

  def sort_params
    params.permit(:sort)[:sort]
  end

  def paginate_params
    params.permit({ page: %i[number size] })[:page]
  end
end
