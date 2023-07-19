require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it 'should save successfully when all fields are set' do
      product = Product.new(
        name: 'Pine',
        price: 9.99,
        quantity: 10,
        category: Category.new(name: 'Evergreens')
      )
      expect(product.save).to be true
    end


    it 'should not save when name is not set' do
      product = Product.new(
        price: 9.99,
        quantity: 10,
        category: Category.new(name: 'Evergreens')
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Name can't be blank")
    end


    it 'should not save when price is not set' do
      product = Product.new(
        name: 'Pine',
        quantity: 10,
        category: Category.new(name: 'Evergreens')
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Price can't be blank")
    end


    it 'should not save when quantity is not set' do
      product = Product.new(
        name: 'Test Product',
        price: 9.99,
        category: Category.new(name: 'Evergreens')
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save when category is not set' do
      product = Product.new(
        name: 'Pine',
        price: 9.99,
        quantity: 10
      )
      expect(product.save).to be false
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end