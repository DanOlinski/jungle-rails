require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid" do
      @product = Product.new
      @cat = Category.new
      @cat.name = 'Test'
      @product.name = 'Test' #invalid state
      @product.price_cents = 12311
      @product.quantity = 3
      @product.category = @cat
      expect(@product.valid?).to be true
    end
    
  end
end
