require 'rails_helper'

describe ReferencesController do
    describe '#index' do
        it 'returns a list of all references' do
            expect(self.index).to eq ["first_reference", "second_reference", "last_reference"]
        end
    end
end