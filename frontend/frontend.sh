#!/bin/bash

# Exit in case of error
set -e

echo "node version `node --version`"
echo "npm version `npm --version`"


case $1 in

  serve)
    npm run dev
  ;;

  build)
    npm run build
    npm run buildVersion
    rm -rf build/
    mv dist build
  ;;

  install)
    npm install
    npm audit fix
  ;;

  lint)
    npm run lint
  ;;

  format)
    npm run format
  ;;

  formatfiles)
    args=( "${@:2}" )
    npm run formatfile ${args[@]}
    echo "formatted ${args[@]}"
  ;;

  *)
    npm "$@"
    ;;
esac