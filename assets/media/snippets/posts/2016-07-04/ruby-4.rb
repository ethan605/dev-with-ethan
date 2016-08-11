class Conversation < ApplicationRecord
  belongs_to :from_user
  belongs_to :to_user
end
