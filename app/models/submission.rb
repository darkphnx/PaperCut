require 'csv'

class Submission < ApplicationRecord
  belongs_to :event

  has_many :submission_votes, dependent: :destroy
  has_many :voters, through: :submission_votes

  scope :by_random, ->(seed) { order(Arel.sql("rand(#{seed})")) }
  scope :shortlisted, -> { where(shortlisted: true) }
  scope :not_shortlisted, -> { where(shortlisted: false) }

  def self.by_popularity
    left_outer_joins(:submission_votes).group('submissions.id').order(Arel.sql("AVG(submission_votes.weight) DESC"))
  end

  def votes
    submission_votes.sum(:weight)
  end

  def average_rating
    submission_votes.average(:weight)
  end

  def self.from_csv(event, csv_io)
    csv = CSV.new(csv_io, headers: true, return_headers: false)

    csv.each do |row|
      create! do |submission|
        submission.event = event
        submission.created_at = row[0]
        submission.email_address = row[1].force_encoding('utf-8')
        submission.biography = row[2].force_encoding('utf-8')
        submission.first_time_speaker = row[3] == "Yes"
        submission.talk_length_in_minutes = row[4].to_i
        submission.title = row[5].force_encoding('utf-8')
        submission.abstract = row[6].force_encoding('utf-8')
      end
    end
  end
end
