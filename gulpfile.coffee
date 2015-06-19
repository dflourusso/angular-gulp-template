gulp        = require 'gulp'
runSequence = require 'run-sequence'
$           = require('gulp-load-plugins')()

gulp.appConfig = require './app-config.json'

gulp.appConfig.paths.dist = gulp.appConfig.paths.dev

gulp.isPro = ->
  gulp.appConfig.env is 'production'

gulp.isTest = ->
  gulp.appConfig.env is 'test'

gulp.isStaging = ->
  gulp.appConfig.env is 'staging'

gulp.isMinify = ->
  gulp.isTest() || gulp.isStaging() || gulp.isPro()

require('require-dir')('./gulp')

gulp.task 'src', ['js', 'less', 'assets'], ->
  gulp.start ['index']

gulp.task 'watch', ->
  $.livereload.listen()
  gulp.watch 'src/**/*', ['partials', 'src']

gulp.task 'default', ->
  runSequence 'clear-dev', 'partials', 'src'

gulp.task 'pro', ->
  gulp.appConfig.env = 'production'
  gulp.appConfig.paths.dist = gulp.appConfig.paths.pro
  runSequence 'clear-pro', 'vendor-js', 'vendor-css', 'vendor-fonts', 'src'

gulp.task 'staging', ->
  gulp.appConfig.env = 'staging'
  gulp.appConfig.paths.dist = gulp.appConfig.paths.dev
  runSequence 'clear-dev', 'vendor-js', 'vendor-css', 'vendor-fonts', 'src'

gulp.task 'test', ->
  gulp.appConfig.env = 'test'
  gulp.appConfig.paths.dist = gulp.appConfig.paths.test
  runSequence 'clear-test', 'vendor-js', 'mocks', 'js', 'index'

gulp.task 'test-watch', ->
  gulp.appConfig.env = 'test'
  gulp.appConfig.paths.dist = gulp.appConfig.paths.test
  gulp.watch ['src/**/*', 'spec/mocks/*'], ['mocks', 'js', 'index']
