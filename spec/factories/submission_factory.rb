FactoryBot.define do
  factory :submission do
    event
    title { "Long Way Round" }
    email_address { "cboorman@example.org" }
    biography { "Charlie is an actor and adventurer" }
    abstract { "Two blokes travel around the world on BMW R1150GS'" }

    trait :low_rated do
      after(:create) do |submission, evaluator|
        create(:submission_vote, submission: submission, weight: 1)
        create(:submission_vote, submission: submission, weight: 2)
      end
    end

    trait :medium_rated do
      after(:create) do |submission, evaluator|
        create(:submission_vote, submission: submission, weight: 3)
        create(:submission_vote, submission: submission, weight: 2)
      end
    end

    trait :high_rated do
      after(:create) do |submission, evaluator|
        create(:submission_vote, submission: submission, weight: 4)
        create(:submission_vote, submission: submission, weight: 5)
      end
    end
  end
end
