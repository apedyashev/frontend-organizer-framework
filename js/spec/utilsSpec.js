// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

describe("Rrs.mixOf", function() {
  return it("added mix in another classes to a new class", function() {
    var ConstructedClass, Mixin1, Mixin2, Mixin3, constructedClassInst;
    Mixin1 = (function() {
      function Mixin1() {}

      Mixin1.prototype.mixin1Method = function() {};

      Mixin1.prototype.mixin1Prop = 1;

      return Mixin1;

    })();
    Mixin2 = (function() {
      function Mixin2() {}

      Mixin2.prototype.mixin2Method = function() {};

      Mixin2.prototype.mixin2Prop = 2;

      return Mixin2;

    })();
    Mixin3 = (function() {
      function Mixin3() {}

      Mixin3.prototype.mixin3Method = function() {};

      Mixin3.prototype.mixin3Prop = 3;

      return Mixin3;

    })();
    ConstructedClass = (function(_super) {
      __extends(ConstructedClass, _super);

      function ConstructedClass() {
        return ConstructedClass.__super__.constructor.apply(this, arguments);
      }

      return ConstructedClass;

    })(Rrs.mixOf(Mixin1, Mixin2, Mixin3));
    constructedClassInst = new ConstructedClass;
    expect(constructedClassInst.mixin1Method).toBeDefined();
    expect(constructedClassInst.mixin2Method).toBeDefined();
    expect(constructedClassInst.mixin3Method).toBeDefined();
    expect(constructedClassInst.mixin1Prop).toEqual(1);
    expect(constructedClassInst.mixin2Prop).toEqual(2);
    return expect(constructedClassInst.mixin3Prop).toEqual(3);
  });
});

