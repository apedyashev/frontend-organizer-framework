// Generated by CoffeeScript 1.7.1
if (window.Rrs == null) {
  window.Rrs = {};
}

Rrs.logger = {
  error: function() {
    return console.error.apply(console, arguments);
  },
  log: function() {
    return console.log.apply(console, arguments);
  },
  debug: function() {
    return console.debug.apply(console, arguments);
  }
};
