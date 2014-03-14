fs            = require 'fs'
{exec, spawn} = require 'child_process'

config =
  srcDir:     'src'
  frameworkSrcDir: 'src/framework'
  jsDir:      'js'
  distDir:    'dist'
  distFile:   'rrs.organizer'
  yuic:       'yui-compressor'

  doc:
    input:   'src/framework'
    output:  'doc'

distJS    = "#{config.distDir}/#{config.distFile}"

# deal with errors from child processes
exerr  = (err, sout,  serr)->
  process.stdout.write err  if err
  process.stdout.write sout if sout
  process.stdout.write serr if serr


task 'watch', 'watch and compile changes in src dir', ->
  watch = exec "coffee -wbco ./#{config.jsDir} #{config.srcDir}"
  watch.stdout.on 'data', (data)-> process.stdout.write data.toString()
  watch.stderr.on 'data', (data)-> process.stderr.write data.toString()


task 'doc', 'generate frameworks documentation', ->
  codo = exec "codo --output ./#{config.doc.output} ./#{config.doc.input}" 
  codo.stdout.on 'data', (data)-> process.stdout.write data.toString()
  codo.stderr.on 'data', (data)-> process.stderr.write data.toString()


task 'min', "minify #{distJS}.js to #{distJS}.min.js", ->
  exec "#{config.yuic} #{distJS}.js -o #{distJS}.min.js", exerr


task 'build', "compile #{config.frameworkSrcDir}/*.coffee files into #{distJS}.js", ->
  exec "coffee -cj ./#{distJS}.js ./#{config.frameworkSrcDir}"


task 'dist', 'build and minify', ->
  invoke 'build'
  invoke 'min'