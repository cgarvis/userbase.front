module.exports = (grunt) ->
  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt)

  # Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt)

  grunt.initConfig
    watch:
      coffee:
        files: ['app/{,*/}*.coffee']
        task: ['newer:coffee:dist']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: [
          'app/*.html'
          '.tmp/*.js'
        ]


    coffee:
      options:
        sourceMaps: true
        sourceRoot: ''
      dist:
        files: [
          expand: true
          cwd: 'app'
          src: '{,*/}*.coffee'
          dist: '.tmp'
          ext: '.js'
        ]

    connect:
      options:
        port: 9000
        hostname: 'localhost'
        livereload: 35729
      livereload:
        options:
          open: true
          base:[
            '.tmp'
            'app'
          ]

  grunt.registerTask 'serve', ->
    grunt.task.run [
      'connect:livereload'
      'watch'
    ]

