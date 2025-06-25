require 'spec_helper'
require 'client_data_cli'

RSpec.describe 'ClientDataCLI' do
  subject(:run_cli) { ClientDataCLI.run(args) }

  context 'when no arguments are provided' do
    let(:args) { [] }
    it 'exits and shows usage instructions' do
      expect do
        expect(STDOUT).to receive(:puts).with("Usage: client_data [search NAME | find_duplicates]")
        run_cli
      end.to raise_error(SystemExit)
    end
  end

  context 'when searching for a client by name' do
    context 'and no name is provided' do
      let(:args) { ['search'] }
      it 'exits and shows usage instructions' do
        expect do
          expect(STDOUT).to receive(:puts).with("Usage: client_data search NAME")
          run_cli
        end.to raise_error(SystemExit)
      end
    end

    context 'and a name is provided' do
      let(:name) { 'Jane Doe' }
      let(:args) { ['search', name] }
      it 'searches using the ClientData::Queries::Search class' do
        expect(ClientData::Queries::Search).to receive(:find_by_name).with(name)
        run_cli
      end
    end
  end

  context 'when finding duplicates' do
    let(:args) { ['find_duplicates'] }
    it 'finds duplicates using the ClientData::Queries::Duplicates class' do
      expect(ClientData::Queries::Duplicates).to receive(:find_by_email)
      run_cli
    end
  end

  context 'when an unknown command is given' do
    let(:args) { ['unknown_command'] }
    it 'exits and shows usage instructions' do
      expect do
        expect(STDOUT).to receive(:puts).with("Unknown command: unknown_command")
        expect(STDOUT).to receive(:puts).with("Usage: client_data [search NAME | find_duplicates]")
        run_cli
      end.to raise_error(SystemExit)
    end
  end
end
