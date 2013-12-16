module.exports = (grunt) ->
  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt)

  # Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt)

  grunt.initConfig
    watch:
      coffee:
        files: ['app/{,*/}*.coffee']
        tasks: ['coffee:dist']
      grunt:
        files: ['Gruntfile.coffee']
        tasks: []
      javascript:
        files: ['.tmp/*.js', '!.tmp/userbase.min.js']
        tasks: ['uglify:dist']
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

    uglify:
      dist:
        options:
          beautify: true
          mangle: false
        files:
          '.tmp/userbase.min.js': [
            'bower_components/angular-segmentio/angular-segmentio.js'
            '.tmp/{,*/}*.js'
            '!.tmp/userbase.min.js'
          ]


  grunt.registerTask 'serve', ->
    grunt.task.run [
      'coffee:dist'
      'less:dist'
      'uglify:dist'
      'connect:livereload'
      'watch'
    ]

