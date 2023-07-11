require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid" do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test2@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end
    
    it "password don't match" do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test2@test.com',
        password: 'password',
        password_confirmation: 'pass'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
  end

  it 'is not valid without an email' do
    user = User.new(
      first_name: 'first_name',
        last_name: 'last_name',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
    )
    expect(user).to be_invalid
  end

  it 'is not valid without first_name' do
    user = User.new(
      first_name: nil,
        last_name: 'last_name',
        email: 'test2@test.com',
        password: 'password',
        password_confirmation: 'password'
    )
    expect(user).to be_invalid
  end

  it 'is not valid without last_name' do
    user = User.new(
      first_name: 'first_name',
        last_name: nil,
        email: 'test2@test.com',
        password: 'password',
        password_confirmation: 'password'
    )
    expect(user).to be_invalid
  end

  it 'is not valid without password' do
    user = User.new(
      first_name: 'first_name',
        last_name: 'last_name',
        email: 'test2@test.com',
        password: nil,
        password_confirmation: 'password'
    )
    expect(user).to be_invalid
  end
  
  it 'email must be unique' do
    user = User.new
    user.first_name = 'first_name'
    user.last_name = 'last_name'
    user.email = 'test@test.com'
    user.password = 'password'
    user.password_confirmation = 'password'

    user.save
  
    u = User.new
    u.first_name = 'first_name'
    u.last_name = 'last_name'
    u.email = 'test@test.com'
    u.password = 'password'
    u.password_confirmation = 'password'
    u.save
  
    expect(u.errors[:email].first).to eq('has already been taken')
  end

  it 'password length less than 5 characters is invalid' do
    user = User.new
    user.first_name = 'first_name'
    user.last_name = 'last_name'
    user.email = 'test@test.com'
    user.password = '1234'
    user.password_confirmation = '1234'
    expect(user).to be_invalid
  end

  end


  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).not_to be(nil)
    end

    it 'should not pass with invalid credentials' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', 'pass')
      expect(user).to be(nil)
    end

    it 'should pass even with spaces present in email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(user).not_to be(nil)
    end

    it 'should pass even with caps present in email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('tesT@tEst.com', 'password')
      expect(user).not_to be(nil)
    end
  end

end

