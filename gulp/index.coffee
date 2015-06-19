gulp           = require 'gulp'
mainBowerFiles = require 'main-bower-files'

$ = require('gulp-load-plugins')()

paths = gulp.appConfig.paths

vendors = ->
  if gulp.isMinify()
    ["#{paths.dist.vendor}/**/*.js", "#{paths.dist.vendor}/**/*.css"]
  else
    mainBowerFiles()

sources = ->
  ["#{paths.dist.scripts}/**/*.js", "#{paths.dist.styles}/**/*.css"]

gulp.task 'index', ->
  injects = gulp.src(vendors().concat(sources()), read: no)
  idx = gulp.src paths.src.index
  .pipe $.plumber()
  .pipe $.jade pretty: yes, doctype: 'html'
  .pipe $.inject(injects)
  if gulp.isMinify()
    idx.pipe $.minifyHtml({empty: true, spare: true, quotes: true})
    .pipe gulp.dest paths.dist.root
  else
    idx.pipe gulp.dest paths.dist.root
    idx.pipe($.livereload())
