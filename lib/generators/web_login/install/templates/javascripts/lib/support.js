define([
  'underscore',
  'lib/utils',
  'chaplin'
], function(_, utils,Chaplin) {
  'use strict'

  // Application-specific utilities
  // ------------------------------

  // Delegate to Chaplin’s utils module
  var support = Chaplin.utils.beget(Chaplin.support);

  // Add additional application-specific properties and methods

  // _(utils).extend({
  //   someProperty: 'foo',
  //   someMethod: function() {}
  // });

  return support;
});
