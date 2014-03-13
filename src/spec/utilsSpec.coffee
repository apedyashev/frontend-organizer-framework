describe "Rrs.mixOf", ->
  it "added mix in another classes to a new class", ->
    class Mixin1
      mixin1Method: ->
      mixin1Prop: 1
    class Mixin2
      mixin2Method: ->
      mixin2Prop: 2
    class Mixin3
      mixin3Method: ->
      mixin3Prop: 3

    class ConstructedClass extends Rrs.mixOf Mixin1, Mixin2, Mixin3
    constructedClassInst = new ConstructedClass

    expect(constructedClassInst.mixin1Method).toBeDefined()
    expect(constructedClassInst.mixin2Method).toBeDefined()
    expect(constructedClassInst.mixin3Method).toBeDefined()

    expect(constructedClassInst.mixin1Prop).toEqual(1)
    expect(constructedClassInst.mixin2Prop).toEqual(2)
    expect(constructedClassInst.mixin3Prop).toEqual(3)

