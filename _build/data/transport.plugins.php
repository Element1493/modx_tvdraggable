<?php
$plugins = array();

$tmp = array(
    'TVDraggable' => array(
        'file' => 'tvdraggable',
        'description' => '',
        'events' => array(
            'OnDocFormRender' => 0,
            'OnManagerPageBeforeRender' => 0,
            'OnTVInputPropertiesList' => 0,
			'OnTVInputRenderList' => 0,
			'OnTVOutputRenderList' => 0,
			'OnTVOutputRenderPropertiesList' => 0
        )
    )
);

foreach ($tmp as $k => $v) {
    /** @var modplugin $plugin */
    $plugin = $modx->newObject('modPlugin');
    /** @noinspection PhpUndefinedVariableInspection */
    $plugin->fromArray(array(
        'name' => $k,
        'description' => @$v['description'],
        'plugincode' => getSnippetContent($sources['source_core'] . '/elements/plugins/plugin.' . $v['file'] . '.php'),
        'static' => BUILD_PLUGIN_STATIC,
        'source' => 1,
        'static_file' => 'core/components/' . PKG_NAME_LOWER . '/elements/plugins/plugin.' . $v['file'] . '.php',
    ), '', true, true);

    $events = array();
    if (!empty($v['events']) && is_array($v['events'])) {
        foreach ($v['events'] as $name => $priority) {
            /** @var $event modPluginEvent */
            $event = $modx->newObject('modPluginEvent');
            $event->fromArray(array(
                'event' => $name,
                'priority' => $priority,
                'propertyset' => 0,
            ), '', true, true);
            $events[] = $event;
        }
        unset($v['events']);
    }

    if (!empty($events)) {
        $plugin->addMany($events);
    }

    $plugins[] = $plugin;
}

return $plugins;