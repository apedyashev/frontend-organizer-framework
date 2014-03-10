describe "Rrs.Observer", ->
  observer = null

  beforeEach ->
    observer = Rrs.Observer.instance()

  it "implement the Singleton pattern", ->
    observer2 = Rrs.Observer.instance()
    expect(observer).toEqual( observer2 )


  it "call subscribers callback and passed emitted data to it when namespace is used", ->
    dataToBeSent =
      key: 'val' 

    cb = (data)->
      expect(data).toEqual( dataToBeSent )

    observer.listen 'SomeNamespace', 'some-signal', cb, @
    observer.emit 'SomeNamespace', 'some-signal', dataToBeSent


  it "bind observer to callers context when 'context' param is passed", ->
    me = @
    cb = (data)->
      expect(@).toEqual( me )

    observer.listen 'SomeNamespace', 'some-signal', cb, @
    observer.emit 'SomeNamespace', 'some-signal' 


  it "throws exception when both namespace and signal are passed but context is not passed", ->
    cb        = (data)->
    signal    = "SomeNamespace:some-signal"
    exception = new Error "Conext is not set for #{signal}"
    expect( -> observer.listen('SomeNamespace', 'some-signal', cb) ).toThrow( exception )


  it "throws exception when signal is passed but namespace and context are not passed", ->
    cb        = (data)->
    signal    = "some-signal"
    exception = new Error "Conext is not set for #{signal}"
    expect( -> observer.listen(null, 'some-signal', cb) ).toThrow( exception )


