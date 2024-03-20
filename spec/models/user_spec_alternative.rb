require 'rails_helper'

RSpec.describe User, type: :model do
  ### Create a method 'subject'
  subject {
    described_class.new(
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      Faker::Internet.email,
      phone:      Faker::PhoneNumber.phone_number_with_country_code,
      role:       Faker::Types.rb_integer(from: 0, to: 2),
    )
  }

  ### Test validations
  it "is valid with valid attributes" do # ?
    expect(subject).to be_valid
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a phone" do
    subject.phone = nil
    expect(subject).to_not be_valid
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:role).with_values(seller: 0, manager: 1, admin: 2) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:tasks) }    # Task must be generated!
  end

  ### Test public method(s)
  let(:user) {          # this is input
    described_class.create(
      first_name: 'buffy', last_name: 'suMMers', role: 1, 
      email: "a.a#exa.com", phone: "+7 123 45 676"
    )
  }

  describe '#full_name' do
    subject(:full_name) { user.full_name }  # this is output - to be compare with expected one

    it 'returns the capitalized full name of the user' do
      expect(full_name).to eq("Buffy Summers") # private methods are tested indirectly here
    end
  end
end
