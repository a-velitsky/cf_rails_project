class StaticPagesController < ApplicationController
	def index
  	redirect_to static_pages_landing_page_path
  end

  def landing_page
  	@featured_product = Product.first
  	@products = Product.limit(3)
  end

  def thank_you
  	@name = params[:name]
  	@email = params[:email]
 	 	@message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver_now 
  end
end
