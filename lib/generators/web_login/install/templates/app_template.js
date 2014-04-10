define(
  ['chaplin','routes'],
  function(Chaplin,routes) {
    var <%= app_name %> = Chaplin.Application.extend(
      {
	title : "<%= rails_app_name %>",
	routes : routes,
	start : function() {
	  var args = [].slice.call(arguments);
	  Chaplin.Application.prototype.start.apply(this,args);
	}
      }
    );

    return <%= app_name %>;
});
