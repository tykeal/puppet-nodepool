require 'spec_helper'
describe 'nodepool' do

  context 'with defaults for all parameters' do
    it { should contain_class('nodepool') }
  end
end
