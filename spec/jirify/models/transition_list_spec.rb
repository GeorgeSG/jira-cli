require 'spec_helper'

describe Jirify::Models::TransitionList do
  subject(:transition_list) do
    described_class.all(issue_resource)
  end

  let(:transition_resources) do
    Jirify::Config.transitions.map do |_, value|
      double(JIRA::Resource::Transition, id: 't', name: value)
    end
  end

  let(:issue_resource) { instance_double(JIRA::Resource::Issue, id: 'XX-1234') }

  before do
    allow(Jirify::Config).to receive(:options).and_return(mock_config)
    allow(Jirify::Config).to receive(:transitions).and_return(mock_config['transitions'])
    allow_any_instance_of(JIRA::Client).to receive_message_chain(:Transition, :all) { transition_resources }
  end

  describe '::all' do
    it 'invokes the Transition API' do # rubocop:disable RSpec/ExampleLength
      call_count = 0
      allow_any_instance_of(JIRA::Client).to receive_message_chain(:Transition, :all) do
        call_count += 1
        []
      end

      described_class.all(issue_resource)
      expect(call_count).to be 1
    end

    it 'unwraps values as needed' do
      allow_any_instance_of(JIRA::Client).to receive_message_chain(:Transition, :all) { transition_resources }
      expect(transition_list.first.id).to eq 't'
    end
  end

  describe '#list' do
    it 'returns the transition list' do
      expect(transition_list.list.count).to be 2
    end

    it 'maps returned transitions to instances of Transition models' do
      expect(transition_list.first).to be_a(Jirify::Models::Transition)
    end
  end

  describe '#names' do
    it 'returns the names of all transitions' do
      expect(transition_list.names).to eq ['Custom Start Progress', 'Close']
    end
  end

  context 'when finding by name' do
    it 'defines methods for finding every transition by name' do
      Jirify::Config.transitions.keys.each do |transition|
        expect(transition_list).to respond_to(transition.to_sym)
      end
    end

    describe '#start' do
      it 'returns the start transition' do
        expect(transition_list.start.name).to eq 'Custom Start Progress'
      end
    end
  end
end
