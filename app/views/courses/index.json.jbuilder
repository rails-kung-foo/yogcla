json.array!(@courses) do |course|
  json.extract! course, :id, :studio_id, :style_id, :start, :end, :weekday
  json.url course_url(course, format: :json)
end
