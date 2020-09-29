<?php

/**
 * A few different ways to do debugging and logging in Magento.
 * The output is spare - specific extensions are recommended.
 */

# -------------------------------------------------------------------------------------------------------------------------------- Debugging

// \app\code\core\Mage\Core\functions.php
mageDebugBacktrace(false, true, true);

// Backtrace variant
$result = Varien_Debug::backtrace(true, true, true);

// ... and as plain PHP
$result = array_reverse(debug_backtrace(), true);


// Get variables (check if defined in scope)
$vars    = get_defined_vars();
$newVars = $model->getData();
$vars    = array_diff(get_defined_vars(), $vars);


# ---------------------------------------------------------------------------------------------------------------------------------- Logging

Zend_Debug::dump($vars);

Mage::log($vars, null, 'var-debug.log', true);

Mage::getModel('core/log_adapter', 'custom.log')
  ->log(['example', 1, false]);
