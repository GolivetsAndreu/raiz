class PaymentController < ApplicationController
  def index
    @users = User.all
    @teems = Teem.all
  end

  def transaction
    byebug
  end
end
