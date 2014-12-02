
module.exports = function(grunt) {

  'use strict';

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    coffee: {
      compile: {
        files: {
          'build/app.js': ['public/javascripts/**/*.coffee']
        }
      }
    },

    jshint: {
      options: {
        jshintrc: true
      },
      public: {
        src: ['Gruntfile.js','build/app.js']
      }
    },

    watch:  { // 매번 watch task를 실행하고 있어야하는지 고민
      coffee: {
        files: ['public/javascripts/**/*.coffee','<%= jshint.public.src %>'],
        tasks: ['coffee', 'jshint']
      }
    },

    nodemon: {
      dev: {
        script: 'bin/www',
        options: {
          args: ['dev'],
          nodeArgs: ['--debug'],
          callback: function (nodemon) {
            nodemon.on('log', function (event) {
              console.log(event.colour);
            });
          },
          cwd: __dirname,
          ignore: ['node_modules/**'],
          ext: 'js,coffee,hbs',
          watchedFolders: ['src/**/*','public/javascripts/**','views/**/*'],
          delay: 1000,
          legacyWatch: true
        }
      }
    },

    uglify: {
      generated: {
        files: [
          {
            dest: 'build/app.min.js',
            src: [ 'build/app.js' ]
          }
        ]
      }
    },

    useminPrepare: {
      html: 'views/layout.hbs',
      options: {
        dest: '.'
      }
    },

    usemin: {
      html: 'views/layout.hbs'
    },

    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          require: [
            'coffee-script/register',
            'node_modules/should/should.min.js'
          ]
        },
        src: ['test/**/*.js']
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-nodemon');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-usemin');
  grunt.loadNpmTasks('grunt-mocha-test');

  grunt.registerTask('server', ['coffee','nodemon:dev']);
  grunt.registerTask('lint', ['jshint:public']);
  grunt.registerTask('test', ['mochaTest']);
  grunt.registerTask('deploy', ['useminPrepare', 'uglify:generated', 'usemin']);
};
