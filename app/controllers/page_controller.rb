class PageController < ApplicationController

  before_filter :setup_negative_captcha, :only => [:contacts, :send_mail]

  def page
    @page = Page.get_page(params[:page])
    render "/pages/#{params[:page]}"
  end

  def contacts
    @message = ContactMessage.new
    page
  end

  def send_mail
    @message = ContactMessage.new(@captcha.values) #Decrypted params
    if @captcha.valid? && @message.valid?
      @error = ContactMailer.contact_message(@message).deliver
      redirect_to '/contacts/mail-sent'
    else
      @page = Page.get_page('contacts')
      render 'pages/contacts'
    end
  end

  private
  # Initialize contact form  captcha
  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
      :secret => ENV['NEGATIVE_CAPTCHA_SECRET'], #A secret from environment.rb
      :spinner => request.remote_ip,
      :fields => [:name, :email, :content], #Whatever fields are in your form
      :params => params
    )
  end
end
