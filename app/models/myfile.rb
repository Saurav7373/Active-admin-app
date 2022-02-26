# frozen_string_literal: true

class Myfile < ApplicationRecord
  include ImageUploader::Attachment(:image)
  validates :title, presence: true
end
