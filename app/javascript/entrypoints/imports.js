/*
  This effectively does what the expose loader was doing with webpack
*/

import jQuery from 'jquery'
window.$ = window.jQuery = jQuery;

// import Backbone from "backbone/backbone.js";
import Backbone from "backbone/backbone.js";
window.Backbone = Backbone;

import _ from "underscore/underscore.js";
window._ = _;

import moment from "moment/moment.js"
window.moment = moment;

// import "backbone.marionette/lib/backbone.marionette.js";
// import "backbone.wreqr/lib/backbone.wreqr.js";

import Marionette from "backbone.marionette/lib/backbone.marionette";
window.Marionette = Marionette;

import Bowser from "bowser/bundled.js";
window.Bowser = Bowser;

// import "../templates/bootstrap4.js";
import Wreqr from "backbone.wreqr/lib/backbone.wreqr.js";
window.Backbone.Wreqr = Wreqr;

// import Form from "backbone-forms/distribution.amd/backbone-forms.js";

// require("backbone-forms/distribution/backbone-forms.js")(Backbone);

import trumbowygSvgIcons from 'trumbowyg/dist/ui/icons.svg';
window.trumbowygSvgIcons = trumbowygSvgIcons;
