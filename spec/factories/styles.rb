FactoryGirl.define do
  factory :style do
    stil 'ashtanga'

    factory :zen_style do
      stil 'zen'
    end

    factory :invalid_style do
      stil nil
    end
  end
end
