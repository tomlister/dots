refreshFrequency: '60s'

style: """
  color: #000000
  font-family: SF Mono, Menlo
  font-size: 12px
  font-style: italic
  -webkit-font-smoothing: antialiased
  display: inline block
  width: 100%
  height: 100%
  z-index: -1
  background-size: cover
  background-repeat: no-repeat
  background-image: url("REPLACE ME!!!!")
    
"""
render: (o) -> """
	
"""

afterRender: (dom) ->
	updateScreen = () =>
		@refresh()

update: (output, dom) ->
	
