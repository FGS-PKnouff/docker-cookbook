describe command('docker') do
  it { should exist }
end

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe command('docker run hello-world') do
  its(:stdout) { should match(/Hello from Docker/) }
end

describe group('docker') do
  it { should exist }
end
