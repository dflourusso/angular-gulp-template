gulp = require 'gulp'
karma = require('karma').server

gulp.task 'spec', (done) ->
  karma.start
    configFile: "#{__dirname}/../karma.conf.js"
    singleRun: true
  ,
  done

gulp.task 'spec-watch', (done) ->
  karma.start
    configFile: "#{__dirname}/../karma.conf.js"
  ,
  done
