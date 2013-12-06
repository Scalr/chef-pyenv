pyenv Cookbook
============
[![Build Status](https://travis-ci.org/kei-yamazaki/chef-pyenv.png?branch=master)](https://travis-ci.org/kei-yamazaki/chef-pyenv)
[![Code Climate](https://codeclimate.com/repos/52a52205c7f3a36adb00bcce/badges/dc5ca3bbfb6a57f61802/gpa.png)](https://codeclimate.com/repos/52a52205c7f3a36adb00bcce/feed)
[![Dependency Status](https://gemnasium.com/kei-yamazaki/chef-pyenv.png)](https://gemnasium.com/kei-yamazaki/chef-pyenv)

Manage python versions with [pyenv](https://github.com/yyuu/pyenv).


Requirements
------------
Only tested on Ubuntu 12.04 :p


Attributes
----------
* `node['pyenv']['root_path']`
    - Install path of pyenv (Default: /usr/local/pyenv).

* `node['pyenv']['versions']`
    - Install python versions (Default: 2.7.6).

* `node['pyenv']['global']`
    - Global python version (Default: 2.7.6).

Recipes
-------
### default
Install python with pyenv.

Usage
-----
Put `recipe[pyenv]` in the run list.
