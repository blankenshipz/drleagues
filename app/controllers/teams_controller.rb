class TeamsController < ApplicationController
  before_action :set_league
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = @league.teams_by_top_model
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = @league.teams.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @league = League.find(params[:league_id])
    @team = @league.teams.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to league_team_path(@league, @team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to league_team_path(@league, @team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_league
      @league = League.find(params[:league_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = @league.teams.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
