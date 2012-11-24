class TypesController < ApplicationController
  load_and_authorize_resource
  # GET /types
  # GET /types.json
  def index
    @types = Type.all

    respond_to do |format|
      format.html # index.html.erb
      if false
        format.json { render json: @types.any_of({ :name => /.*#{params[:q]}.*/i }) }
      else
        format.json { render json: @types.lookup(params[:q]) }
      end
    end
  end 

  # GET /types/1
  # GET /types/1.json
  def show
    @type = Type.find(params[:id])
    @things = @type.things

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @type }
    end
  end

  # GET /types/new
  # GET /types/new.json
  def new
    @type = Type.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @type }
    end
  end

  # GET /types/1/edit
  def edit
    @type = Type.find(params[:id])
    query = @type.name
    look_for(query)    
  end

  # POST /types
  # POST /types.json
  def create
    @type = Type.new(params[:type])
    the_name = @type.name

    if the_name.empty?
      redirect_to types_path, notice: 'Type a little, pick something from the list, hit the button!'
    else
      old_name = Type.where({name: @type.name}).first

      if old_name
        redirect_to old_name
      else

        the_name.slice! 'New: "'
        the_name.chop!
        the_name.capitalize!
        @type.name = the_name
        @type.owner = current_user

        
        respond_to do |format|
          if @type.save
            format.html { redirect_to edit_type_path(@type), notice: "Congrats! Your the first to reveiw a #{@type.name}, what is it?" }
            format.json { render json: @type, status: :created, location: @type }
          else
            format.html { render action: "new" }
            format.json { render json: @type.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PUT /types/1
  # PUT /types/1.json
  def update
    @type = Type.find(params[:id])

    respond_to do |format|
      if @type.update_attributes(params[:type])
        format.html { redirect_to @type, notice: 'Type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1
  # DELETE /types/1.json
  def destroy
    @type = Type.find(params[:id])
    @type.destroy

    respond_to do |format|
      format.html { redirect_to types_url }
      format.json { head :no_content }
    end
  end

  def look_for(query)
    query.gsub!(' ','_')
    url = "http://en.wikipedia.org/wiki/#{query}"
    
    begin
      data = Nokogiri::HTML(open(url))
    rescue OpenURI::HTTPError
      #do something to handle error
    else
      @temp_title = data.at_css('#firstHeading').text unless data.at_css('#firstHeading').nil?
      @temp_description = data.at_css('table~p').text unless data.at_css('table~p').nil?
      @temp_image = data.at_css('.image img')[:src] unless data.at_css('.image img').nil?
      @temp_image.slice!(0,2) unless @temp_image.nil?
    end
    
  end
end
