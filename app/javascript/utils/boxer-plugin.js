// Boxer plugin
// sourced from http://jsbin.com/azare/edit?html,js,output
$.widget("ui.boxer", $.ui.mouse, {
    _init: function() {
        this.element.addClass("ui-boxer");
        this.dragged = true;
        this._mouseInit();
        this.dimensions = null;
        this.helper = $('<div></div>')
            .addClass("annotation-marker helper");
    },

    destroy: function() {
        this.element
            .removeClass("ui-boxer ui-boxer-disabled")
            .removeData("boxer")
            .unbind(".boxer");
        this._mouseDestroy();

        return this;
    },

    _mouseStart: function(event) {
        var self = this;
        var options = this.options;
        var target = options.target || options.appendTo;
        var groupColour = "";
        this.zoomLevel = options.zoomLevel || 1;

        if (options.groupColour) {
            groupColour = options.groupColour;
        };

        var offset = $(target).offset();

        this.startPosition = {
          x: (event.pageX - $(document).scrollLeft() - offset.left) / this.zoomLevel,
          y: (event.pageY - $(document).scrollTop() - offset.top) / this.zoomLevel
        };

        if (this.options.disabled)
            return;

        this._trigger("start", event);

        $(options.appendTo).append(this.helper);

        this.helper.css({
            "left": this.startPosition.x,
            "top": this.startPosition.y,
            "width": 0,
            "height": 0
        }).addClass(groupColour);
    },

    _mouseDrag: function(event) {
        var self = this;
        this.dragged = true;

        if (this.options.disabled)
            return;

        var options = this.options;
        var target = options.target || options.appendTo;

        var $container = $(options.container);

        var pageX = event.pageX;
        var pageY = event.pageY;

        // Scroll the container when dragging near the edges
        if (pageX > ($container.width() - 50)) {
            $container.scrollLeft($container.scrollLeft() + 5);
        } else if (pageX < ($container.offset().left + 50)) {
            $container.scrollLeft($container.scrollLeft() - 5);
        };

        if (pageY > ($container.height() - 50)) {
            $container.scrollTop($container.scrollTop() + 5);
        } else if (pageY < ($container.offset().top + 50)) {
            $container.scrollTop($container.scrollTop() - 5);
        };

        let x = 0;
        let y = 0;
        x = (pageX - $(document).scrollLeft() - $(target).offset().left) / this.zoomLevel;
        y = (pageY - $(document).scrollTop() - $(target).offset().top) / this.zoomLevel;

        var x1 = this.startPosition.x, y1 = this.startPosition.y, x2 = x, y2 = y;

        // Support dragging in both directions
        if (x1 > x2) { var tmp = x2; x2 = x1; x1 = tmp; }
        if (y1 > y2) { var tmp = y2; y2 = y1; y1 = tmp; }

        // console.debug("---- Box is ", {left: x1, top: y1, width: x2-x1, height: y2-y1});
        this.dimensions = {left: x1, top: y1, width: x2-x1, height: y2-y1}

        this.helper.css(this.dimensions);

        this._trigger("drag", event);

        return false;
    },

    _mouseStop: function(event) {
        var self = this;

        this.dragged = false;

        var options = this.options;

        var clone = this.helper.clone().appendTo(options.appendTo).removeClass("helper");

        this._trigger("stop", event, { box: clone, dimensions: this.dimensions });

        this.helper.remove();

        return false;
    }

});
$.extend($.ui.boxer, {
  defaults: $.extend({}, $.ui.mouse.defaults, {
    appendTo: 'body',
    distance: 0
  })
});
