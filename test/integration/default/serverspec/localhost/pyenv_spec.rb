require 'spec_helper'

describe command('/usr/local/pyenv/shims/python -V') do
  it { should return_stdout 'Python 2.7.6' }
end

describe command('/usr/local/pyenv/shims/pip -V') do
  it { should return_stdout 'pip 1.5 from /usr/local/pyenv/versions/2.7.6/lib/python2.7/site-packages/pip-1.5-py2.7.egg (python 2.7)' }
end

describe file('/usr/local/pyenv/shims/python') do
  it { should be_file }
end

describe file('/usr/local/pyenv/shims/pip') do
  it { should be_file }
end
