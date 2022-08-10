class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      redirect_to root_path
    end
  end

  def confirm
    @contact = Contact.new(contact_params)
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :text, :email)
  end

end
