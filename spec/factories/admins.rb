FactoryGirl.define do
  factory :admin do
    name 'admin'
    password 'qwe456-'

    factory :invalid_admin do
      name 'assistant'
      password nil
    end
  end

end
