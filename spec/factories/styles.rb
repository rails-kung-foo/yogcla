FactoryGirl.define do
  factory :style do
    stil 'ashtanga'

    factory :invalid_style do
      stil nil
    end
  end
end
