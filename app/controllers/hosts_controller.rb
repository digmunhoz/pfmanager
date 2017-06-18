class HostsController < ApplicationController
  require 'http'
  require 'nokogiri'  
  before_action :authenticate_user!
  before_action :set_host, only: [:show, :edit, :update, :destroy]

  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.all
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
  end

  # GET /hosts/new
  def new
    @host = Host.new
  end

  # GET /hosts/1/edit
  def edit

  end

  def check
    begin
      check = HTTP.timeout(:write => 2, :connect => 2, :read => 2).get host_params[:address]
    rescue Exception => e
      logger.warn e.message
      render html: "<script>alert('#{e.message}')</script><script>history.back()</script>".html_safe
      return
    end    
  end

  def connect
    begin
      http = HTTP.persistent host_params[:address]
      page = Nokogiri::HTML(open("#{host_params[:address]}/index.php", :read_timeout => 2, :open_timeout => 2))
      token = page.css('form input')[0]['value']
      auth = HTTP.timeout(:write => 2, :connect => 2, :read => 2).post("#{host_params[:address]}/system_advanced_admin.php", :form => {:usernamefld => host_params[:username], :passwordfld => host_params[:password], :login => "", :__csrf_magic => token })
      code = auth.code
      if code == "200"
        http.close
        logger.warn "Fail to authenticate on host #{host_params[:address]}"
        render html: "<script>alert('#{code} Fail to authenticate on host #{host_params[:address]}.')</script><script>history.back()</script>".html_safe
        return 
      end
      HTTP.get("#{host_params[:address]}/index.php", :params => {:logout => ""})
      http.close      
    rescue Exception => e
      logger.warn e.message
      render html: "<script>alert('#{e.message}')</script><script>history.back()</script>".html_safe
      return      
    end
  end

  def test_conn
    check
    connect
  end

  def create
    if check.nil? || connect.nil?
      return
    end
    @host = Host.new(host_params)
    respond_to do |format|
      if @host.save
        format.html { redirect_to hosts_path}
        format.json { render :show, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end      
    end
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
    if check.nil? || connect.nil?
      return
    end    
    respond_to do |format|
      if @host.update(host_params)
        format.html { redirect_to hosts_path}
        format.json { render :show, status: :ok, location: @host }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host.destroy
    respond_to do |format|
      format.html { redirect_to hosts_url, notice: 'Host was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host
      @host = Host.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_params
      params.require(:host).permit(:name, :address, :username, :password)
    end
end