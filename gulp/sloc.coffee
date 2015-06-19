gulp = require 'gulp'
$    = require('gulp-load-plugins')()

gulp.task 'sloc', ->
  gulp.src ['src/app/**/*.coffee', 'src/common/**/*.coffee']
  .pipe $.sloc()
