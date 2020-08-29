require 'rails_helper'

describe ItemsController do
  describe 'GET #new' do
    it "出品ページに遷移するか" do
      get :new
      expect(response).to render_template :new
    end
  end
  describe 'POST #create' do
    context 'can save' do
      it '商品が正しく登録されるか' do
        category = create(:category)
        expect do
          post :create, params: { item: FactoryBot.attributes_for(:item) }
        end.to change(Item, :count).by(1)
      end
    end
    context 'can not save' do
      it '商品が正しく登録されないかどうか' do
        expect do
          post :create, params: { item: FactoryBot.attributes_for(:item, :invalid) }
        end.to_not change(Item, :count)
      end
    end
  end

  describe "GET #index" do
    it "期待するビューに変遷するか？" do
      get :index
      expect(response).to render_template :index
    end
  end
end