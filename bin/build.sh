#!/usr/bin/env bash

webpack=node_modules/.bin/webpack
webpack_conf=config/webpack.config.js

webpack --config $webpack_conf

(cd dist && zip lambda.zip bundle.js)
