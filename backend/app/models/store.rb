class Store < ApplicationRecord
  has_many :work_days, dependent: :destroy
  has_many :shift_requests, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :store_accounts, dependent: :destroy

  has_many :stores, through: :employments

  # 便利系
  has_many :time_records, through: :work_days
end
