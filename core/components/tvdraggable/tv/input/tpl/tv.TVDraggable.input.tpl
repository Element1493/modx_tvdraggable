{if $tv->elements}
	{$elements = []}
	{foreach  explode('||',$tv->elements) as $key=>$value}
		{$value = explode('==',$value)}
		{$elements[$key]['label'] = $value[0]}
		{if $arOptions = json_decode($value[1],true)}
			{foreach $arOptions as $value=>$options}
				{$elements[$key]['value'] = $value}
				{foreach $options as $name=>$option}
					{$elements[$key]['options'][$option] = [
						'name' =>$name,
						'value' => ''
					]}
				{/foreach}
				{break}
			{/foreach}
		{else}
			{$elements[$key]['value'] = $value[1]}
		{/if}
	{/foreach}

	{if $tv_value = json_decode($tv->value,true)}
		{$elements_left = $tv_value}
		{$arValue = []}
		{foreach $tv_value as $element}
			{$arValue[] = $element['value']}
		{/foreach}
		{foreach $elements as $element}
			{if !in_array($element['value'], $arValue)}
				{$elements_right[] = $element}
			{/if}
		{/foreach}
	{else}
		{$elements_left = []}
		{$elements_right = $elements}
	{/if}

	<input type="hidden" id="tv{$tv->id}" name="tv{$tv->id}" value="">
	<div id="TVDraggable-{$tv->id}" class="TVDraggable">
		<div class="row">
			<div class="col">
				<div id="TVDraggable-add-{$tv->id}" class="TVDraggable-add list-group">
					{foreach $elements_left as $element}
						<div class="list-group-item">
							{if $element['options']}
								<div class="TVDraggable-dropdown">
									<button class="TVDraggable-button TVDraggable-dropdown-toggle" data-value="{$element['value']}" data-name="{$element['label']}"><i class="icon-move"></i><span>{$element['label']}</span></button>
									<div class="TVDraggable-dropdown-menu">
										{foreach $element['options'] as $name=>$option}
											<div class="TVDraggable-dropdown-item">
												<label for="tv{$tv->id}-{$element['value']}-{$name}">{$option['name']}</label>
												<input type="text" id="tv{$tv->id}-{$element['value']}-{$name}" class="x-form-text x-form-field" name="{$name}" value="{$option['value']}" data-label="{$option['name']}">
											</div>
										{/foreach}
									</div>
								</div>
							{else}
								<div class="TVDraggable-button" data-value="{$element['value']}" data-name="{$element['label']}"><i class="icon-move"></i><span>{$element['label']}</span></div>
							{/if}
						</div>
					{/foreach}
				</div>
			</div>
			<div class="col">
				<div id="TVDraggable-remove-{$tv->id}" class="TVDraggable-remove list-group">
					{foreach $elements_right as $element}
						<div class="list-group-item">
							{if $element['options']}
								<div class="TVDraggable-dropdown">
									<button class="TVDraggable-button TVDraggable-dropdown-toggle" data-value="{$element['value']}" data-name="{$element['label']}"><i class="icon-move"></i><span>{$element['label']}</span></button>
									<div class="TVDraggable-dropdown-menu">
										{foreach $element['options'] as $name=>$option}
											<div class="TVDraggable-dropdown-item">
												<label for="tv{$tv->id}-{$element['value']}-{$name}">{$option['name']}</label>
												<input type="text" id="tv{$tv->id}-{$element['value']}-{$name}" class="x-form-text x-form-field" name="{$name}" value="{$option['value']}" data-label="{$option['name']}">
											</div>
										{/foreach}
									</div>
								</div>
							{else}
								<div class="TVDraggable-button" data-value="{$element['value']}" data-name="{$element['label']}"><i class="icon-move"></i><span>{$element['label']}</span></div>
							{/if}
						</div>
					{/foreach}
				</div>
			</div>
		</div>
	</div>
	<script>
	// <![CDATA[{literal}
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
		function ITEMS(ID) {
			let ITEMS = ID.querySelectorAll('.list-group-item');
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
							ID_TV.value = JSON.stringify(RESULT);
							RESULT[ITEM]['options'][NAME] = {};
							RESULT[ITEM]['options'][NAME]['name'] = INPUT[i].getAttribute('data-label');
							RESULT[ITEM]['options'][NAME]['value'] = INPUT[i].value;
							
							let onINPUT = function(event) {
								RESULT[ITEM]['options'][NAME]['value'] = INPUT[i].value;
								ID_TV.value = JSON.stringify(RESULT);
							};
							
							INPUT[i].oninput = INPUT[i].onchange = INPUT[i].oncut = INPUT[i].oncopy = INPUT[i].onpaste = onINPUT;
						}
					}
					ID_TV.value = JSON.stringify(RESULT);
				}
			}else{
				ID_TV.value = '';
			}
		}
		
		var ID_TV = document.getElementById('tv{/literal}{$tv->id}{literal}');
		var ID_ADD = document.getElementById('TVDraggable-add-{/literal}{$tv->id}{literal}');
		var ID_REMOVE = document.getElementById('TVDraggable-remove-{/literal}{$tv->id}{literal}');	
		
		DROPDOWN(ID_ADD);
		ITEMS(ID_ADD);
		
		ID_TV.value = '{/literal}{$tv->value}{literal}';
		
		var OPTIONS = {
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
				ITEMS(ID_ADD);
			}
		};
		new Sortable(ID_ADD,OPTIONS);
		new Sortable(ID_REMOVE,OPTIONS);

	{/literal}// ]]>
	</script>
{else}
	Test
{/if}