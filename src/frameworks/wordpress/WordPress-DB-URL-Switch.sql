-- CONFIG

SET @prefix = 'wp_XXXX';

-- DEV -> LIVE
SET @url_from = 'http://127.0.0.1';
SET @url_to   = 'https://www.example.com';

-- LIVE -> DEV
/* * /
SET @_url_from = @url_from;
SET @url_from  = @url_to;
SET @url_to    = @_url_from;
/* */


-- QUERIES

SET @sql1 = CONCAT('UPDATE ', @prefix, '_options  SET  option_value = replace(option_value, ?, ?) WHERE option_name = "home" OR option_name = "siteurl"');
SET @sql2 = CONCAT('UPDATE ', @prefix, '_posts    SET `guid`        = replace(`guid`, ?, ?)');
SET @sql3 = CONCAT('UPDATE ', @prefix, '_posts    SET  post_content = replace(post_content, ?, ?)');
SET @sql4 = CONCAT('UPDATE ', @prefix, '_postmeta SET  meta_value   = replace(meta_value, ?, ?)');


-- RUN

PREPARE stmt1 FROM @sql1;
PREPARE stmt2 FROM @sql2;
PREPARE stmt3 FROM @sql3;
PREPARE stmt4 FROM @sql4;

EXECUTE stmt1 USING @url_from, @url_to;
EXECUTE stmt2 USING @url_from, @url_to;
EXECUTE stmt3 USING @url_from, @url_to;
EXECUTE stmt4 USING @url_from, @url_to;

DEALLOCATE PREPARE stmt1;
DEALLOCATE PREPARE stmt2;
DEALLOCATE PREPARE stmt3;
DEALLOCATE PREPARE stmt4;
