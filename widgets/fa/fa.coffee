class Dashing.Fa extends Dashing.Widget

  @accessor 'state', Dashing.AnimatedValue

 # ready: ->
    # This is fired when the widget is done being rendered
  constructor: ->
    super
    @onData(Dashing.lastEvents[@id]) if Dashing.lastEvents[@id]

  onData: (data) ->
    # data is passed in from Dashing as the json map for the metric
    # see doc-templates/product-template.json for examples
    # expect trend, data value and whether active or not

    # icon to use comes from a combination of metric settings
    # if metric is not active (active==false) then use pause metric
    # otherwise if trend is <0, 0 or >0 use rewind, pause or play as icon names respectively


    if(!data.metric?) then return

    node = $(@node)

    # remove old rendering
    node.removeClass("trend-disabled")
    node.removeClass("trend-positive")
    node.removeClass("trend-negative")
    node.removeClass("trend-stable")


    # active nodes are given an icon and a backgroud colour to suit
    # inactive nodes are greyed out with no icon
    metric=data.metric

    if metric.active? and !metric.active
        # inactive
        node.addClass("trend-disabled")
    else

        # active (default is stable)
        trend_state="trend-stable"
        icon_name="pause"

        if metric.trend?
           if metric.trend<0
                trend_state="trend-negative"
                icon_name="backward"
           if metric.trend>0
                trend_state="trend-positive"
                icon_name="play"

    # apply new state

    @set 'icon', icon_name

    node.addClass(trend_state)

    # add text if active and not in summary mode
    if trend_state!='trend-disabled' and !data.summary then  @set 'value', metric.value

    # nice effects..
    node.fadeOut().fadeIn()
