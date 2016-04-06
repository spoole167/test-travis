class Dashing.Metric extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue

  @accessor 'difference', ->
    if @get('last')
      last = parseInt(@get('last'))
      current = parseInt(@get('current'))
      if last != 0
        diff = Math.abs(Math.round((current - last) / last * 100))
        "#{diff}%"
    else
      ""

  @accessor 'arrow', ->
    if @get('last')
    	    if (@get('direction')) == "desc"
    	    	    if parseInt(@get('current')) > parseInt(@get('last')) then 'icon-arrow-up desc' 
    	    	    else if parseInt(@get('current')) < parseInt(@get('last')) then  'icon-arrow-down asc'  else 'icon-arrow-left same'
    	    else
 	    	    if parseInt(@get('current')) > parseInt(@get('last')) then 'icon-arrow-down desc' else 'icon-arrow-up asc'
	    	    
    	    	    	    
  onData: (data) ->
    if (@get('ignore'))=="yes"
    	    backcolon="rgba(150,191,71,0.2)"
    	    backcoloff="rgba(255,51,51,0.2)"
    	    backurl="../../assets/cyclef.png"
    else
    	    backcolon="#96bf48"
    	    backcoloff="#f33"
    	    backurl="../../assets/cycle1.png"
    	    
    if (@get('direction')) == "desc"
    	    if parseInt(@get('current')) > parseInt(@get('target')) then backgroundClass = backcoloff  else backgroundClass = backcolon
    else
    	    if parseInt(@get('current')) > parseInt(@get('target')) then backgroundClass = backcolon  else backgroundClass = backcoloff
    	    	    
    node = $(@node)
    node.css('background-color', "#{backgroundClass}")
   # node.css('background', "#{backgroundClass} url(#{backurl}) no-repeat")
   # node.css('background-size', "25%")
