/**
 * Fullscreen jquery plugin
 * (formerly overlay.js)
 *
 * Binds a click event to a jQuery selector that, when triggered, displays a full screen image (in an overlay DIV).
 * The parameters for the fullscreen image are given by the selector's attributes:
 * HTML currently requires this structure: <div id="overlay"><div id="overlay-close"></div><div id="overlay-view"></div><div id="overlay-caption"></div></div>
 * @param   src:String     path to the full-size image
 * @param   data-width:Number   width of the full-size image
 * @param   data-height:Number  height of the full-size image
 * @param   title:String        caption texte
 * @version 2013-04-08
 */

;(function ($, window, undefined) {
    "use strict";

    var Fullscreen = function ($trigger) {
        this.$overlay = $("#overlay"); // Overlay container (will fit the window)
        this.$trigger = $trigger;
        this.$close = this.$overlay.children("#overlay-close"); // Close button
        this.$view = this.$overlay.children("#overlay-view"); // View
        this.$caption = this.$overlay.children("#overlay-caption"); // Caption
        this.viewMargin = 8; // Minimum margin around the view
        this.title = $trigger.attr("alt") || "";
        this.src = $trigger.attr("src");
        this.width = $trigger.data("width");
        this.height = $trigger.data("height");
        this.initBgColor = $("body").css("backgroundColor");

        this.init();
    };


    Fullscreen.prototype = {

        init: function () {
            var self = this;
            this.$trigger.on("click", function () { self.open(); });
        },

        open: function () {
            var self = this;

            this.$view.html("<img style='width: 100%; height: 100%;' src='" + this.src + "' />");
            this.$caption.html(this.title);

            this.resize();
            $(window).on("debouncedresize webkitfullscreenchange mozfullscreenchange fullscreenchange", function () { self.resize(); });

            this.$overlay.children().hide();

            this.$overlay.fadeIn(250, function () {
                //$(this).prevAll().css({visibility: "hidden"});
                $("body").css({overflow: "hidden", backgroundColor: self.$overlay.css("backgroundColor")}); // Gives BODY the overlay's background color
                self.$overlay.children().show();
            });

            this.$close.on("click", function() { self.close(); });

            $(document).one("keyup", function (e) {
                if (e.which  === 27) {
                    self.$close.trigger("click");
                }
            });
        },

        close: function () {
            this.$close.hide().off("click");
            $(window).off("debouncedresize webkitfullscreenchange mozfullscreenchange fullscreenchange");
            this.$overlay.prevAll().css({visibility: "visible"});
            $("body").css({overflow: "auto", backgroundColor: this.initBgColor});

            this.$overlay.fadeOut(250);

        },

        resize: function () {

            var windowWidth = $(window).width(),
                windowHeight = $(window).height(),
                captionHeight = this.$caption.outerHeight(false),
                viewSize = fitInBox(
                    this.width,
                    this.height,
                    windowWidth - (2 * this.viewMargin),
                    windowHeight - captionHeight - (2 * this.viewMargin),
                    true
                ),
                viewWidth = viewSize.width,
                viewHeight = viewSize.height,
                viewportHeight = (windowHeight - captionHeight),
                viewTop = (viewportHeight - viewHeight) / 2,
                viewLeft = (windowWidth - viewWidth) / 2;

            this.$view.css({
                position: "fixed",
                top: viewTop + "px",
                left: viewLeft + "px",
                width: viewSize.width + "px",
                height: viewSize.height + "px"
            });
            this.$overlay.css({
                width: windowWidth + "px",
                height: windowHeight + "px"
            });
        }

    };


    /**
     * fitInBox
     * Constrains a box (width x height) to fit in a containing box (maxWidth x maxHeight), preserving the aspect ratio
     * Useful to resize images to fit a container
     * see: http://stackoverflow.com/questions/1106339/resize-image-to-fit-in-bounding-box
     * @author  Nicolas Le Thierry d'Ennequin
     * @version 2012-11-29
     * @param   Int     width           width of the box to be resized
     * @param   Int     height          height of the box to be resized
     * @param   Int     maxWidth        width of the containing box
     * @param   Int     maxHeight       height of the containing box
     * @param   Bool    expandable      if output size is bigger than input size, output is left unchanged (false) or expanded (true)
     * @return  Object                  width, height of the resized box
     */
    function fitInBox(width, height, maxWidth, maxHeight, expandable) {
        "use strict";

        var aspect = width / height,
            initWidth = width,
            initHeight = height;

        if (width > maxWidth || height < maxHeight) {
            width = maxWidth;
            height = Math.floor(width / aspect);
        }

        if (height > maxHeight || width < maxWidth) {
            height = maxHeight;
            width = Math.floor(height * aspect);
        }

        if (!!expandable === false && (width >= initWidth || height >= initHeight)) {
            width = initWidth;
            height = initHeight;
        }

        return {
            width: width,
            height: height
        };
    }


    jQuery.fn.fullscreen = function () { // expose as jQuery plugin
        return this.each(function () {
            new Fullscreen($(this));
        });
    };

}(jQuery, window));


