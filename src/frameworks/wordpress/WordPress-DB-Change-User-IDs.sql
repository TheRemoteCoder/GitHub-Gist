-- Change user IDs for security.
--
-- Also change manually:
-- * AUTO_INCREMENT value of 'users' table, e.g. > 10000
-- * Fields in 'users' and 'usermeta' that disclose the login name

-- example.com
UPDATE wp_1234_users SET ID = 12345 WHERE ID = 1;
UPDATE wp_1234_usermeta SET user_id = 12345 WHERE user_id = 1;
UPDATE wp_1234_posts SET post_author = 12345 WHERE post_author = 1;
UPDATE wp_1234_links SET link_owner = 12345 WHERE link_owner = 1;
