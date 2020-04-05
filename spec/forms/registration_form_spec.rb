require 'rails_helper'

RSpec.describe RegistrationForm do
  let(:args) do
    {
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      department_id: department_id
    }
  end
  let(:email) { 'jorgedrexler@example.com' }
  let(:first_name) { 'Jorge' }
  let(:last_name) { 'Drexler' }
  let(:department) { create(:department) }
  let(:department_id) { department.id }
  let(:password) { 'jorge1234' }
  let(:password_confirmation) { 'jorge1234' }

  subject { described_class.new(args).save }

  context 'valid arguments' do
    it 'creates a new user' do
      expect { subject }.to change { User.count }.by 1
    end

    it 'adds role player for location' do
      expect { subject }.to change { User.last&.has_role?(:employee, department) }.to true
    end
  end

  context 'with missing email' do
    let(:email) { '' }

    it { is_expected.to be false }
  end

  context 'with mismatching passwords' do
    let(:password_confirmation) { 'something else' }

    it { is_expected.to be false }
  end

  context 'department is missing' do
    let(:department_id) { 0 }

    it { is_expected.to be false }
  end
end
