fallbackLocation: {latitude: '', longitude: ''} #null island lmao
apikey = ""
makeCommand: (lat, lon) ->
  "curl -sS 'https://api.darksky.net/forecast/#{apikey}/#{lat},#{lon}?units=si&exclude=minutely,alerts,flags'"
refreshFrequency: (60 * 1000) * 10
style: """
  bottom: 1%
  left: 2%
  color: white
  font-family: SF Mono, Menlo
  font-size: 12px
  font-style: italic
  -webkit-font-smoothing: antialiased
  display: inline block
  .symbol
  	display: inline-block
  h2
    color: white
    border-radius: 12px
"""
render: (o) -> """
	<h1>Weather</h1>
	<div>
	<h2 class='main'></h2>
	<h2 class='rain'></h2>
	<h2 class='text'>...</h2>
	</div>
"""

afterRender: (dom) ->
	updateScreen = (coords) =>
		[lat, lon] = [coords.latitude, coords.longitude]
		@command = @makeCommand(lat, lon)
		@refresh()
	geolocationSuccess = false

	setTimeout =>

		if !geolocationSuccess
		  # Geolocation failed
		  updateScreen(@fallbackLocation)

	, 7000

	geolocation.getCurrentPosition (e) =>
		geolocationSuccess = true
		coords     = e.position.coords
		updateScreen(coords)

getCardinal: (angle) ->
	degreePerDirection = 360 / 8
	offsetAngle = angle + degreePerDirection / 2
	if offsetAngle >= 0 * degreePerDirection and offsetAngle < 1 * degreePerDirection then 'N' else if offsetAngle >= 1 *degreePerDirection and offsetAngle < 2 * degreePerDirection then 'NE' else if offsetAngle >= 2 * degreePerDirection and offsetAngle < 3 * degreePerDirection then 'E' else if offsetAngle >= 3 * degreePerDirection and offsetAngle < 4 * degreePerDirection then 'SE' else if offsetAngle >= 4 * degreePerDirection and offsetAngle < 5 * degreePerDirection then 'S' else if offsetAngle >= 5 * degreePerDirection and offsetAngle < 6 * degreePerDirection then 'SW' else if offsetAngle >= 6 * degreePerDirection and offsetAngle < 7 * degreePerDirection then 'W' else 'NW'

update: (output, dom) ->
	if output != undefined
		data = JSON.parse(output)
		console.log(data)
		d = new Date(0)
		d.setUTCSeconds(data.currently.time)
		$(dom).find(".main").html(Math.round(data.currently.apparentTemperature) + "<div class='symbol'>&degC</div> " + @getCardinal(data.currently.windBearing) + " " + Math.round(data.currently.windGust) + "km/h" )
		$(dom).find(".rain").html(Math.round(data.currently.precipProbability) + "% chance of rain." )		
		$(dom).find(".text").html(data.currently.summary.toLowerCase().toUpperCase().charAt(0) + data.currently.summary.toLowerCase().substring(1) + ".")

