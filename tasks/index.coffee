refreshFrequency: '60s'
dates: {
		'Events': {
			"Example 1":'4/20/2020'
		}
		'Work': {
      "Example 2":'5/20/2020'
		}
	}
style: """
  top: 4.5%
  left: 2%
  color: black
  font-family: SF Mono, Menlo
  font-size: 12px
  font-style: italic
  -webkit-font-smoothing: antialiased
  display: inline block
  h1
    color: white
  h2
    color: white
  .symbol
  	display: inline-block
  h3 i
  	vertical-align: middle
  h3
    font-weight: normal !important
  .event
    background-color: white
    border-radius: 12px
    line-height: 2
    padding-left: 10px
    padding-right: 10px
    display: -webkit-flex
	display: flex
    justify-content: space-between
  .eventname
    font-weight: bold
    margin-right:auto
  .days
    font-weight: normal
    margin-left: 10px
    color: darkred
  h2
  	font-style: normal
  	font-weight: bold
  .emoji
    font-style: normal
    display: inline-block
    margin-left: 10px
  .add
    font-style: normal
  .eventadd
    background-color: white
    border-radius: 12px
    line-height: 2
    padding-left: 10px
    padding-right: 10px
    text-align: center
    
    
"""
render: (o) -> """
	<h1>Upcoming stuff</h1>
	<div></div>
"""

afterRender: (dom) ->
	updateScreen = () =>
		@refresh()

run_calc: (datestring) ->
	today = new Date
	date2 = new Date(datestring)
	tdiff = date2.getTime() - today.getTime()
	ddiff = Math.ceil(tdiff / (1000 * 3600 * 24))
	ddiff

update: (output, dom) ->
	$(dom).find('div').html ''
	for p of @dates
		if @dates.hasOwnProperty(p)
			$(dom).find('div').append('<h2>'+p+'</h2>')
			if Object.keys(@dates[p]).length == 0
				$(dom).find('div').append('<h3 class="event"><span class="eventname">Nothing<span class="emoji">🙌</span></span></h3>')
				continue
			for p2 of @dates[p]
				if @dates[p].hasOwnProperty(p2)
					days_until = @run_calc(@dates[p][p2])
					if days_until >= 0
						$(dom).find('div').append('<h3 class="event"><span class="eventname">'+p2+'</span> <span class="days">'+days_until+' days</span></h3>')
					else
				else
		else

