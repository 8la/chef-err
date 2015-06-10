require 'spec_helper'

describe 'err::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'sets up err bot' do
    expect(chef_run).to_not run_ruby_block('err_service_trigger')

    %w(
      /opt/err
      /opt/err/data
      /opt/err/plugins
      /opt/err/logs
      /opt/err/data/plugins
    ).each do |dir|
      expect(chef_run).to create_directory(dir).with(
        owner: 'nobody',
        group: 'nogroup',
        recursive: true
      )
    end

    expect(chef_run).to create_python_virtualenv('/opt/err/env').with(
      owner: 'nobody',
      group: 'nogroup'
    )

    expect(chef_run).to install_python_pip('xmpppy').with(
      version: '0.5.0rc1',
      virtualenv: '/opt/err/env'
    )

    expect(chef_run).to install_python_pip('err').with(
      version: '1.7.2',
      virtualenv: '/opt/err/env'
    )

    expect(chef_run).to create_template('/opt/err/config.py').with(
      source: 'config.py.erb',
      owner: 'nobody',
      group: 'nogroup',
      mode: 0640,
      variables: { plugin_paths: [] }
    )

    expect(chef_run).to enable_supervisor_service('err').with(
      command: '/opt/err/env/bin/err.py  -c /opt/err -u nobody -g nogroup'
    )
  end
end
