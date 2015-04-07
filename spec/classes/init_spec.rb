require 'spec_helper'

describe 'nodepool', :type => :class do

  context 'with defaults for all parameters' do
    it { should contain_class('nodepool') }
    it { should contain_class('nodepool::params') }
    it { should contain_anchor('nodepool::begin') }
    it { should contain_class('nodepool::install') }
    it { should contain_class('nodepool::config') }
    it { should contain_class('nodepool::service') }
    it { should contain_anchor('nodepool::end') }
  end

  context 'with bad parameters' do
    let(:params) {{}}

    it 'should fail on bad manage_python' do
      params.merge!({'manage_python' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not a boolean/)
    end

    it 'should fail on bad manage_vcsrepo' do
      params.merge!({'manage_vcsrepo' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not a boolean/)
    end

    it 'should fail on bad venv_path' do
      params.merge!({'venv_path' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end

    it 'should fail on bad vcs_path' do
      params.merge!({'vcs_path' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end
  end
end

# vim: sw=2 ts=2 sts=2 et :
