require 'serverspec'

# Required by serverspec
set :backend, :exec

## We'll assume a system-level install for testing purposes
describe file('/home/ubuntu/.rbenv') do
  it { should be_directory }
  it { should be_owned_by 'ubuntu' }
  it { should be_grouped_into 'ubuntu' }
end

describe file('/home/ubuntu/.rbenv/bin/rbenv') do
  it { should be_file }
  it { should be_executable }
#  it { should be_executable.by('others') }
  it { should be_owned_by 'ubuntu' }
  it { should be_grouped_into 'ubuntu' }
end

#describe command('bash -l -c "which rbenv"') do
describe command('su - ubuntu -c "bash -l -c \"which rbenv\""') do
  its(:stdout) { should match /\/home\/ubuntu\/.rbenv\/bin\/rbenv/ }
  its(:exit_status) { should eq 0 }
#  let(:sudo_options) { '-u ubuntu -H' }
end

#describe command('bash -l -c "rbenv --version"') do
describe command('su - ubuntu -c "bash -l -c \"rbenv --version\""') do
  its(:stdout) { should match /0\.4\.0/ }
  its(:exit_status) { should eq 0 }
#  let(:sudo_options) { '-u ubuntu -H' }
end
