include_recipe 'apt'
include_recipe 'git'

root_path = node['pyenv']['root_path']

%w(curl sqlite3 libsqlite3-dev libbz2-dev libreadline-dev zlib1g-dev libssl-dev build-essential).each do |pkg|
  package pkg do
    action :install
  end
end

git root_path do
  repository 'git://github.com/yyuu/pyenv.git'
  reference 'master'
  enable_submodules true
  action :sync
end

template '/etc/profile.d/pyenv.sh' do
  source 'pyenv.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

bash 'init pyenv' do
  environment 'PYENV_ROOT' => root_path
  code <<-EOH
    #{root_path}/bin/pyenv init -
  EOH
end

Array(node['pyenv']['pythons']).each do |python|
  bash "install python #{python}" do
    environment 'PYENV_ROOT' => root_path
    code <<-EOH
    #{root_path}/bin/pyenv install #{python}
    EOH
    not_if { ::File.exists?("#{root_path}/versions/#{python}/bin/python") }
  end
end

node['pyenv']['pip'].each_pair do |python, pkgs|
  Array(pkgs).each do |pkg|
    pkg_name = pkg['name']
    pkg_version = pkg['version']
    bash "pip install #{pkg_name}#{pkg_version} to python #{python}" do
      environment 'PYENV_ROOT' => root_path
      code <<-EOH
        #{root_path}/bin/pyenv global #{python}
        #{root_path}/shims/pip install #{pkg_name}#{'==' + pkg_version unless pkg_version.nil?}
      EOH
    end
  end
end

global_python = node['pyenv']['global']
if global_python
  bash "set global python to #{global_python}" do
    environment 'PYENV_ROOT' => root_path
    code <<-EOH
      #{root_path}/bin/pyenv global #{global_python}
    EOH
  end
end

bash 'init pyenv' do
  environment 'PYENV_ROOT' => root_path
  code <<-EOH
    sudo #{root_path}/bin/pyenv init -
  EOH
end

bash 'chown shims directory' do
  environment 'PYENV_ROOT' => root_path
  code <<-EOH
    sudo chmod 755 #{root_path}/shims
    #{root_path}/bin/pyenv rehash
  EOH
end
