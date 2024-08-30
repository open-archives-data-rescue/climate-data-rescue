// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// // Example: Import a stylesheet in app/frontend/index.css
// // import '~/index.css'
// // import * as ActiveStorage from "@rails/activestorage"

import '/stylesheets/theme.scss';
import '/stylesheets/transcriptions.scss';
import 'magnify/dist/css/magnify.css';
import "tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.css";
import 'select2/dist/css/select2.css';
import 'select2-bootstrap-theme/dist/select2-bootstrap.css';
import './imports.js';

import 'jquery-ujs';
import 'bootstrap';

// // import 'bootstrap-switch.css'
// import 'bootstrap-switch';
import 'trumbowyg'

import "jquery-ui-dist/jquery-ui.js";

import "blueimp-file-upload/js/jquery.fileupload.js";

import "../utils/backbone-forms.js";
import "backbone-forms/distribution/adapters/backbone.bootstrap-modal.js";
import "backbone-forms/distribution/editors/list";
// TODO: change later date because module does not work with the old code
import "../utils/fileUploadEditor.js";
// import "backbone-forms/distribution/editors/fileUploadEditor"
import "../templates/bootstrap4.js";
// require("backbone-model-file-upload/backbone-model-file-upload.js");
import "../utils/backbone-model-file-upload.js";

import "jquery.kinetic/jquery.kinetic.js";
import "magnify/dist/js/jquery.magnify.js";
import "magnify/dist/js/jquery.magnify-mobile.js";

import "../utils/page-uploader-plugin.js";
import "../utils/boxer-plugin.js";
import "../utils/content_images.js";
import "../utils/snowEffect.js";
import "../utils/select2.full.js";

// // import '@/stylesheets/theme.scss'
// // import '@/stylesheets/transcriptions.scss'

// // import 'magnify/dist/css/magnify.css'

// // import "tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.css"

// // import "trumbowyg/dist/ui/icons.svg"

// // see https://dev.to/shivashankarror/rails-6-using-images-with-webpacker-and-asset-pipeline-4gk3
// // const images = require.context('../images', true)

import "tempusdominus-bootstrap-4/build/js/tempusdominus-bootstrap-4.js";

import "bootstrap-notify/bootstrap-notify.js";

// // Rails.start()
// // ActiveStorage.start()

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
})

$(document).ready(function(){
  _.templateSettings = {
        interpolate : /\{\{\=(.+?)\}\}/g,
        evaluate : /\{\{(.+?)\}\}/g,
        // escape:    /{{-([\s\S]+?)}}/g
    };

    // Over-ride the backbone sync so that the rails CSRF token is passed to the backend
    Backbone._sync = Backbone.sync;
    Backbone.sync = function(method, model, options) {
      // is this working
        if (method == 'create' || method == 'update' || method == 'delete') {
            var auth_options = {};
            auth_options[$("meta[name='csrf-param']").attr('content')] = $("meta[name='csrf-token']").attr('content');
            model.set(auth_options, {silent: true});
        };
        options.error = function(response) {
            if (response.status > 0) {
                if (response.responseText) {
                    if (options.handle_error) {
                        options.handle_error(response);
                    } else {
                        alertMessage(response.responseText);
                    }
                } else {
                    alertMessage("Error communicating with backend ..."); // TODO - change to translatable string
                };
            };
        };

        return Backbone._sync(method, model, options);
    };


    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
          $(this).remove();
      });
    }, 5000);
});

// function alertMessageJson(message) {
//     var msg = '';
//     // console.log(message);
//     if (message && message.isArray){
//         message.each(function(el,idx,arr){
//             console.log(el);
//             el.error.each(function(e){
//                 msg += e;
//                 if (el.error.length > 0) {
//                     msg += '<br />';
//                 }
//             });
//         });
//
//         alertMessage(msg);
//     } else if (message && message.error){
//       alertMessage(message.error);
//     }
// };

function alertMessage(message) {
    $('#message-container').html("<div class=\"alert alert-warning fade in\"><button class=\"close\" data-dismiss=\"alert\"><span class=\"glyphicon glyphicon-remove\" style=\"margin-right: 14px\"></span></button>"+ message +"</div>");
};
