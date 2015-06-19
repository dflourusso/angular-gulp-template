gulp  = require 'gulp'
del   = require 'del'

paths = gulp.appConfig.paths

gulp.task 'assets', ->
  gulp.src(paths.src.assets)
  .pipe(gulp.dest(paths.dist.assets))
