<?php
$corePath = $modx->getOption('core_path', null, MODX_CORE_PATH).'components/tvdraggable/';
$assetsUrl = $modx->getOption('assets_url', null, MODX_CORE_PATH).'components/tvdraggable/';
switch ($modx->event->name) {
    case 'OnTVInputRenderList':
        $modx->event->output($corePath.'tv/input/');
        break;
    case 'OnTVOutputRenderList':
        //$modx->event->output($corePath.'tv/output/');
        break;
    case 'OnTVInputPropertiesList':
        //$modx->event->output($corePath.'tv/inputoptions/');
        break;
    case 'OnTVOutputRenderPropertiesList':
        //$modx->event->output($corePath.'tv/properties/');
        break;
    case 'OnManagerPageBeforeRender':
        break;
    case 'OnDocFormRender':
        $modx->regClientCSS($assetsUrl.'css/mgr/default.css');
        $modx->regClientStartupScript($assetsUrl.'js/mgr/default.js');
        $modx->regClientStartupScript($assetsUrl.'js/mgr/Sortable.min.js');
        break;
}