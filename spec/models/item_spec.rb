require 'rails_helper'

describe Item do
  describe '#create' do
    # 1
    it "brand以外が全て入力されていればOK" do
      item = build(:item)
      expect(item).to be_valid
    end

    # 2
    it "nameがない場合NG" do
      item = build(:item, name: nil)
      item.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    # 3
    it "item_explanationがない場合NG" do
      item = build(:item, item_explanation: nil)
      item.valid?
      expect(item.errors[:item_explanation]).to include("を入力してください")
    end

    # 4
    it "priceがない場合NG" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    # 5
    it "priceがinteger以外ならNG" do
      item = build(:item, price: "300")
      item.valid?
      expect(item.errors[:price]).to include("は数字で入力してください")
    end

    # 6
    it "priceが300円未満ならNG" do
      item = build(:item, price: "290")
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値を入力してください")
    end

    #7
    it "priceが9999999以上ならNG" do
      item = build(:item, price: "99999990")
      item.valid?
      expect(item.errors[:price]).to include("は9999999以下の値を入力してください")
    end
  end
end