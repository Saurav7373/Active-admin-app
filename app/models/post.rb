# frozen_string_literal: true

class Post < ApplicationRecord
  has_paper_trail

  acts_as_paranoid


  # has_paper_trail :if     => Proc.new { |t| t.language_code == 'US' },
  #                 :unless => Proc.new { |t| t.type == 'DRAFT'       }

  belongs_to :user
  # attr_accessible: :name, :gender
  #     before_validation :set_user

  # private
  #   def set_user
  #   @user = User.find_or_create_by(email: self.user_id)
  #   @user.save
  #   end

  # def self.drop_down_options
  #     User.all.map { |p| [p.use, p.id] }
  # end

  # def use
  #     "#{user.username}"
  # end
end
