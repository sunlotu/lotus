class RoleShipsController < ApplicationController
  before_action :set_role_ship, only: [:show, :edit, :update, :destroy]

  # GET /role_ships
  # GET /role_ships.json
  def index
    @role_ships = RoleShip.all
  end

  # GET /role_ships/1
  # GET /role_ships/1.json
  def show
  end

  # GET /role_ships/new
  def new
    @role_ship = RoleShip.new
  end

  # GET /role_ships/1/edit
  def edit
  end

  # POST /role_ships
  # POST /role_ships.json
  def create
    @role_ship = RoleShip.new(role_ship_params)

    respond_to do |format|
      if @role_ship.save
        format.html { redirect_to @role_ship, notice: 'Role ship was successfully created.' }
        format.json { render :show, status: :created, location: @role_ship }
      else
        format.html { render :new }
        format.json { render json: @role_ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_ships/1
  # PATCH/PUT /role_ships/1.json
  def update
    respond_to do |format|
      if @role_ship.update(role_ship_params)
        format.html { redirect_to @role_ship, notice: 'Role ship was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_ship }
      else
        format.html { render :edit }
        format.json { render json: @role_ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_ships/1
  # DELETE /role_ships/1.json
  def destroy
    @role_ship.destroy
    respond_to do |format|
      format.html { redirect_to role_ships_url, notice: 'Role ship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_ship
      @role_ship = RoleShip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_ship_params
      params.require(:role_ship).permit(:user_id, :role_id)
    end
end
