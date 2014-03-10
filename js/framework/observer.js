// Generated by CoffeeScript 1.7.1
if (window.Rrs == null) {
  window.Rrs = {};
}

Rrs.Observer = (function() {
  var instance;

  instance = null;

  Observer.instance = function() {
    return instance != null ? instance : instance = new Rrs.Observer;
  };

  function Observer() {
    this._listeners = {};
  }

  Observer.prototype.emit = function(inNamespace, inSignalName, inData) {
    var namespacedSignal, _ref, _ref1;
    namespacedSignal = "" + inNamespace + ":" + inSignalName;
    if (this._listeners[namespacedSignal] != null) {
      Rrs.logger.debug("Emitting namespaced signal " + namespacedSignal + ".", this._listeners);
      if ((_ref = this._listeners[namespacedSignal].callback) != null) {
        _ref.call(this._listeners[namespacedSignal].context, inData);
      }
    }
    if (this._listeners[inSignalName] != null) {
      Rrs.logger.debug("Emitting broadcast signal " + namespacedSignal + ".", this._listeners);
      return (_ref1 = this._listeners[inSignalName].callback) != null ? _ref1.call(this._listeners[inSignalName].context, inData) : void 0;
    }
  };

  Observer.prototype.listen = function(inNamespace, inSignalName, callback, context) {
    var signal;
    if (inNamespace) {
      signal = "" + inNamespace + ":" + inSignalName;
    } else {
      signal = inSignalName;
    }
    if (context == null) {
      throw new Error("Conext is not set for " + signal);
    }
    if (callback == null) {
      throw new Error("Callback is not set for " + signal);
    }
    Rrs.logger.debug("Attaching listener to " + signal + " signal.", this._listeners);
    return this._listeners[signal] = {
      callback: callback,
      context: context
    };
  };

  return Observer;

})();