describe("Rrs.Obj", function() {
  describe("provides the getClass() function that", function() {
    it("returns class name when instance of class is passed", function() {
      var obj;
      obj = UserPanelWidget.create();
      return expect(Rrs.Obj.getClass(obj)).toEqual('UserPanelWidget');
    });
    it("returns class name when class is passed", function() {
      return expect(Rrs.Obj.getClass(UserPanelWidget)).toEqual('UserPanelWidget');
    });
    return it("returns result of typeof operation", function() {
      expect(Rrs.Obj.getClass('some sting')).toEqual('string');
      expect(Rrs.Obj.getClass(1)).toEqual('number');
      expect(Rrs.Obj.getClass(1.1)).toEqual('number');
      expect(Rrs.Obj.getClass([1, 4])).toEqual('Array');
      return expect(Rrs.Obj.getClass({})).toEqual('Object');
    });
  });
  describe("provides the extend() function that", function() {
    it("extends object with properties", function() {
      var object, params;
      object = {
        prop1: 1,
        prop2: 2
      };
      params = {
        prop3: 3,
        prop4: 4
      };
      Rrs.Obj.extend(object, params);
      expect(object.prop1).toEqual(1);
      expect(object.prop2).toEqual(2);
      expect(object.prop3).toEqual(3);
      return expect(object.prop4).toEqual(4);
    });
    it("extends object with functions", function() {
      var fn1, fn2, fn3, fn4, object, params;
      fn1 = function() {
        return 1;
      };
      fn2 = function() {
        return 2;
      };
      fn3 = function() {
        return 3;
      };
      fn4 = function() {
        return 4;
      };
      object = {
        fn1: fn1,
        fn2: fn2
      };
      params = {
        fn3: fn3,
        fn4: fn4
      };
      Rrs.Obj.extend(object, params);
      expect(object.fn1).toEqual(fn1);
      expect(object.fn2).toEqual(fn2);
      expect(object.fn3).toEqual(fn3);
      return expect(object.fn4).toEqual(fn4);
    });
    it("extends object with both props and functions", function() {
      var fn1, fn2, fn3, fn4, object, params;
      fn1 = function() {
        return 1;
      };
      fn2 = function() {
        return 2;
      };
      fn3 = function() {
        return 3;
      };
      fn4 = function() {
        return 4;
      };
      object = {
        fn1: fn1,
        fn2: fn2,
        prop1: 1,
        prop2: 2
      };
      params = {
        fn3: fn3,
        fn4: fn4,
        prop3: 3,
        prop4: 4
      };
      Rrs.Obj.extend(object, params);
      expect(object.prop1).toEqual(1);
      expect(object.prop2).toEqual(2);
      expect(object.prop3).toEqual(3);
      expect(object.prop4).toEqual(4);
      expect(object.fn1).toEqual(fn1);
      expect(object.fn2).toEqual(fn2);
      expect(object.fn3).toEqual(fn3);
      return expect(object.fn4).toEqual(fn4);
    });
    it("creates empty object and copies params to it if undefined is passed", function() {
      var object, params;
      params = {
        prop3: 3,
        prop4: 4
      };
      object = void 0;
      object = Rrs.Obj.extend(object, params);
      expect(object.prop3).toEqual(3);
      return expect(object.prop4).toEqual(4);
    });
    it("creates empty object and copies params to it if null is passed", function() {
      var object, params;
      params = {
        prop3: 3,
        prop4: 4
      };
      object = null;
      object = Rrs.Obj.extend(object, params);
      expect(object.prop3).toEqual(3);
      return expect(object.prop4).toEqual(4);
    });
    it("doesn't change object if params is null", function() {
      var object;
      object = {
        a: 1
      };
      object = Rrs.Obj.extend(object, null);
      return expect(object).toEqual({
        a: 1
      });
    });
    return it("doesn't change object if params is undefined", function() {
      var object;
      object = {
        a: 12
      };
      object = Rrs.Obj.extend(object, void 0);
      return expect(object).toEqual({
        a: 12
      });
    });
  });
  describe("provides the isString() function that", function() {
    it("returns true if string is passed", function() {
      return expect(Rrs.Obj.isString("365")).toEqual(true);
    });
    it("returns false if a number is passed", function() {
      return expect(Rrs.Obj.isString(1)).toEqual(false);
    });
    it("returns false if an object is passed", function() {
      return expect(Rrs.Obj.isString({})).toEqual(false);
    });
    return it("returns false if a function is passed", function() {
      return expect(Rrs.Obj.isString(function() {})).toEqual(false);
    });
  });
  describe("provides the isObject() function that", function() {
    it("returns true if object is passed", function() {
      return expect(Rrs.Obj.isObject({})).toEqual(true);
    });
    it("returns false if a number is passed", function() {
      return expect(Rrs.Obj.isObject(1)).toEqual(false);
    });
    it("returns false if a string is passed", function() {
      return expect(Rrs.Obj.isObject("123")).toEqual(false);
    });
    return it("returns false if a function is passed", function() {
      return expect(Rrs.Obj.isString(function() {})).toEqual(false);
    });
  });
  describe("provides the isFunction() function that", function() {
    it("returns true if a function is passed", function() {
      return expect(Rrs.Obj.isFunction(function() {})).toEqual(true);
    });
    it("returns false if object is passed", function() {
      return expect(Rrs.Obj.isFunction({})).toEqual(false);
    });
    it("returns false if a number is passed", function() {
      return expect(Rrs.Obj.isFunction(1)).toEqual(false);
    });
    return it("returns false if a string is passed", function() {
      return expect(Rrs.Obj.isFunction("123")).toEqual(false);
    });
  });
  return describe("provides the isJQeryObject() function that", function() {
    it("returns true if a jQuery is passed", function() {
      return expect(Rrs.Obj.isJQeryObject($('body'))).toEqual(true);
    });
    it("returns false if a function is passed", function() {
      return expect(Rrs.Obj.isJQeryObject(function() {})).toEqual(false);
    });
    it("returns false if object is passed", function() {
      return expect(Rrs.Obj.isJQeryObject({})).toEqual(false);
    });
    it("returns false if a number is passed", function() {
      return expect(Rrs.Obj.isJQeryObject(1)).toEqual(false);
    });
    return it("returns false if a string is passed", function() {
      return expect(Rrs.Obj.isJQeryObject("123")).toEqual(false);
    });
  });
});
