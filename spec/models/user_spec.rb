require 'rails_helper'

RSpec.describe User, type: :model do
  # Variant 1 for validate_uniqueness_of
  subject {
    described_class.new(
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      Faker::Internet.email,
      phone:      Faker::PhoneNumber.phone_number_with_country_code,
      role:       Faker::Types.rb_integer(from: 0, to: 2)
    )
  }

  context "validations" do     # Or:   describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should define_enum_for(:role).with_values(%w(seller manager admin)) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:phone).case_insensitive }
  end

  # Variant 2 for validate_uniqueness_of
  context "validations of uniqueness" do 
    subject { FactoryBot.build(:user) }   #
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:phone).case_insensitive }
  end

  # Public methods (with indirect testing of private methods)
  context "#full_name" do
    it "works" do
      user = User.new
      user.first_name = "bob"
      user.last_name  = "smIth"
      expect(user.full_name).to eq("Bob Smith")
    end
  end

  context "association" do
    it { should have_many(:tasks)}
  end
end
