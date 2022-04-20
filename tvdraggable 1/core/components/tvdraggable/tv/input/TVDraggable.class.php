<?php
class modTemplateVarInputRenderTVDraggable extends modTemplateVarInputRender{
	public function getTemplate(){
		if(is_file(MODX_BASE_PATH.$this->tv->get('elements')) && file_exists(MODX_BASE_PATH.$this->tv->get('elements'))){
			$elements = json_decode(file_get_contents(MODX_BASE_PATH.$this->tv->get('elements')), true);
		}else{
			$elements = json_decode($this->tv->get('elements'), true);
		}
		
		if($arValue = json_decode($this->tv->get('value'),true)){
			foreach($arValue as $row){
				$tvValue[] = $row['value'];
				$tvOptions[$row['value']] = $row['options'];
			}
			foreach($elements as $element){
				if(in_array($element['value'], $tvValue)){
					foreach($tvOptions[$element['value']] as $value=>$option){
						$element['options'][$value]['value'] = $option['value'];
					}
					$elements_left[] = $element;
					
				}
				if(!in_array($element['value'], $tvValue)){
					$elements_right[] = $element;
				}
			}
		}else{
			$elements_left = [];
			$elements_right = $elements;
		}
		$this->setPlaceholder('test', $elements);
		$this->setPlaceholder('tv_left', $elements_left);
		$this->setPlaceholder('tv_right', $elements_right);
	
		$corePath = $this->modx->getOption('table.core_path', null, $this->modx->getOption('core_path') . 'components/tvdraggable/');
		return $corePath . 'tv/input/tpl/tv.TVDraggable.input.tpl';
	}

}

return 'modTemplateVarInputRenderTVDraggable';