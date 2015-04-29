require 'spec_helper'

describe 'nodepool::install', :type => :class do
  # set some default good params so we can override with bad ones in
  # test
  let(:params) {
    {
      'group'      => 'nodepool',
      'user'       => 'nodepool',
      'user_home'  => '/home/nodepool',
      'venv_path'  => '/opt/venv-nodepool',
      'vcs_path'   => '/opt/vcs-nodepool',
      'vcs_source' => 'https://github.com/openstack-infra/nodepool.git',
      'vcs_type'   => 'git',
    }
  }

  # we do not have default values so the class should fail compile
  context 'with defaults for all parameters' do
    let(:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass group/)
    end
  end

  context 'with bad parameters' do
    it 'should fail on bad group' do
      params.merge!({'group' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad user' do
      params.merge!({'user' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad user_home' do
      params.merge!({'user_home' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
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

    it 'should fail on bad vcs_source' do
      params.merge!({'vcs_source' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad vcs_type' do
      params.merge!({'vcs_type' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad vcs_revision' do
      params.merge!({'vcs_revision' => true})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /true is not a string/)
    end
  end

  # actual validation tests for what the class should produce
  context 'with good parameters' do
    it { should contain_vcsrepo('/opt/vcs-nodepool').with(
      'ensure'   => 'present',
      'provider' => 'git',
      'source'   => 'https://github.com/openstack-infra/nodepool.git',
    ) }

    it { should contain_exec('install nodepool into /opt/venv-nodepool').with(
      'command'     => 'source /opt/venv-nodepool/bin/activate; pip install .',
      'cwd'         => '/opt/vcs-nodepool',
      'provider'    => 'shell',
      'refreshonly' => true,
      'path'        => ['/usr/bin', '/usr/sbin'],
    ) }

    it { should contain_group('nodepool') }

    it { should contain_user('nodepool').with(
      'ensure'     => 'present',
      'home'       => '/home/nodepool',
      'shell'      => '/bin/bash',
      'gid'        => 'nodepool',
      'managehome' => true,
    ) }

    it { should contain_file('/etc/nodepool').with(
      'ensure' => 'directory',
      'owner'  => 'nodepool',
      'group'  => 'nodepool',
      'mode'   => '0740',
    ) }
  end
end

# vim: sw=2 ts=2 sts=2 et :

