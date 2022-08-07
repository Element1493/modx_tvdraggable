{if $tv->elements}
	<input type="hidden" id="tv{$tv->id}" name="tv{$tv->id}" value="">
	<div id="TVDraggable-{$tv->id}" class="TVDraggable">
		<div class="row">
			<div class="col">
				<div id="TVDraggable-add-{$tv->id}" class="TVDraggable-add list-group">
					{foreach $tv_left as $element}
						<div class="list-group-item">
							{if $element['options']}
								<div class="TVDraggable-dropdown">
									<button class="TVDraggable-button TVDraggable-dropdown-toggle" data-value="{$element['value']}" data-name="{$element['label']}"><i class="icon-move"></i><span>{$element['label']}</span></button>
									<div class="TVDraggable-dropdown-menu">
										{foreach $element['options'] as $name=>$option}
											<div class="TVDraggable-dropdown-item">
												<label for="tv{$tv->id}-{$element['value']}-{$name}">{$option['label']}</label>
												<input type="text" id="tv{$tv->id}-{$element['value']}-{$name}" class="x-form-text x-form-field" name="{$name}" value="{$option['value']}" data-label="{$option['label']}"/>
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
					{foreach $tv_right as $element}
						<div class="list-group-item">
							{if $element['options']}
								<div class="TVDraggable-dropdown">
									<button class="TVDraggable-button TVDraggable-dropdown-toggle" data-value="{$element['value']}" data-name="{$element['label']}"><i class="icon-move"></i><span>{$element['label']}</span></button>
									<div class="TVDraggable-dropdown-menu">
										{foreach $element['options'] as $name=>$option}
											<div class="TVDraggable-dropdown-item">
												<label for="tv{$tv->id}-{$element['value']}-{$name}">{$option['label']}</label>
												<input type="text" id="tv{$tv->id}-{$element['value']}-{$name}" class="x-form-text x-form-field" name="{$name}" value="{$option['value']}" data-label="{$option['label']}"/>
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
	<script>// <![CDATA[{literal}TVDraggable.initialize({"id":"{/literal}{$tv->id}{literal}"{/literal}{if $tv->value},"value":{$tv->value}{/if}{literal}});{/literal}// ]]></script>
{else}
	test
{/if}