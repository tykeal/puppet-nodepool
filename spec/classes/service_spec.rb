require 'spec_helper'

describe 'nodepool::service', :type => :class do

  context 'with defaults for all parameters' do
    let(:params) {{}}

    it { is_expected.to contain_service(
      'nodepool').with(
        'ensure'     => 'running',
        'enable'     => true,
        'hasrestart' => true,
        'hasstatus'  => true,
    ) }
  end
end
# vim: sw=2 ts=2 sts=2 et :
