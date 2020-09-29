<?php
/**
 * Set default CHMOD if you completely messed up a setup.
 * By default the Contao CMS setup should reset the CHMOD.
 *
 * Copy to web root and run from a webbrowser.
 *
 * @param  string  $dir        Base directory
 * @param  octal   $dirModes   Directory CHMOD
 * @param  octal   $fileModes  File CHMOD
 */
function AllDirChmod ($dir = './', $dirModes = 0755, $fileModes = 0644) {
  $d = new RecursiveDirectoryIterator($dir);

  foreach (new RecursiveIteratorIterator($d, 1) as $path) {
    if ($path->isDir()) {
      chmod($path, $dirModes);
    }
    else if (is_file($path)) {
      chmod($path, $fileModes);
    }
  }
}


AllDirChmod('.');

echo 'AllDirChmod() finished.';
