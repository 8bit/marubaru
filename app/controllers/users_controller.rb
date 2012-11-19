class UsersController < ApplicationController
  # GET /types
  # GET /types.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /types/1
  # GET /types/1.json
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews

    if @reviews.length > 0
      
      @ob_score = 0
      @sub_score = 0
      @tot_score = 0
      @review_count = @reviews.length

      @reviews.each do |r|
        @ob_score += r.ob_score.to_i
        @sub_score += r.sub_score.to_i
        @tot_score += (r.sub_score.to_i + r.ob_score.to_i)
      end

      @ob_score = @ob_score / @review_count
      @sub_score = @sub_score / @review_count
      @tot_score = @tot_score / @review_count
    end



    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
