FactoryGirl.define do
  factory :course do
    studio_id 1
    style_id 1
    start '10:00'
    ending '11:00'
    weekday 'monday'

    factory :second_course do
      weekday 'sunday'
      studio_id 2
    end

    factory :third_course do
      weekday 'sunday'
      style_id 2
    end
  end

end
