FactoryBot.define do

  factory :message do
   text Faker::Lorem.sentence
   image File.open("#{Rails.root}/public/uploads/message/image/13/ba2e9e609274fbd14137c38f23c53bf4.png")
    user
    group
  end

end
