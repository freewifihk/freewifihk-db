# Splits a monolithic premises.yaml into its constituting parts.
# © 2013 onarray <http://www.onarray.com>

fs = require 'fs'
path = require 'path'
yaml = require 'js-yaml'
posix = require 'posix'
mkdirp = require 'mkdirp'
slugify = require 'slugify'

premises = 'premises.yaml'
hotspots = 'hotspots'

# OS X file descriptors upper limit is usually 256
posix.setrlimit 'nofile', soft: 10000

mkdirp hotspots, (err) ->
  throw err if err
  fs.readFile premises, 'utf-8', (err, data) ->
    throw err if err
    db = yaml.safeLoad data
    for item in db
      filename = slugify item.name.toLowerCase()
      filename = "#{path.join hotspots, filename}.yaml"
      fs.writeFile filename, yaml.safeDump item, (err) ->
        throw err if err
