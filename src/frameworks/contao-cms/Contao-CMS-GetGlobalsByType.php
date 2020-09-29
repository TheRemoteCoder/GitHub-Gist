<?php

/**
 * Return parts of the $GLOBALS array sorted by type.
 * It's recommended to not return all at once as this might run out of memory.
 */
foreach (array_keys($GLOBALS) as $key) {

  switch (gettype($GLOBALS[$key])) {
    case 'array': {
        debug(array_keys($GLOBALS[$key]));
        break;
      }
    case 'object': {
        debug(get_class_methods($GLOBALS[$key]));
        break;
      }
    default: {
        debug($GLOBALS[$key]);
        break;
      }
  }
}

function debug($value)
{
  // Add own debugging methods here
}
