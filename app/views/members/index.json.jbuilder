json.array!(@members) do |member|
  json.extract! member, :id, :organization_id, :name, :slug, :post_count, :stock_count
  json.url member_url(member, format: :json)
end
