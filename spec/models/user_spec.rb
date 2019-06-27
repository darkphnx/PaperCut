require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  describe 'associations' do
    it { should have_many(:sessions) }
    it { should have_many(:events) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email_address) }
  end

  describe '.authenticate' do
    it 'finds a user by email address and password' do
      user = create(:user)
      authed_user = described_class.authenticate(user.email_address, user.password)
      expect(authed_user).to eq(user)
    end

    it 'returns falsey when a user cant be found' do
      user = create(:user)
      authed_user = described_class.authenticate("nope@example.org", user.password)
      expect(authed_user).to be_falsey
    end

    it 'returns falsey when a password is incorrect' do
      user = create(:user)
      authed_user = described_class.authenticate(user.email_address, 'nope')
      expect(authed_user).to be_falsey
    end
  end
end
