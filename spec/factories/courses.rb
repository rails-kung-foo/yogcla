FactoryGirl.define do
  factory :course do |f|
    f.studio_id 0
    f.style_id 0
    f.start '10:00'
    f.ending '11:00'
    f.weekday 'monday'
  end

end
