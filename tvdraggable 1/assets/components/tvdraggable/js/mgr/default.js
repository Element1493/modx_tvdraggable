function DROPDOWN(ID) {
	let SELECTOR = ID.querySelectorAll('.TVDraggable-dropdown')
	if(SELECTOR.length){
		for (let i = 0; i < SELECTOR.length; i++){
			SELECTOR[i].querySelector('.TVDraggable-dropdown-toggle').onclick = function() {
				if(SELECTOR[i].classList.contains('active')){
					SELECTOR[i].classList.remove('active');
				}else{
					SELECTOR[i].classList.add('active');
				}
			};
			document.onclick = function(e){
				if (!SELECTOR[i].contains(e.target)) {
					if(SELECTOR[i].classList.contains('active')) SELECTOR[i].classList.remove('active');	
				};
			};
		}
	}
}
function ITEMS(ID,ADD) {
	let ITEMS = ADD.querySelectorAll('.list-group-item');
	let RESULT = [];
	if(ITEMS.length){
		for (let ITEM = 0; ITEM < ITEMS.length; ITEM++){
			let TV_VALUE = ITEMS[ITEM].querySelector('.TVDraggable-button').getAttribute('data-value');
			let TV_NAME = ITEMS[ITEM].querySelector('.TVDraggable-button').getAttribute('data-name');
			let INPUT = ITEMS[ITEM].querySelectorAll('input');
			RESULT[ITEM] = {};
			RESULT[ITEM]['value'] = TV_VALUE;
			RESULT[ITEM]['label'] = TV_NAME;
			if(INPUT.length){
				RESULT[ITEM]['options'] = {};
				for (let i = 0; i < INPUT.length; i++){
					let NAME = INPUT[i].getAttribute('name');
					RESULT[ITEM]['options'][NAME] = INPUT[i].value;
					ID.value = JSON.stringify(RESULT);
					RESULT[ITEM]['options'][NAME] = {};
					RESULT[ITEM]['options'][NAME]['name'] = INPUT[i].getAttribute('data-label');
					RESULT[ITEM]['options'][NAME]['value'] = INPUT[i].value;
					
					let onINPUT = function(event) {
						RESULT[ITEM]['options'][NAME]['value'] = INPUT[i].value;
						ID.value = JSON.stringify(RESULT);
					};
					
					INPUT[i].oninput = INPUT[i].onchange = INPUT[i].oncut = INPUT[i].oncopy = INPUT[i].onpaste = onINPUT;
				}
			}
			ID.value = JSON.stringify(RESULT);
		}
	}else{
		ID.value = '';
	}
}

var TVDraggable = {
    initialize: function (config) {
		let ID_TV = document.getElementById('tv'+config.id);
		let ID_ADD = document.getElementById('TVDraggable-add-'+config.id);
		let ID_REMOVE = document.getElementById('TVDraggable-remove-'+config.id);	
		
		DROPDOWN(ID_ADD);
		ITEMS(ID_TV,ID_ADD);
		
		ID_TV.value = config.value;
		
		let OPTIONS_ADD = {
			group: 'TV',
			animation: 150,
			onMove: function (e) {
				let DROPDOWN = document.querySelectorAll('.TVDraggable-dropdown');
				if(DROPDOWN.length){
					for (let i = 0; i < DROPDOWN.length; i++){
						DROPDOWN[i].classList.remove('active');
					}
				}
			},
			onEnd: function (e) {
				DROPDOWN(ID_ADD);
				ITEMS(ID_TV,ID_ADD);
			}
		};
		var OPTIONS_REMOVE = {
			group: 'TV',
			animation: 150,
			onMove: function (e) {
				let DROPDOWN = document.querySelectorAll('.TVDraggable-dropdown');
				if(DROPDOWN.length){
					for (let i = 0; i < DROPDOWN.length; i++){
						DROPDOWN[i].classList.remove('active');
					}
				}
			},
			onEnd: function (e) {
				DROPDOWN(ID_ADD);
				ITEMS(ID_TV,ID_ADD);
			}
		};
		new Sortable(ID_ADD,OPTIONS_ADD);
		new Sortable(ID_REMOVE,OPTIONS_REMOVE);
	}
}