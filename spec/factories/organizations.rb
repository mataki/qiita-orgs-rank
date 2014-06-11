# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "MyString"
    slug "MyString"
    post_count 1
    stock_count 1
  end
end
