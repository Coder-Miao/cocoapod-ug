require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Ug do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ ug }).should.be.instance_of Command::Ug
      end
    end
  end
end

