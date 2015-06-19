gulp  = require 'gulp'
$     = require('gulp-load-plugins')()

paths = gulp.appConfig.paths

less = ->
  gulp.src(paths.src.styles)
  .pipe $.plumber()
  .pipe($.less().on('error', $.util.log))
  .pipe($.autoprefixer())

gulp.task 'less', ->
  if gulp.isMinify()
    less().pipe($.concat("#{gulp.appConfig.name}.css"))
    .pipe($.minifyCss({keepBreaks: false, keepSpecialComments: 0}))
    .pipe $.rev()
    .pipe(gulp.dest(paths.dist.styles))
  else
    less().pipe(gulp.dest(paths.dist.styles))
    .pipe($.livereload())
