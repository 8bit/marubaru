class ReviewsController < ApplicationController

  load_and_authorize_resource

  before_filter :grab_thing
  before_filter :lookup_review

  
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new
    @review.ob_score = 5
    @review.sub_score = 5

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    #unless @other_review.blank?
    #  @other_review.update_attributes(params[:review])
    #  render action: "edit"
    #else
      @review = @thing.reviews.new(params[:review])
      @review.user = current_user

      respond_to do |format|
        if @review.save
          format.html { redirect_to @review, notice: 'Review was successfully created.' }
          format.json { render json: @review, status: :created, location: @review }
        else
          format.html { render action: "new" }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      end
    #end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    unless @other_review.blank?
      @review = @other_review
    end

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

  private

  def grab_thing
    if params[:thing_id]
      @thing = Thing.find(params[:thing_id])
    end
  end

  def lookup_review
    @other_review = Review.where(user: current_user, thing: @thing, :created_at.gte => Date.today).first
  end

end
