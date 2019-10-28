json.extract! listing, :id, :name, :user_id, :species, :info, :price, :quantity, :created_at, :updated_at
json.url listing_url(listing, format: :json)
