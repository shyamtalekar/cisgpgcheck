# frozen_string_literal: true

require 'spec_helper'

describe 'cis::gpgcheck' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

        it {
          is_expected.to contain_file_line('gpgcheck').with(
            'ensure' => 'present',
            'path'   => '/etc/yum.conf',
            'line'   => 'gpgcheck=1',
            'match'  => '^gpgcheck\=',
          )

          is_expected.to contain_purge('yumrepo').with(
            'manage_property' => 'gpgcheck',
            'state'           => '1',
          )
        }

      it { is_expected.to compile }
    end
  end
end
