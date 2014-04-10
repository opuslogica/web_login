define(
  ['handlebars','chaplin','lib/utils'],
  function(Handlebars,Chaplin,utils) {
    Handlebars.registerHelper(
      'url',function(routeName) {
	var params = [].slice.call(arguments, 1);
	var options = params.pop();
	return utils.reverse(routeName, params);
      }
    );
  }
);
