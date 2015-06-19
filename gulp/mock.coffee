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

gulp.task 'mocks', ->
  configEnv = configTask gulp.appConfig.env

  js =
    gulp.src paths.src.mocks
    .pipe $.plumber()
    .pipe $.ngClassify(appName: gulp.appConfig.name)
    .pipe $.coffee(bare: no)

  es.merge(configEnv, js)
  .pipe $.concat("#{gulp.appConfig.name}-mock.js")
  .pipe $.uglify()
  .pipe gulp.dest(paths.dist.scripts)
