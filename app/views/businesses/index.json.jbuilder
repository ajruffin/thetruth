json.array!(@businesses) do |business|
  json.extract! business, :name, :address, :city, :state, :zip
  json.url business_url(business, format: :json)
end
