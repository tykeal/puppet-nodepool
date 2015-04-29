require 'spec_helper'

describe 'nodepool::config', :type => :class do
  # set some default good params so we can override with bad ones in
  # test
  let(:params) {
    {
    }
  }

  # we do not have default values so the class should fail compile
  context 'with defaults for all paremeters' do
    let(:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass configuration/)
    end
  end

  context 'with bad parameters' do
  end

end

# vim: sw=2 ts=2 sts=2 et :

