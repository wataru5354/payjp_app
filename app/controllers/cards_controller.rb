class CardsController < ApplicationController
  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    # Customerオブジェクトを使用する
    customer = Payjp::Customer.create(
      description: 'test', #テストカード
      card: params[:card_token] #登録するカード情報
    )
    card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id, #顧客トークン
      user_id: current_user.id
    )
    if card.save
      redirect_to root_path
    else
      redirect_to action: "new"
    end
  end
end
