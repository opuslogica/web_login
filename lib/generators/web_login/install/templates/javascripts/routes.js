define(
  function() {
    return function(match) {
      console.log("Doing routing");
      match('','hello#show');
    };
  }
);