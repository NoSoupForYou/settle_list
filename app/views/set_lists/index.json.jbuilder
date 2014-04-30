json.array!(@set_lists) do |set_list|
  json.extract! set_list, :id, :name, :description, :artist_id
  json.url set_list_url(set_list, format: :json)
end
