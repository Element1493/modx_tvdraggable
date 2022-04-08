<?php
class modTemplateVarInputRenderTVDraggable extends modTemplateVarInputRender{
	public function getTemplate(){
		$corePath = $this->modx->getOption('table.core_path', null, $this->modx->getOption('core_path') . 'components/tvdraggable/');
		return $corePath . 'tv/input/tpl/tv.TVDraggable.input.tpl';
	}

}

return 'modTemplateVarInputRenderTVDraggable';