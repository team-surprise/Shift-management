FactoryBot.define do
  factory :employment do
    store { nil }
    user { nil }
    status { 1 }
    start_date { "2025-08-31" }
    end_date { "2025-08-31" }
    hourly_wage_cents { 1 }
  end
end
