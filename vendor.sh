#!/bin/bash
rm Berksfile.lock
rm -rf cookbooks/
berks vendor cookbooks
tar -czvf ~/Dropbox/Public/mysql.tar.gz cookbooks 
