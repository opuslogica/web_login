define([
	  'controllers/base/controller',
	  'views/hello-world-view'
], function(Controller, HelloWorldView,UserModel) {
  'use strict';

  var HelloWorldController = Controller.extend({
    show: function(params) {
      console.log("SHowing hello world controller");
      this.view = new HelloWorldView({
        region: 'main'
      });
    }
  });

  return HelloWorldController;
});
