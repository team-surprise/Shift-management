class WorkDay < ApplicationRecord
  belongs_to :store
  belongs_to :user

  has_many :time_records, dependent: :destroy
end
