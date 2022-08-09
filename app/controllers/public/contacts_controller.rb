class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new
    if @inquiry.save
      ContactMailer.send_mail(@contact).deliver
      redirect_to root_path
    end
  end
end
