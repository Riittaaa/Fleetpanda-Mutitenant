json.extract! blog, :id, :title, :body, :organization_id, :created_at, :updated_at
json.url blog_url(blog, format: :json)
