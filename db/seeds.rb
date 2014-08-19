#encoding: utf-8
Admin.delete_all
Studio.delete_all
Style.delete_all
Course.delete_all
# Generate Admin
Admin.create!(
	name: "admin",
	password: "qwe123"
)
# generate studios
Studio.create!([
	{ name: "Yellow Yoga",
		address: %{ Mariannenstraße 48, 10997 Berlin },
		url: "http://yellow-yoga.com/"},
	{ name: "Bikram Yoga Mitte",
		address: %{ Neue Schönhauser Str. 19, 10178 Berlin },
		url: "http://www.bikram-berlin.de/"	},
	{ name: "SUN YOGA Friedrichshain" ,
		address: %{ Torellstr. 7, 10243 Berlin },
		url: "http://www.sunyoga.de/studio_friedrichshain.htm" }
])

#generate styles

allStile = %w(ashtanga vinyasa jivamukti kundalini meditatives\ hatha hatha acroyoga yin\ yang
 bikram hot\ yoga pilates)

allStile.each do |x|
  Style.create!( stil: x )
end
yy = Studio.find_by(name: "Yellow Yoga")
bym = Studio.find_by(name: "Bikram Yoga Mitte")
sy = Studio.find_by(name: "SUN YOGA Friedrichshain")
allStyle = Style.all

# Yellow Yoga Seed
Course.create!([
{
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "07:00",
	end: "08:30",
	weekday: "monday"
},
{
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "09:00",
	end: "10:00",
	weekday: "monday"
},
{
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "10:30",
	end: "11:45",
	weekday: "monday"
},
{
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "hatha").id,
	start: "12:15",
	end: "13:30",
	weekday: "monday"
},
{
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "14:00",
	end: "15:30",
	weekday: "monday"
},
{
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "jivamukti").id,
	start: "16:00",
	end: "18:00",
	weekday: "monday"
}])

# tuesday
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "07:00",
	end: "08:30",
	weekday: "tuesday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "09:00",
	end: "10:00",
	weekday: "tuesday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "jivamukti").id,
	start: "10:30",
	end: "11:45",
	weekday: "tuesday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "hatha").id,
	start: "12:15",
	end: "13:30",
	weekday: "tuesday"
)

Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "16:00",
	end: "18:00",
	weekday: "tuesday"
)

# wednesday
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "07:00",
	end: "08:30",
	weekday: "wednesday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "09:00",
	end: "10:00",
	weekday: "wednesday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "jivamukti").id,
	start: "10:30",
	end: "11:45",
	weekday: "wednesday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "12:15",
	end: "13:30",
	weekday: "wednesday"
)

Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "meditatives hatha").id,
	start: "16:00",
	end: "18:00",
	weekday: "wednesday"
)

# thursday
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "07:00",
	end: "08:30",
	weekday: "thursday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "09:00",
	end: "10:00",
	weekday: "thursday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "10:30",
	end: "11:45",
	weekday: "thursday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "12:15",
	end: "13:30",
	weekday: "thursday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "16:00",
	end: "18:00",
	weekday: "thursday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "yin yang").id,
	start: "18:30",
	end: "20:00",
	weekday: "thursday"
)

# saturday
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "07:00",
	end: "08:30",
	weekday: "friday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "09:00",
	end: "10:00",
	weekday: "friday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "jivamukti").id,
	start: "10:30",
	end: "11:45",
	weekday: "friday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "yin yang").id,
	start: "12:15",
	end: "13:30",
	weekday: "friday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "acroyoga").id,
	start: "16:00",
	end: "18:00",
	weekday: "friday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "meditatives hatha").id,
	start: "18:30",
	end: "20:00",
	weekday: "friday"
)
# saturday
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "10:30",
	end: "11:45",
	weekday: "saturday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "12:15",
	end: "13:30",
	weekday: "saturday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "16:00",
	end: "18:00",
	weekday: "saturday"
)
# sunday
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "10:30",
	end: "11:45",
	weekday: "sunday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "12:15",
	end: "13:30",
	weekday: "sunday"
)
Course.create!(
	studio_id: yy.id ,
	style_id: allStyle.find_by(stil: "meditatives hatha").id,
	start: "16:00",
	end: "18:00",
	weekday: "sunday"
)

