-- Fast switch all store URLs and cookie settings.
--
-- Useful to synchronize a live DB to a DEV environment.
-- Make sure to change multi-store URLs manually after applying this script.
--
-- Tested with: Magento CE 1.4 - 1.6

-- ------------------------------------------------------------------------------------------------------------------------------ Store URLs

-- WARNING: Overrides ALL stores

UPDATE `core_config_data`
SET `value` = 'http://example.com/'
WHERE `core_config_data`.`path` = 'web/unsecure/base_url' OR
      `core_config_data`.`path` = 'web/unsecure/base_link_url';

UPDATE `core_config_data`
SET `value` = 'https://example.com/'
WHERE `core_config_data`.`path` = 'web/secure/base_url' OR
      `core_config_data`.`path` = 'web/secure/base_link_url';

UPDATE `core_config_data`
SET `value` = 'https://example.com/skin/'
WHERE `core_config_data`.`path` = 'web/secure/base_skin_url';

UPDATE `core_config_data`
SET `value` = 'https://example.com/media/'
WHERE `core_config_data`.`path` = 'web/secure/base_media_url';

UPDATE `core_config_data`
SET `value` = 'https://example.com/js/'
WHERE `core_config_data`.`path` = 'web/secure/base_js_url';


------------------------------------------------------------------------------------------------------------------------------------ Cookies

-- May not be required for every shop

UPDATE `core_config_data`
SET `value` = '3600'
WHERE `core_config_data`.`path` = 'web/cookie/cookie_lifetime';

UPDATE `core_config_data`
SET `value` = '1'
WHERE `core_config_data`.`path` = 'web/cookie/cookie_httponly';

UPDATE `core_config_data`
SET `value` = '.example.com'
WHERE `core_config_data`.`path` = 'web/cookie/cookie_domain';

UPDATE `core_config_data`
SET `value` = '1'
WHERE `core_config_data`.`path` = 'web/browser_capabilities/cookies';

UPDATE `core_config_data`
SET `value` = '3600'
WHERE `core_config_data`.`path` = 'admin/security/session_cookie_lifetime';


-- ------------------------------------------------------------------------------------------------------------------------- Control changes

SELECT `path`,`value`
FROM `core_config_data`
WHERE `path`
IN (
    -- URLs
    'web/unsecure/base_url',
    'web/secure/base_url',
    'web/unsecure/base_link_url',
    'web/secure/base_link_url',
    'web/secure/base_skin_url',
    'web/secure/base_media_url',
    'web/secure/base_js_url',

    -- Cookies
    'web/cookie/cookie_lifetime',
    'web/cookie/cookie_httponly',
    'web/cookie/cookie_domain',
    'web/browser_capabilities/cookies',
    'admin/security/session_cookie_lifetime'
)
ORDER BY `value` ASC;
