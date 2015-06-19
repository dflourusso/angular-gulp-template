gulp  = require 'gulp'
es    = require 'event-stream'
$     = require('gulp-load-plugins')()

paths = gulp.appConfig.paths

configTask = (env) ->
  file = require '../config-env.json'
  envConfig = file[env]
  options =
    name: gulp.appConfig.name + '.config'
    constants: envConfig
    stream: true
  return $.ngConstant(options)

tpl = ->
  gulp.src paths.src.partials
  .pipe $.plumber()
  .pipe $.jade pretty: yes, doctype: 'html'
  .pipe $.minifyHtml({empty: true, spare: true, quotes: true})
  .pipe $.angularTemplatecache(module: gulp.appConfig.name)

gulp.task 'js', ->
  configEnv = configTask gulp.appConfig.env

  js =
    gulp.src paths.src.scripts
    .pipe $.plumber()
    .pipe $.ngClassify(appName: gulp.appConfig.name)
    .pipe $.coffee(bare: no)

  if gulp.isMinify()
    a = es.merge(configEnv, tpl(), js)
    .pipe $.concat("#{gulp.appConfig.name}.js")
    .pipe $.uglify()
    if gulp.isTest()
      a.pipe gulp.dest(paths.dist.scripts)
    else
      a.pipe $.rev()
      .pipe gulp.dest(paths.dist.scripts)
  else
    es.merge(configEnv, js)
    .pipe gulp.dest(paths.dist.scripts)
    .pipe($.livereload())
