require 'rails_helper'

describe Creditcard do
  describe '#create' do
    it "user_id, customer_id, card_idがあれば有効であること" do
      user = create(:user)
      card = build(:creditcard, user_id: user[:id])
      expect(card).to be_valid
    end
  
    it "user_idがない場合は無効であること" do
      card = build(:creditcard, user_id: nil)
      card.valid?
      expect(card.errors[:user]).to include("を入力してください")
    end
    
    it "customer_idがない場合は無効であること" do
      card = build(:creditcard, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    
    it "card_idがない場合は無効であること" do
    card = build(:creditcard, card_id: nil)
    card.valid?
    expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end