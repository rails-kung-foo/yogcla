json.array!(@styles) do |style|
  json.extract! style, :id, :stil
  json.url style_url(style, format: :json)
end
