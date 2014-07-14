#!/bin/bash

# run chef solo and bootstrap system

rm -rf ./berks-cookbooks
berks vendor
rvmsudo_secure_path=1 rvmsudo USER=`whoami` chef-solo -c solo.rb
