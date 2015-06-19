gulp  = require 'gulp'

$     = require('gulp-load-plugins')()

paths = gulp.appConfig.paths

gulp.task 'partials', ->
  gulp.src paths.src.partials
  .pipe $.plumber()
  .pipe $.jade pretty: yes, doctype: 'html'
  .pipe $.minifyHtml({empty: true, spare: true, quotes: true})
  .pipe $.angularTemplatecache(module: gulp.appConfig.name)
  .pipe gulp.dest paths.dist.scripts
  .pipe($.livereload())