# Bikram Yoga Mitte
# Bikram Yoga Mitte
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "07:00",
	end: "08:30",
	weekday: "monday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "10:30",
	end: "11:45",
	weekday: "monday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "12:15",
	end: "13:30",
	weekday: "monday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "14:00",
	end: "15:30",
	weekday: "monday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "16:00",
	end: "18:00",
	weekday: "monday"
)
# tuesday
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "07:00",
	end: "08:30",
	weekday: "tuesday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "09:00",
	end: "10:00",
	weekday: "tuesday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "12:15",
	end: "13:30",
	weekday: "tuesday"
)

Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "16:00",
	end: "18:00",
	weekday: "tuesday"
)

# wednesday
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "07:00",
	end: "08:30",
	weekday: "wednesday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "10:30",
	end: "11:45",
	weekday: "wednesday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "12:15",
	end: "13:30",
	weekday: "wednesday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "16:00",
	end: "18:00",
	weekday: "wednesday"
)

# thursday
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "07:00",
	end: "08:30",
	weekday: "thursday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "09:00",
	end: "10:00",
	weekday: "thursday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "10:30",
	end: "11:45",
	weekday: "thursday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "12:15",
	end: "13:30",
	weekday: "thursday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "16:00",
	end: "18:00",
	weekday: "thursday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "18:30",
	end: "20:00",
	weekday: "thursday"
)

# saturday
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "07:00",
	end: "08:30",
	weekday: "friday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "09:00",
	end: "10:00",
	weekday: "friday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "10:30",
	end: "11:45",
	weekday: "friday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "12:15",
	end: "13:30",
	weekday: "friday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "16:00",
	end: "18:00",
	weekday: "friday"
)
# saturday
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "10:30",
	end: "11:45",
	weekday: "saturday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "acroyoga").id,
	start: "12:15",
	end: "13:30",
	weekday: "saturday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "16:00",
	end: "18:00",
	weekday: "saturday"
)
# sunday
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "hatha").id,
	start: "10:30",
	end: "11:45",
	weekday: "sunday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "12:15",
	end: "13:30",
	weekday: "sunday"
)
Course.create!(
	studio_id: bym.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "16:00",
	end: "18:00",
	weekday: "sunday"
)
# Sun Yoga
# Sun Yoga
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "07:00",
	end: "08:30",
	weekday: "monday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "10:30",
	end: "11:45",
	weekday: "monday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "12:15",
	end: "13:30",
	weekday: "monday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "14:00",
	end: "15:30",
	weekday: "monday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "16:00",
	end: "18:00",
	weekday: "monday"
)
# tuesday
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "hot yoga").id,
	start: "07:00",
	end: "08:30",
	weekday: "tuesday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "09:00",
	end: "10:00",
	weekday: "tuesday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "12:15",
	end: "13:30",
	weekday: "tuesday"
)

Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "jivamukti").id,
	start: "16:00",
	end: "18:00",
	weekday: "tuesday"
)

# wednesday
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "vinyasa").id,
	start: "07:00",
	end: "08:30",
	weekday: "wednesday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "10:30",
	end: "11:45",
	weekday: "wednesday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "12:15",
	end: "13:30",
	weekday: "wednesday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "16:00",
	end: "18:00",
	weekday: "wednesday"
)

# thursday
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "07:00",
	end: "08:30",
	weekday: "thursday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "09:00",
	end: "10:00",
	weekday: "thursday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "10:30",
	end: "11:45",
	weekday: "thursday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "12:15",
	end: "13:30",
	weekday: "thursday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "16:00",
	end: "18:00",
	weekday: "thursday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "18:30",
	end: "20:00",
	weekday: "thursday"
)

# saturday
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "07:00",
	end: "08:30",
	weekday: "friday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "bikram").id,
	start: "09:00",
	end: "10:00",
	weekday: "friday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "hatha").id,
	start: "10:30",
	end: "11:45",
	weekday: "friday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "meditatives hatha").id,
	start: "12:15",
	end: "13:30",
	weekday: "friday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "kundalini").id,
	start: "16:00",
	end: "18:00",
	weekday: "friday"
)
# saturday
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "10:30",
	end: "11:45",
	weekday: "saturday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "acroyoga").id,
	start: "12:15",
	end: "13:30",
	weekday: "saturday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "ashtanga").id,
	start: "16:00",
	end: "18:00",
	weekday: "saturday"
)
# sunday
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "hatha").id,
	start: "10:30",
	end: "11:45",
	weekday: "sunday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "yin yang").id,
	start: "12:15",
	end: "13:30",
	weekday: "sunday"
)
Course.create!(
	studio_id: sy.id ,
	style_id: allStyle.find_by(stil: "pilates").id,
	start: "16:00",
	end: "18:00",
	weekday: "sunday"
)
