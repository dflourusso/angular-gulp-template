gulp = require 'gulp'
$    = require('gulp-load-plugins')()

gulp.task 'lint', ->
  gulp.src ['src/**/*.coffee', 'test/**/*.coffee', 'gulp/**/*.coffee']
  .pipe $.coffeelint()
  .pipe($.coffeelint.reporter())
