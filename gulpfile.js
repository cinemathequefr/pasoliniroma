var gulp = require("gulp");
var rename = require("gulp-rename");				// https://github.com/hparra/gulp-rename
var uglify = require("gulp-uglify");				// https://github.com/terinjokes/gulp-uglify
var concat = require("gulp-concat");				// https://github.com/wearefractal/gulp-concat
var minifycss = require("gulp-minify-css");
//var watch = require("gulp-watch");				// https://github.com/floatdrop/gulp-watch

gulp.task("default", function () {

	gulp.src([ // Note: List the scripts in the order in which they must be concatenated
		"src/scripts/vendor/jquery.modal.min.js",
		"src/scripts/vendor/jquery.mousewheel.min.js",
		"src/scripts/vendor/jquery.imagesloaded.min.js",
		"src/scripts/vendor/jquery.debouncedresize.js",
		"src/scripts/vendor/mustache.js",
		"src/scripts/vendor/path.js",
		"src/scripts/vendor/jquery.animate-enhanced.min.js",
		"src/scripts/vendor/jquery.dropdown.js",
		"src/scripts/vendor/infobox.js",
		"src/scripts/jquery.seqLoad.js",
		"src/scripts/vendor/jquery.mCustomScrollbar.min.js",
		"src/scripts/timeline.js",
		"src/scripts/fullscreen.js",
		"src/scripts/application.js"
	])
	.pipe(concat("main.js"))
	.pipe(uglify())
	.pipe(gulp.dest("js"));

	gulp.src([
		"src/styles/normalize.css",
		"src/styles/jquery.mCustomScrollbar.css",
		"src/styles/jquery.dropdown.css",
		"src/styles/common.css",
		"src/styles/timeline.css",
		"src/styles/jquery.modal.css"
	])
	.pipe(concat("main.css"))
	.pipe(minifycss())
	.pipe(gulp.dest("css"));

});
