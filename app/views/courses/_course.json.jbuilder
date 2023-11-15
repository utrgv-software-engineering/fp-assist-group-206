json.extract! course, :id, :CRN, :Name, :Description, :Capacity, :created_at, :updated_at
json.url course_url(course, format: :json)
