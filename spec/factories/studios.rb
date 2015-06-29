FactoryGirl.define do
  factory :studio do |f|
    f.name "Yoga Studio"
    f.address "Neckarstr 6"
    f.url "http://www.yoga-studio.com/"

    factory :sun_yoga do
      name 'Sun Yoga'
    end
  end
end
