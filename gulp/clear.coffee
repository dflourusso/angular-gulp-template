gulp = require 'gulp'
del  = require 'del'

paths = gulp.appConfig.paths

gulp.task 'clear', ->
  del [paths.pro.root, paths.dev.root]

gulp.task 'clear-pro', ->
  del [paths.pro.root]

gulp.task 'clear-dev', ->
  del [paths.dev.root]
  del [paths.pro.root]

gulp.task 'clear-test', ->
  del [paths.test.root]

gulp.task 'clear-test-watch', ->
  del [paths.test.scripts]
