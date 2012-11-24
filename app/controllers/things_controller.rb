class ThingsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  
  load_and_authorize_resource

  before_filter :grab_type
  # GET /things
  # GET /things.json
  def index
    @things = Thing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things.lookup(params[:q]) }
    end
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @thing = Thing.find(params[:id])
    @reviews = @thing.reviews

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/new
  # GET /things/new.json
  def new
    @thing = Thing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thing }
    end
  end

  # GET /things/1/edit
  def edit
    @thing = Thing.find(params[:id])
    query = @thing.name
    look_for(query)  
  end

  # POST /things
  # POST /things.json
  def create
    @thing = @type.things.new(params[:thing])
    the_name = @thing.name

    if the_name.empty?
      redirect_to :back, notice: 'Type a little, pick something from the list, hit the button!'
    else
      old_name = Thing.where({name: @thing.name}).first
      
      if old_name
        redirect_to old_name
      else

        the_name.slice! 'New: "'
        the_name.chop!
        @thing.name = the_name
        @thing.owner = current_user

        respond_to do |format|
          if @thing.save
            format.html { redirect_to edit_thing_path(@thing), notice: "The #{@thing.type.name} #{@thing.name} was successfully created." }
            format.json { render json: @thing, status: :created, location: @thing }
          else
            format.html { render action: "new" }
            format.json { render json: @thing.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PUT /things/1
  # PUT /things/1.json
  def update
    @thing = Thing.find(params[:id])

    respond_to do |format|
      if @thing.update_attributes(params[:thing])
        format.html { redirect_to new_thing_review_path(@thing), notice: 'Thing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing = Thing.find(params[:id])
    type = @thing.type
    @thing.destroy

    respond_to do |format|
      format.html { redirect_to type_path(type) }
      format.json { head :no_content }
    end
  end

  private

  def grab_type
    if params[:type_id]
      @type = Type.find(params[:type_id])
    end
  end

  def look_for(query)
    query.gsub!(' ','_')
    url = "http://en.wikipedia.org/wiki/#{query}"
    query.gsub!('_',' ')
    
    begin
      data = Nokogiri::HTML(open(url))
    rescue OpenURI::HTTPError
       @temp_title = "We don't know about the #{@thing.type.name}: #{@thing.name}"
       @temp_description = "Really what is that?"
    else
      @temp_title = data.at_css('#firstHeading').text unless data.at_css('#firstHeading').nil?
      @temp_description = data.at_css('table~p').text unless data.at_css('table~p').nil?
      @temp_image = data.at_css('.image img')[:src] unless data.at_css('.image img').nil?
      @temp_image.slice!(0,2) unless @temp_image.nil?

    end

  end
end
