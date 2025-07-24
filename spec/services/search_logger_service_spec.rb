require 'rails_helper'

describe SearchLoggerService do
  let(:ip) { '1.2.3.4' }

  it 'creates a new log when none exists' do
    expect { described_class.new(ip, 'test').log! }.to change(SearchLog, :count).by(1)
  end
end