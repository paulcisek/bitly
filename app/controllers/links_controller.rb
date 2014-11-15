class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :set_links, only: [:new, :create]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
    @link_to_show = session[:short_link].nil? ? nil : [Link.find_by(short_link: session[:short_link])]
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.find_by(long_link: params[:link][:long_link]) || @link = Link.create(link_params)
    if @link.new_record?
      @link.short_link = root_url+Link.generate_encoded_string
    end
    if current_user.nil? == false
      if current_user.links.include?(@link) == false
        current_user.links << @link
      end
    else
      session[:short_link] = @link.short_link
    end

    respond_to do |format|
      if @link.save
        format.html { redirect_to root_url}
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect_to_route
    link = Link.find_by(short_link: root_url+params[:id])
    if link.nil?
      redirect_to root_url, alert: "We are sorry but link wasn't found"
    else
      redirect_to link.long_link
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    def set_links
      current_user.nil? ? @links = [] : @links = current_user.links.order('id DESC').paginate(:page => params[:page], :per_page => 5)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:long_link, :short_link)
    end
end
