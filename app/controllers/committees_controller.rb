class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]

  # GET /committees
  # GET /committees.json
  def index
    @committees = Committee.all
    @members = Member.all
  end

  # GET /committees/1
  # GET /committees/1.json
  def show
  end

  # GET /committees/new
  def new
    @committee = Committee.new
    @all_members = Member.all
    @committee_member = @committee.membercommittees.build
  end

  # GET /committees/1/edit
  def edit
    @committee = Committee.new
    @all_members = Member.all
    @committee_member = @committee.membercommittees.build
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)
    params[:members][:id].each do |member|
      if :member.empty?
        @committee.membercommittees.build(:member_id => member)
      end
    end
    respond_to do |format|
      if @committee.save
        format.html { redirect_to @committee, notice: 'El comité fue creado.' }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to @committee, notice: 'El comité ha sido actualizado.' }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url, notice: 'El comité ha sido eliminado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def committee_params
      params.require(:committee).permit(:nombre, :descripcion, :baner, :logo, :member_id)
    end
end
