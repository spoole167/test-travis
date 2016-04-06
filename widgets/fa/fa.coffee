class Dashing.Fa extends Dashing.Widget

  @accessor 'state', Dashing.AnimatedValue

 # ready: ->
    # This is fired when the widget is done being rendered
  constructor: ->
    super
    @onData(Dashing.lastEvents[@id]) if Dashing.lastEvents[@id]

  onData: (data) ->
    console.log(data)
    if (data.icon?) then @set 'icon', data.icon
    node = $(@node)
    value = data.state


    backgroundClass = value
    lastClass = @get "lastClass"
    if (data.state?) then node.toggleClass "#{lastClass} #{backgroundClass}"
    if (data.state?) then @set "lastClass", backgroundClass
    node.fadeOut().fadeIn()
