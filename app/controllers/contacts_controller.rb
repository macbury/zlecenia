class ContactsController < ApplicationController
	before_filter :login_required, :find_offer
	
	def new
		@contact = @offer.contacts.new(params[:contact])
	end
	
  def create
    @contact = @offer.contacts.new(params[:contact])
    if verify_recaptcha(:model => @contact, :message => 'błędny kod') && @contact.save
      flash[:notice] = "Successfully created contact."
      redirect_to @offer
    else
      render :action => 'new'
    end
  end

	protected
		
		def find_offer
			@offer = Offer.find_by_permalink!(params[:offer_id])
		end
end
