#!/bin/bash

wmctrl -d | sed -n 's/\([0-9]\+\)\s\+\*.*/\1/p'
