require 'csv'

class Submission < ApplicationRecord
  belongs_to :event

  has_many :submission_votes, dependent: :destroy
  has_many :voters, through: :submission_votes

  def self.by_popularity
    left_outer_joins(:submission_votes).group('submissions.id').order("SUM(submission_votes.weight) DESC")
  end

  def votes
    submission_votes.sum(:weight)
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
