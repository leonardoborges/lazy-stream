
#
# stream factory
#

create = (h, t) ->
    
    head: ->
        if h != null
            h()
        else
            t().first()
      
    tail: -> t()
         
    first: ->
        @take(1)[0]
        
    take: (max) ->
        if max == 1
            [@head()]
        else
            [@head()].concat (t().take (max-1))

    filter: (test) ->
        if test @head()
            create h, -> t().filter test
        else
            t().filter test
        
    map: (transform) ->
        create (-> transform h()), (-> t().map transform)


#
# utility methods
#

range = (start) -> 
    create (-> start), (-> range start+1)

fromArray = (arr) ->
    create (-> arr[0]), (-> fromArray arr.slice 1)

cycle = (arr) ->
    create (-> arr[0]), (-> cycle arr.slice(1).concat([arr[0]]))

zip = (streams...) ->
    heads = streams.reduce ((acc, item) -> acc.concat(item.head())), []
    tails = streams.reduce ((acc, item) -> acc.concat(item.tail())), []
    create (-> heads), (-> zip.apply null, tails)


#
# node module exports
#

exports.create = create
exports.range = range
exports.fromArray = fromArray
exports.cycle = cycle
exports.zip = zip
