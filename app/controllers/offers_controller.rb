class OffersController < ApplicationController
	before_filter :login_required, :except => [:index, :show, :suggest_tag]

	filter_access_to [:new, :create]
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @offer = Offer.find_by_permalink!(params[:id]) }
	
	before_filter :need_enter_company_information, :except => [:index, :show]
  # GET /offers
  # GET /offers.xml
  def index
		query = Offer.search
		includes = [:user, :place]
		
		options = {
								:page => params[:page], 
								:per_page => 30,
								:order => "created_at DESC",
								:include => includes
							}
		
		query.end_at_greater_than_or_equal_to(Date.current)
		query.etat_equals(params[:etat]) if params[:etat]
		query.place_id_equals(params[:place]) if params[:place]
		
		if params[:type]
			type = OFFER_TYPES.map{ |type| PermalinkFu.escape(type) }.index(params[:type])
			query.type_id_equals(type)
		end

		if !params[:tags].nil? && params[:tags].length > 0
			includes << :tags
			query.tags_name_equals(params[:tags].split(' ').map(&:downcase)) 
		end
		
		if params[:nearest]
			#includes << :geocoding
			options.merge!({
				:within => 100,
				:origin => params[:nearest]
			})
		end
		
    @offers = query.paginate(options)
		
		@places = query.all 			:select => "count(offers.place_id) as offers_count, places.*",
															:joins => :place,
															:group => Place.column_names.map{|c| "places.#{c}"}.join(','),
															:order => "places.name"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offers }
			format.rss
    end
  end
	
	def suggest_tag
		@tags = Tag.name_like(params[:tag])
		
		render :json => @tags.map(&:name)
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
