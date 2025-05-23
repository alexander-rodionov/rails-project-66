#!/bin/bash
echo Launching server
./bin/rails db:reset
./bin/rails s -b 0.0.0.0 -p 80