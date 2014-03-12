fs            = require 'fs'
{exec, spawn} = require 'child_process'

config =
  srcDir:  'src'
  jsDir:   'js'
  outDir:  'dist'
  outFile: 'jquery.query.to.object'
  yuic:    'yui-compressor'

outJS    = "#{config.outDir}/#{config.outFile}"

# deal with errors from child processes
exerr  = (err, sout,  serr)->
  process.stdout.write err  if err
  process.stdout.write sout if sout
  process.stdout.write serr if serr


task 'watch', 'watch and compile changes in src dir', ->
  watch = exec "coffee -wbco ./#{config.jsDir} #{config.srcDir}"
  watch.stdout.on 'data', (data)-> process.stdout.write data.toString()
  watch.stderr.on 'data', (data)-> process.stderr.write data.toString()


task 'min', 'minify compiled *.js file', ->
  exec "#{config.yuic} #{outJS}.js -o #{outJS}.min.js", exerr


task 'build', 'compile *.coffee file into js', ->
  exec "coffee -bco . #{config.srcDir}"


task 'dist', 'build and minify', ->
  invoke 'build'
  invoke 'min'