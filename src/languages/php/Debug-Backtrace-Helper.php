<?php

/**
 * Reformat debug backtrace messages to a more simple and readable format.
 * Output only the required information (setup as needed).
 */
class Debug_Backtrace_Helper
{
  /**
   * Run method on class instance call.
   *
   * @param  boolean  $mode  Define level of details in output.
   */
  public function __invoke($mode = null)
  {
    $debug_backtrace = debug_backtrace(DEBUG_BACKTRACE_PROVIDE_OBJECT);
    $result          = [];

    if (!$debug_backtrace) {
      return [];
    }

    foreach ($debug_backtrace as $index) {
      if ($mode) {
        $result['combined'][] = $index['class'] . '->' . $index['function'];
      } else {
        $result['file'][]     = $index['file'];
        $result['line'][]     = $index['line'];
        $result['function'][] = $index['function'];
        $result['class'][]    = $index['class'];
        $result['object'][]   = $index['object'];
        $result['type'][]     = $index['type'];
        $result['args'][]     = $index['args'];
      }
    }

    return $result;
  }
}

// ---------------------------------------------------------------------------------------------------------------------------- Example call

$Debug_Backtrace_Helper = new Debug_Backtrace_Helper();

var_dump($Debug_Backtrace_Helper());
var_dump($Debug_Backtrace_Helper(true));
