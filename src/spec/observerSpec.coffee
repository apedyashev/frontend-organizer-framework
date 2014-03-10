describe "Rrs.Observer", ->
  observer = null

  beforeEach ->
    observer = Rrs.Observer.instance()


  it "implement the Singleton pattern", ->
    observer2 = Rrs.Observer.instance()
    expect(observer).toEqual( observer2 )



  it "Call only callback of subscriber, that has the same namespace and signal name, but doesn't call the rest(namespace is the same for ALL)", ->
    dataToBeSent1 =
      key: 'val' 
    dataToBeSent2 =
      key2: 'val2' 
    dataToBeSent3 =
      key3: 'val3' 

    callCnt = 0 
    cb = (data)->
      callCnt++
      expect(data).toEqual( dataToBeSent1 )

    observer.listen 'SomeNamespace', 'some-signal1', cb, @

    observer.emit 'SomeNamespace', 'some-signal1', dataToBeSent1
    observer.emit 'SomeNamespace', 'some-signal2', dataToBeSent2
    observer.emit 'SomeNamespace', 'some-signal3', dataToBeSent3

    expect(callCnt).toEqual( 1 )




  it "Call only callback of subscriber, that has the same namespace and signal name, but doesn't call the rest(signall is the same for ALL)", ->
    dataToBeSent1 =
      key: 'val' 
    dataToBeSent2 =
      key2: 'val2' 
    dataToBeSent3 =
      key3: 'val3' 

    callCnt = 0 
    cb = (data)->
      callCnt++
      expect(data).toEqual( dataToBeSent1 )

    observer.listen 'SomeNamespace1', 'some-signal', cb, @

    observer.emit 'SomeNamespace1', 'some-signal', dataToBeSent1
    observer.emit 'SomeNamespace2', 'some-signal', dataToBeSent2
    observer.emit 'SomeNamespace3', 'some-signal', dataToBeSent3

    expect(callCnt).toEqual( 1 )



  it "call subscribers callback and pass emitted data to it when namespace is used", ->
    dataToBeSent =
      key: 'val' 
    callCnt = 0 
    cb = (data)->
      callCnt++
      expect(data).toEqual( dataToBeSent )

    observer.listen 'SomeNamespace', 'some-signal', cb, @
    observer.emit 'SomeNamespace', 'some-signal', dataToBeSent

    expect(callCnt).toEqual( 1 )


  it "DOESN't call subscribers callback when namespases are different", ->
    callCnt = 0
    cb = (data)->
      callCnt++

    observer.listen 'SomeNamespace1', 'some-signal', cb, @
    observer.emit 'SomeNamespace2', 'some-signal' 

    expect(callCnt).toEqual( 0 )



  it "DOESN't call subscribers callback when signal names are the same", ->
    callCnt = 0
    cb = (data)->
      callCnt++

    observer.listen 'SomeNamespace', 'some-signal1', cb, @
    observer.emit 'SomeNamespace', 'some-signal2' 

    expect(callCnt).toEqual( 0 )




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



  it "throws exception when both namespace and signal are passed but callback is not passed", ->
    signal    = "SomeNamespace:some-signal"
    exception = new Error "Callback is not set for #{signal}"
    expect( -> observer.listen('SomeNamespace', 'some-signal', null, @) ).toThrow( exception )



  it "throws exception when signal is passed but namespace and callback are not passed", ->
    cb        = (data)->
    signal    = "some-signal"
    exception = new Error "Callback is not set for #{signal}"
    expect( -> observer.listen(null, 'some-signal', null, @) ).toThrow( exception )


