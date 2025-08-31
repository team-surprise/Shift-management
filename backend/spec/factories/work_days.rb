FactoryBot.define do
  factory :work_day do
    store { nil }
    user { nil }
    work_date { "2025-08-31" }
    work_hours { 1 }
  end
end
