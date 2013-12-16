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
      grunt:
        files: ['Gruntfile.coffee']
        tasks: []
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: [
          'pages/*.html'
          '.tmp/*.js'
          '.tmp/*.css'
        ]
      styles:
        files: ['styles/{,*/}*.less']
        task: ['less']

    coffee:
      options:
        bare: true
        sourceMaps: true
        sourceRoot: ''
      dist:
        files: [
          expand: true
          cwd: 'app'
          src: '{,*/}*.coffee'
          dest: '.tmp'
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
            'pages'
            'app'
          ]

    less:
      dist:
        files:
          '.tmp/userbase.front.css': 'styles/userbase.front.less'

  grunt.registerTask 'serve', ->
    grunt.task.run [
      'coffee:dist'
      'less:dist'
      'connect:livereload'
      'watch'
    ]

