Fabricator(:article) do
  code { "TA #{sequence(:article_code, 1)}" }
  name { Faker::Lorem.sentence }
  price { (rand * 50.0 + 1.0).round(3) }
  description { Faker::Lorem.sentences(3).join("\n") }
  brand_id { Fabricate(:brand).id }
end
