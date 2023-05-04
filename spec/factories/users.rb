FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'example@gmail.com' }
    password { 'password' }
  end
end
