require 'rails_helper'

RSpec.describe Voter, type: :model do
  describe 'associations' do
    it { should have_many(:submission_votes) }
    it { should have_many(:submissions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email_address) }
  end
end
