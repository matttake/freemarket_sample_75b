FactoryBot.define do

  factory :image do
    
    url {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/image.jpg'))}
    item
  end
end

