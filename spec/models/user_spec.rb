require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should save successfully when password and password_confirmation field are set' do
      user = User.create(
        email: 'test@123.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to be true
    end

    it 'should have matching password and password_confirmation fields' do
      user = User.create(
        email: 'test@gmail.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'another_password'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should have a password when created' do
      user = User.create(
        email: 'test@gmail.com',
        first_name: 'John',
        last_name: 'Doe'

        
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end


    it 'should have a password_confirmation when created' do
      user = User.create(
        email: 'test@gmail.com',
        first_name: 'John',
        last_name: 'Doe',
        password: "password",
        password_confirmation: " "
        
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should have a unique email (case-insensitive)' do
      user1 = User.create(
        email: 'test@gmail.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      user2 = User.create(
        email: 'TEST@gmail.com',
        first_name: 'Jane',
        last_name: 'Smith',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user2.save).to be false
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require email, first name, and last name' do
      user = User.create(
        email: ' ',
        first_name: ' ',
        last_name: ' ',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'password should have a minimum length of 8 characters' do
      user = User.create(
        email: 'test@789.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'passwor',  # Password length is less than 8 characters
        password_confirmation: 'passwor'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    user =  User.create(
      first_name: 'John',
      last_name: 'Doe',
      email: 'test@1.com', 
      password: 'password123', 
      password_confirmation: 'password123')

    it 'should return the user if credentials are valid' do
      authenticated_user = User.authenticate_with_credentials('test@1.com', 'password123')
      expect(authenticated_user.email).to eq(user.email)
    end

    it 'should return nil if email is incorrect' do
      authenticated_user = User.authenticate_with_credentials('wrong_email@example.com', 'password123')
      expect(authenticated_user).to be_nil
    end

    it 'should return nil if password is incorrect' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'should ignore leading and trailing whitespaces in email' do
      authenticated_user = User.authenticate_with_credentials('  test@1.com  ', 'password123')
      expect(authenticated_user.email).to eq(user.email)
    end

    it 'should be case-insensitive for email' do
      authenticated_user = User.authenticate_with_credentials('TeSt@1.com', 'password123')
      expect(authenticated_user.email).to eq(user.email)
    end

    it 'should return nil for non-existing email' do
      authenticated_user = User.authenticate_with_credentials('non_existent@example.com', 'password123')
      expect(authenticated_user).to be_nil
    end

  end
end

