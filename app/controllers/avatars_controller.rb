class AvatarsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_avatar, only: %i[ show edit destroy ]

  # GET /avatars or /avatars.json
  def index
    @avatars = Avatar.all
  end

  # GET /avatars/1 or /avatars/1.json
  def show
  end

  # GET /avatars/new
  def new
    @avatar = Avatar.new
  end

  # GET /avatars/1/edit
  def edit
  end

  # POST /avatars or /avatars.json
  def create
    @avatar = Avatar.new(avatar_params)
    @avatar.user_id = current_user.id
    if @avatar.save
      redirect_to user_path(@avatar.user_id)
    else
      render :new
    end
  end

  # PATCH/PUT /avatars/1 or /avatars/1.json
  def update
    @avatar = Avatar.find(params[:id])
    @avatar.user_id = current_user.id
    if @avatar.update(avatar_params)
        redirect_to user_path(@avatar.user_id)
      else
        render :edit
      end
  end

  # DELETE /avatars/1 or /avatars/1.json
  def destroy
    @avatar.destroy

    respond_to do |format|
      format.html { redirect_to avatars_url, notice: "Avatar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avatar
      @avatar = Avatar.find_by(user_id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def avatar_params
      params.require(:avatar).permit(:image, :user_id, :image_cache)
    end
end
