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
		options_list = Kernel.const_get("ApplicationHelper::#{type}")
		options_list = options_list.unshift('Select All')
		options_list
	end

end
