Fabricator(:user) do
  name { Faker::Name.first_name }
  lastname { Faker::Name.last_name }
  email { |p| Faker::Internet.email([p.name, p.lastname].join(' ')) }
  password { Faker::Lorem.sentence }
  password_confirmation { |p| p.password }
  roles User.valid_roles.map(&:to_s)
end