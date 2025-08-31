FactoryBot.define do
  factory :time_record do
    work_day { nil }
    clock_in_time { "2025-08-31 04:03:39" }
    clock_out_time { "2025-08-31 04:03:39" }
    break_time { 1 }
  end
end
