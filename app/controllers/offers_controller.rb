class OffersController < ApplicationController
	before_filter :login_required, :except => [:index, :show]
	
	filter_access_to [:new, :create]
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @offer = Offer.find_by_permalink!(params[:id]) }
  # GET /offers
  # GET /offers.xml
  def index
    @offers = Offer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offers }
    end
  end

  # GET /offers/1
  # GET /offers/1.xml
  def show
    @offer = Offer.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.xml
  def new
    @offer = Offer.new
		@offer.place_id = self.current_user.place_id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.xml
  def create
		@offer = Offer.new(params[:offer])
		@offer.user = self.current_user
    respond_to do |format|
      if @offer.save
        flash[:notice] = 'Offer was successfully created.'
        format.html { redirect_to(@offer) }
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.xml
  def update
		
    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        flash[:notice] = 'Offer was successfully updated.'
        format.html { redirect_to(@offer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.xml
  def destroy
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to(offers_url) }
      format.xml  { head :ok }
    end
  end

end
