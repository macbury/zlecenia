class OffersController < ApplicationController
	before_filter :login_required, :except => [:index, :show]

	filter_access_to [:new, :create]
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @offer = Offer.find_by_permalink!(params[:id]) }
	
	before_filter :need_enter_company_information, :except => [:index, :show]
  # GET /offers
  # GET /offers.xml
  def index
    @offers = Offer.paginate	:conditions => { :end_at.gte => Date.current },
															:page => params[:page], 
															:per_page => 30,
															:order => "created_at DESC"

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
		render :action => "new"
  end

  # POST /offers
  # POST /offers.xml
  def create
		@offer = Offer.new(params[:offer])
		@offer.user = self.current_user
    respond_to do |format|
      if @offer.save
        flash[:notice] = 'Oferta została dodana'
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
        flash[:notice] = 'Zapisano zmiany w ofercie'
        format.html { redirect_to(@offer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
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
	
	protected
		def need_enter_company_information
			if self.current_user.company.nil?
				flash[:error] = "Brak danych w profilu"
				redirect_to settings_path
			end
		end
end
