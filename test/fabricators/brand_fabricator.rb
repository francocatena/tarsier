Fabricator(:brand) do
  name { [Faker::Company.name, sequence(:brand_name)].join(' ') }
end
