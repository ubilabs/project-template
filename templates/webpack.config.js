const ExtractTextPlugin = require('extract-text-webpack-plugin');
const HtmlPlugin = require('html-webpack-plugin');
const path = require('path');

const isProduction = process.env.NODE_ENV === 'production';

module.exports = {
  entry: './src/scripts/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'build')
  },
  devServer: {
    contentBase: './build',
    port: 8000
  },
  devtool: isProduction ? false : 'source-map',
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['env'],
          plugins: ['transform-object-rest-spread']
        }
      },
      {
        test: /\.styl$/i,
        exclude: /node_modules/,
        // always extract the css into a file
        use: ExtractTextPlugin.extract({
          use: [
            {
              loader: 'css-loader',
              options: {
                url: false
              }
            },
            {
              loader: 'postcss-loader',
              options: {
                plugins: isProduction ? [require('autoprefixer')] : [],
                sourceMap: !isProduction
              }
            },
            'stylus-loader'
          ]
        })
      }
    ]
  },
  plugins: [
    new HtmlPlugin({
      filename: 'index.html',
      template: 'src/templates/index.html'
    }),
    new ExtractTextPlugin({
      filename: 'styles/main.css'
    })
  ]
};
