FactoryBot.define do
  factory :department do
    name { Faker::IndustrySegments.sector }
  end
end
