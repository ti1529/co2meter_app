json.extract! company, :id, :name, :contact_name, :contact_email, :status, :created_at, :updated_at
json.url company_url(company, format: :json)
