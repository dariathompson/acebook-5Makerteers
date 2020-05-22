# frozen_string_literal: true

class Post < ApplicationRecord
  # delegate :name, :to => :user
  belongs_to :user
  has_many :comments
  validates :message, presence: true, length: { minimum: 1 }
end

# Think the issue is to do with the "validates: commenter".

# Changed it from :commenter to messages
