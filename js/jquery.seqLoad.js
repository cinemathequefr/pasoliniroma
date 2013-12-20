/**
 * $.seqLoad
 * Sequentially loads and displays images
 * Adds a "loaded" class name to each image when done
 * 2013-04-09
 */
(function ($, global) {
    "use strict";
    var that;

    function loadNext (i) {
        var elem, dfd;

        if (i < that.length) {
            elem = that[i];

            if (elem.tagName === "IMG") {

                if (elem.complete) { // Already loaded: show immediately
                    $(elem).addClass("loaded").show();
                    loadNext(i + 1);

                } else {
                    dfd = $(elem).imagesLoaded();

                    dfd.fail(function ($img) {
                        loadNext(i + 1);
                    });

                    dfd.done(function ($img) {
                        global.setTimeout(function () { $img.fadeIn(100, function () { $(this).addClass("loaded"); loadNext(i + 1); }); }, 250);
                    });
                }
            } else { // Skip non-images
                loadNext(i + 1);
            }
        }
    }

    $.fn.seqLoad = function () {
        that = this;
        loadNext(0);
        return this;
    }

}(jQuery, window));