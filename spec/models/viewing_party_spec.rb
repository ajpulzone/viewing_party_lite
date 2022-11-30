# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { should have_many :user_viewing_parties }
    it { should have_many(:users).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of :movie_title}
    it { should validate_presence_of :duration}
    it { should validate_presence_of :date}
    it { should validate_presence_of :start_time}
    it { should validate_presence_of :status}
  end
end