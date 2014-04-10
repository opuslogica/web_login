define(['chaplin','views/site-view'],function(Chaplin,SiteView) {
  var Controller = Chaplin.Controller.extend(
    {
      beforeAction: function() {
	this.reuse('site',SiteView);
      }
    }
  );

  return Controller;
});