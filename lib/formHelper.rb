# Data for select field
WEEKDAYS = [
	"sunday",
	"monday",
	"tuesday",
	"wednesday",
	"thursday",
	"friday",
	"saturday"
]

# Set ready for select field. Get data from db!
GETSTUDIOS = Studio.all.collect(&:name)
GETSTYLES = Style.all.collect(&:stil)