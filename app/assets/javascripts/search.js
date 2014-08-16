/*	JavaScript search for Yogclas front-page rev .01  
*	Get with ajax from courses all classes and the filter it.
*	
*		
*/	
$(function() {
	// Turn on specific css for js.
	$('body').removeClass('jsOff');
	
	
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
		
		// Preselecting filter
		$.each(urlSearch,function(i,v){	
				
			// Check if value existing
			if( !v )
				return false;

			// preselecting timer is a bit tricky due of ascii code, and I'm lazy  
			if( v.indexOf('start') ){	
				// preselecting for weekday and style if existing
				if( $('#'+ v +'').length )
					$('#'+ v +'').val(''+ urlSearch[''+ v +''] +'').attr('selected', true)
			}else{
				// preselect hour and minute
				if(i == 3 )
					jsSearch.find('select[id*="start"]').first()
					.find('option[value="'+ urlSearch[''+ v +''] +'"]')
					.attr('selected',true);
				else
					jsSearch.find('select[id*="start"]').last()
					.find('option[value="'+ urlSearch[''+ v +''] +'"]')
					.attr('selected',true);
			}
		});
		
		// Get all courses and prepare data
		var newAjax = doAjaxRequest('courses');
		
		
		newAjax.success(function(aData){
			var data = $('table',aData).first(),
			timeTabelWrap = $(document.createElement('div')).height(0).css({'overflow':'hidden'});
			
			timeTabelWrap.prop('id','searchResult').append(data);
			jsSearch.after(timeTabelWrap);
		});
		
		var searchResult = $('#searchResult');
		// Catch submit and do filter
		jsSearch.submit(function(){
			var dis			= $(this),
				style_id	= dis.find('#style_id').val(),
				weekday		= dis.find('#weekday').val();
				
			
			
			
			return false
			
		});
		//END jsSearch Click
	};	
	//END activeSearch
	
	// Turn on search if needed
	if(jsSearch.length)
		activatedSearch();
		
});

