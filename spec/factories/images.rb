FactoryBot.define do

  factory :image do
    
    # url   {File.open("#{Rails.root}/spec/factories/image.jpg")}
    url {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/image.jpg'))}
    item
  end
end

