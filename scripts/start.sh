#!/bin/bash

set -e

case $1 in
    finstall )
          cd frontend
          ./frontend.sh install
    ;;

    fb )
        cd frontend
        ./frontend.sh build
    ;;

    dev_fb )
        cd frontend
        ./frontend.sh serve
    ;;
esac