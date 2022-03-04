# frozen_string_literal: true

class User < ApplicationRecord
  has_paper_trail
  def self.to_csv(errors)
    CSV.generate do |csv|
      csv << %w[row username phone description error]
      errors.each do |error|
        # error.delete('row')
        # error.delete('error')
        csv << error.values
      end
    end
  end
  # has_one_attached :csv
  has_many :posts
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def name
    username
  end
end
