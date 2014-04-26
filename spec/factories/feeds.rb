# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    user nil
    name "MyString"
    url "MyText"
  end
end
