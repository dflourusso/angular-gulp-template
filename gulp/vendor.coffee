gulp  = require 'gulp'
mainBowerFiles = require 'main-bower-files'

$     = require('gulp-load-plugins')()

paths = gulp.appConfig.paths

gulp.task 'vendor-js', ->
  a = gulp.src(mainBowerFiles(filter: /.*\.js$/i))
  .pipe($.concat('vendor.min.js'))
  .pipe($.uglify())
  if gulp.isTest()
    a.pipe gulp.dest("#{paths.dist.vendor}/js")
  else
    a.pipe $.rev()
    .pipe gulp.dest("#{paths.dist.vendor}/js")

gulp.task 'vendor-css', ->
  gulp.src mainBowerFiles(filter: /.*\.css$/i)
  .pipe $.concat('vendor.min.css')
  .pipe $.minifyCss({keepBreaks: false, keepSpecialComments: 0})
  .pipe $.rev()
  .pipe gulp.dest("#{paths.dist.vendor}/css")

gulp.task 'vendor-fonts', ->
  fonts = mainBowerFiles(filter: /.*\/fonts\/.*\.(eot|svg|ttf|woff|woff2|otf)$/i)
  gulp.src(fonts)
  .pipe gulp.dest("#{paths.dist.vendor}/fonts")

gulp.task 'vendor', ['vendor-js', 'vendor-css', 'vendor-fonts'], ->
