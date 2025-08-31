class ShiftRequest < ApplicationRecord
  belongs_to :store
  belongs_to :user
end
