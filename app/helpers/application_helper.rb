module ApplicationHelper
		# set link active
	def is_active?(link_path)
		current_page?(link_path) ? "active" : ""
	end
  
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

# add show all option
def prepare_form(type)
	if type = 'weekday'
		prep_weekday = WEEKDAYS.clone
		prep_weekday = prep_weekday.unshift('Select All')
		return prep_weekday
	end
	
	if type = 'studio'
		prep_studio = GETSTUDIOS.clone
		prep_studio = prep_studio.unshift('Select All')
		return prep_studio
	end
	
	if type = 'style'
		prep_style = GETSTYLES.clone
		prep_style = prep_style.unshift('Select All')
		return prep_style
	end
	
	
end

	
	
	
end
