require 'rails_helper'
describe Message do
  describe '#create' do
    context 'can save' do
      it "is valid without a message" do
          expect(build(:message, text: nil)).to be_valid
      end

      it "is valid without a image" do
          expect(build(:message, image: nil)).to be_valid
      end

      it "is valid without nothing" do
          expect(build(:message)).to be_valid
      end
    end

    context 'can save' do
      it "is invalid without image and message" do
       message = build(:message,text: "",image: "")
       message.valid?
       expect(message.errors[:text_or_image]).to include('を入力してください')
      end

      it "is invalid without group_id" do
       message = build(:message,group_id: "")
       message.valid?
       expect(message.errors[:group]).to include('を入力してください')
      end

      it "is invalid without user_id" do
       message = build(:message,user_id: "")
       message.valid?
       expect(message.errors[:user]).to include('を入力してください')
      end
    end
  end
end
