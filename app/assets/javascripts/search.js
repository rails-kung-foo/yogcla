/*	JavaScript search for Yogclas front-page rev .02  
*	Get with ajax from courses all classes and the filter it.
*	rev.01 = basic
*	rev.01 = separate search
*		
*/	

var pageLoadReady = function(){
	var jsSearch = $('#jsSearch'),
	activatedSearch = function(){	
		// search function start
		
		var doAjaxRequest = function(href){
			return $.ajax({
					'url': 'http://'+document.location.host+'/'+href
				});	
		},
		getUrlVars = function (url) {
			var vars = [], hash;
			var hashes = url.slice(url.indexOf('?') + 1).split(String.fromCharCode(38));
			for(var i = 0; i < hashes.length; i++){
				hash = hashes[i].split('=');
				vars.push(hash[0]);
				vars[hash[0]] = hash[1];
			}
			return vars;
		},
		urlSearch = getUrlVars(document.location.search);
		
		
		// Get all courses and prepare data
		var newAjax = doAjaxRequest('courses');
		
		// build filter;
		newAjax.success(function(aData){
			var data		= $('table',aData).first(),
			optionShowAll	= $(document.createElement('option')).val(false).text('Show All').attr('selected',true),
			noResult 		= $(document.createElement('p')).text('No Result').prop('id','showNoResult').addClass('hidden'),
			timeTabelWrap 	= $(document.createElement('div')).css({overflow:'hidden',});
			
			$('#style_id').prepend(optionShowAll.clone());
			$('#weekday').prepend(optionShowAll.clone());
			$('#searchTime select').prepend(optionShowAll.clone());
			
			timeTabelWrap.prop('id','searchResult').append(data);
			jsSearch.after(timeTabelWrap, noResult);
			timeTabelWrap.slideUp(0);
			
			// Preselecting filter
			$.each(urlSearch,function(i,v){	
					
				// Check if value existing
				// Time filter changed; needs refactoring
				if( !v )
					return false;

				// preselecting timer is a bit tricky due of ascii code, and I'm lazy  
				if( v.indexOf('start') ){	
					// preselecting for weekday and style if existing
					if( $('#'+ v +'').length )
						$('#'+ v +' option[value*="'+urlSearch[''+ v +'']+'"]').attr('selected', true);
				}else{
					// preselect hour and minute
					if(i == 3 )
						var preselectTimer = jsSearch.find('select[id*="start"]').first();
					else
						var preselectTimer = jsSearch.find('select[id*="start"]').last();
						
					preselectTimer.find('option[value="'+ urlSearch[''+ v +''] +'"]').attr('selected',true);
				}
			});
			filterFuc();
			
			// Show filter for activated JS
			$('body').removeClass('jsOff');
		});
		//END ajax call
		
		// filter logic
		var filterFuc = function(){
			var searchResult = $('#searchResult'),
			allCourses = searchResult.find('tbody').children('tr');

			// Catch submit and do filter
			jsSearch.submit(function(){
				var dis	= $(this);
				dis.attr('disable',true);
				$('#showNoResult').addClass('hidden');
				
				searchResult.fadeOut(400,function(){
					allCourses.addClass('hidden');
					searchResult.removeClass('showAll');
					
					// Find active filter
					var	style_id	= ( dis.find('#style_id').val() != 'false' )? '.'+ dis.find('#style_id').val() : '',
					weekday			= ( dis.find('#weekday').val() != 'false' )? '.'+ dis.find('#weekday').val() : '',
					time 			= ( dis.find('#searchTime select').val() != 'false' )? dis.find('#searchTime select').val() : '';

					if ( time.length == 1 )
						time = '.time0'+ time.toString();
					else if( time.length == 2 )
						time = '.time'+ time.toString();

					firstFilter 	= allCourses.filter(style_id.replace(' ','') + weekday + time);
					
					console.log('time: ' + time +' length: '+ time.length );
					console.log( firstFilter );
					
					if( (style_id+weekday+time).length ){
						if(firstFilter.length){
							// Filter matches courses
							allCourses.filter(firstFilter).removeClass('hidden');
							searchResult.fadeIn(400);
						}else{
							// No match for filter
							$('#showNoResult').removeClass('hidden');
							searchResult.hide();
						}
						
					}else{
						// Show all filter
						searchResult.addClass('showAll');
						searchResult.fadeIn(400);
					}
					console.log('length of filterword: ' + (style_id+weekday+time).length  + ' content of filter: ' + (style_id+weekday+time) );
				});
				
				dis.attr('disable',false);
				return false;
			});
			//END jsSearch Click
		};
		//END function filterFuc
	
	};	
	//END function activeSearch
	
	// Turn on search if needed
	if(jsSearch.length)
		activatedSearch();	
};
$(document).ready(pageLoadReady);
$(document).on('page:load', pageLoadReady);
