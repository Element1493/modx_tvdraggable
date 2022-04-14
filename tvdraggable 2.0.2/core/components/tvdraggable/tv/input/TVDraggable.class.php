<?php
class modTemplateVarInputRenderTVDraggable extends modTemplateVarInputRender{
	public function getTemplate(){
		if(!empty($this->tv->get('elements'))){
			$elements = [];
			foreach(explode('||',$this->tv->get('elements')) as $key=>$value){
				$value = explode('==',$value);
				$elements[$key]['label'] = $value[0];
				if($arOptions = json_decode($value[1],true)){
					foreach($arOptions as $value=>$options){
						$elements[$key]['value'] = $value;
						foreach($options as $name=>$option){
							$elements[$key]['options'][$option] = [
								'name' =>$name,
								'value' => ''
							];
						}
						break;
					}
				}else{
					$elements[$key]['value'] = $value[1];
				}
			}
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
		
		$this->setPlaceholder('tv_left', $elements_left);
		$this->setPlaceholder('tv_right', $elements_right);
		$corePath = $this->modx->getOption('table.core_path', null, $this->modx->getOption('core_path') . 'components/tvdraggable/');
		return $corePath . 'tv/input/tpl/tv.TVDraggable.input.tpl';
	}

}

return 'modTemplateVarInputRenderTVDraggable';