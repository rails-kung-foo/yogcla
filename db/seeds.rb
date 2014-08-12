#encoding: utf-8

Studio.delete_all
Style.delete_all
Course.delete_all
# generate studios
Studio.create!(
	name: "Yellow Yoga",
	address: %{ Mariannenstraße 48, 10997 Berlin },
	url: "http://yellow-yoga.com/"
)
Studio.create!(
	name: "Bikram Yoga Mitte",
	address: %{ Neue Schönhauser Str. 19, 10178 Berlin },
	url: "http://www.bikram-berlin.de/"
)
Studio.create!(
	name: "SUN YOGA Friedrichshain" ,
	address: %{ Torellstr. 7, 10243 Berlin },
	url: "http://www.sunyoga.de/studio_friedrichshain.htm"
)

#generate styles

allStile = %w(ashtanga vinyasa jivamukti kundalini meditatives\ hatha hatha acroyoga yin\ yang
 bikram hot\ yoga pilates)

allStile.each do |x|
  Style.create!( stil: x )
end
