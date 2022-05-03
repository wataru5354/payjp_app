class UsersController < ApplicationController
  def show
    # 環境変数を読み込み、ユーザーid情報をもとにカード情報を取得
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id:current_user.id)

    reidrect_to new_card_path and return unless card.present?

    # カード情報から顧客情報を取得
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first # firstとはユーザーがクレジットカードを複数登録している場合、最初に登録したカード情報を取得できる
  end

  def update
    if current_user.update(user_params) # 更新出来たかを条件分岐する
      redirect_to root_path # 更新できたらrootパスへ
    else
      redirect_to action: "show" # 失敗すれば再度マイページへ
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end

end
