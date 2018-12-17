const path = require('path');

module.exports = {
  mode: 'development',
  entry: path.resolve(__dirname, '..', 'src', 'index.ts'),
  devtool: 'inline-source-map',
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    extensions: ['.ts']
  },
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, '..', 'dist'),
    library: 'hello_lambda',
    libraryTarget: 'umd',
    globalObject: 'typeof self !== \'undefined\' ? self : this',
  }
};
