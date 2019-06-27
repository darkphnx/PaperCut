FactoryBot.define do
  factory :submission_vote do
    submission
    voter
    weight { 3 }
  end
end
