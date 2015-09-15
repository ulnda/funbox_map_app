// Constants
var dist = 'dist/';

// Plugins
var gulp = require('gulp');
var concat = require('gulp-concat');

var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var minifyHTML = require('gulp-minify-html');
var minifyCSS = require('gulp-minify-css');

var slim = require('gulp-slim');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');

var mainBowerFiles = require('main-bower-files');
var gulpFilter = require('gulp-filter');

var clean = require('gulp-clean');
var rename = require('gulp-rename');
var runSequence = require('run-sequence');
var connect = require('gulp-connect');

// Cleaning project folder task
gulp.task('clean', function() {
  gulp.src(dist + "/*").pipe(clean({force: true}));
});

// Processing styles task
gulp.task('styles', function() {
  return gulp.src('app/css/*.scss')
          .pipe(sass())
          .pipe(minifyCSS())
          .pipe(gulp.dest(dist + "css/"));
});

// Processing scripts task
gulp.task('scripts', function() {
  return gulp.src('app/js/**/*.coffee')
          .pipe(coffee())
          .pipe(jshint())
          //.pipe(uglify())
          .pipe(gulp.dest(dist + "js/")); 
});

// Processing images task
gulp.task('images', function() {
  gulp.src('app/img/**').pipe(gulp.dest(dist + 'img/'));
});

// Processing templates task
gulp.task('templates', function() {
  return gulp.src('app/**/*.slim')
          .pipe(slim({pretty: true}))
          //.pipe(minifyHTML())
          .pipe(gulp.dest(dist));
});

// Processing bower components(js, css, fonts) task
gulp.task('bower_components', function() {
  var jsFilter = gulpFilter('*.js');
  var cssFilter = gulpFilter('*.css');
  var fontFilter = gulpFilter(['*.eot', '*.woff', '*.woff2', '*.svg', '*.ttf']);

  return gulp.src(mainBowerFiles())
          .pipe(jsFilter)
          .pipe(uglify())
          .pipe(rename({suffix: '.min'}))
          .pipe(concat('bower_components.js'))
          .pipe(gulp.dest(dist  + "js/"))
          .pipe(jsFilter.restore())
          .pipe(cssFilter)
          .pipe(minifyCSS())
          .pipe(concat('bower_components.css'))
          .pipe(gulp.dest(dist  + "css/"))
          .pipe(cssFilter.restore())
          .pipe(fontFilter)
          .pipe(gulp.dest(dist + 'fonts/'));
});

// Watching files for changes task
gulp.task('watch', function() {
  gulp.watch('app/css/**/*.scss', ['styles']);
  gulp.watch('app/js/**/*.coffee', ['scripts']);
  gulp.watch('app/img/**/*', ['images']);
  gulp.watch('app/**/*.slim', ['templates']); 
});

// Server creating task
gulp.task('server', function() {
  connect.server({
    root: dist,
    port: 8888
  });
});

// Default task
gulp.task('default', function() {
  runSequence(['styles', 'scripts', 'images', 'bower_components'], 'templates', 'server', 'watch')
})