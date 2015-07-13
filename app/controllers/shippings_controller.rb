# encoding: UTF-8

class ShippingsController < ApplicationController
  before_filter :authenticate_user!
	
	# GET /shippings
  # GET /shippings.json
  def index
		
		@selected = params[:entity];
		unless current_user.is_admin?
			@entities = Entity.where(id: current_user.entities)
		else
			@entities = Entity.all
		end
		
		@selected = @entities.first.id if @selected.nil?
		
		@shippings = Shipping.includes([:entity, :user]).where(entity_id: @selected).order('id DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shippings }
    end
  end

  # GET /shippings/1
  # GET /shippings/1.json
  def show
    @shipping = Shipping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shipping }
    end
  end

  # GET /shippings/new
  # GET /shippings/new.json
  def new
    @shipping = Shipping.new
		@entity = Entity.find(params[:entity_id])
		@categories = @entity.categories
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shipping }
    end
  end

  # GET /shippings/1/edit
  def edit
    @shipping = Shipping.find(params[:id])
		@entity = @shipping.entity
		@categories = Category.by_entity(@shipping.entity_id)
  end

  # POST /shippings
  # POST /shippings.json
  def create
    @shipping = Shipping.new(params[:shipping])
		@shipping.name = "#{"%02d" % Time.now.day}-#{"%02d" % Time.now.month}-#{Time.now.year.to_s}" if @shipping.name.empty?
		@shipping.user = current_user
    respond_to do |format|
      if @shipping.save
        format.html { redirect_to @shipping, notice: 'Shipping was successfully created.' }
        format.json { render json: @shipping, status: :created, location: @shipping }
      else
				@entity = @shipping.entity
				@categories = Category.by_entity(@shipping.entity_id)
				
        format.html { render action: "new" }
        format.json { render json: @shipping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shippings/1
  # PUT /shippings/1.json
  def update
    @shipping = Shipping.find(params[:id])

    respond_to do |format|
      if @shipping.update_attributes(params[:shipping])
        format.html { redirect_to @shipping, notice: 'Shipping was successfully updated.' }
        format.json { head :no_content }
      else
				@entity = @shipping.entity
				@categories = Category.by_entity(@shipping.entity_id)
				
        format.html { render action: "edit" }
        format.json { render json: @shipping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shippings/1
  # DELETE /shippings/1.json
  def destroy
    @shipping = Shipping.find(params[:id])
    @shipping.destroy

    respond_to do |format|
      format.html { redirect_to shippings_url }
      format.json { head :no_content }
    end
  end

	def check_source_url
		require 'open-uri'
		require 'nokogiri'
		
		response = {}
		uri = URI(params[:url])
		#url: "#{uri.scheme}://#{uri.host}"
		source = Source.where("POSITION(url IN ?) <> 0", "#{uri.scheme}://#{uri.host}")
		
		if source.present?
			response[:source] = source[0].name
			response[:source_url] = "#{uri.scheme}://#{uri.host}"
			
			doc = Nokogiri::HTML(open(params[:url]).read)
			
		  doc.css(source[0].title_reg).each do |elem|
		    response[:title] = elem.content.strip
		  end
			
		  doc.css(source[0].short_content_reg).each do |elem|
		    response[:short_content] = elem.content.strip
		  end
		end
		
		respond_to do |format|
			format.json {render json: response}
		end
	end
	
	def send_demo
		shipping = Shipping.find(params[:shipping_id])
		ReceiverMailer.clipping_email(shipping, current_user.email).deliver
    #SenderWorker.perform_async(shipping, current_user.email)
    flash[:notice] = 'El mail de demostración fue enviado.'
		redirect_to action: 'index', entity: shipping.entity_id
	end
	
	def send_mails
    shipping = Shipping.find(params[:shipping_id])
		shipping.entity.receivers.each do |receiver|
			ReceiverMailer.clipping_email(shipping, receiver.mail_style).deliver
      #SenderWorker.perform_async(shipping, current_user.email)
			shipping.receivers << receiver
		end
    shipping.individuals.split(",").each do |individual|
      ReceiverMailer.clipping_email(shipping, individual).deliver
    end
    flash[:notice] = 'Los mails fueron enviados a los recipientes.'
		redirect_to action: 'index', entity: shipping.entity_id
	end
end
