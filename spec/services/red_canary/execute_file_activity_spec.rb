# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedCanary::ExecuteFileActivity do
  let(:file_path) { 'test_file.txt' }

  subject { RedCanary::ExecuteFileActivity.new(file_path, action) }

  before do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#call' do
    context 'when the action is update' do
      let(:action) { :create }

      it 'creates a file' do
        response = subject.call
        expect(response).to be_a(EndpointProcess)
        expect(response.command).to eq("touch #{file_path}")
        expect(File.exist?(file_path)).to be true
      end
    end

    context 'when the action is update' do
      let(:action) { :update }

      before do
        File.open(file_path, 'w') { |f| f.write('Hello World') }
      end

      it 'updates a file' do
        response = subject.call
        expect(response).to be_a(EndpointProcess)
        expect(response.command).to eq("echo 'Hello World' > #{file_path}")
      end

      it 'does not update a file that does not exist' do
        File.delete(file_path)
        response = subject.call
        expect(response).to be false
      end
    end

    context 'when the action is destroy' do
      let(:action) { :delete }

      before do
        File.open(file_path, 'w') { |f| f.write('Hello World') }
      end

      it 'destroys a file' do
        response = subject.call
        expect(response).to be_a(EndpointProcess)
        expect(response.command).to eq("rm #{file_path}")
        expect(File.exist?(file_path)).to be false
      end
    end
  end
end
