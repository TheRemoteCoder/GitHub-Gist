<?php

require_once 'Database.php';

// Change this
$storeId = 1;
$db      = '';
$host    = 'localhost';
$user    = '';
$pass    = '';

$exportAsFile = true; // Plain text | File
$fileName     = 'newsletter-subscribers.csv';


$emailData = null;

try {
	$DB        = new Database( $host, $pass, $db, $user );
	$emailData = $DB
	->connect()
	->query(
		'
      SELECT
        store_id,
        subscriber_id,
        subscriber_email
      FROM
        `newsletter_subscriber`
      WHERE
        store_id=' . $storeId . ' AND
        subscriber_status=1
    '
	)
	->toArray();
} catch ( Exception $e ) {
	die( $e->getMessage() );
}

if ( ! $emailData ) {
	die( 'No email data exported.' );
}


$content = "store_id\tsubscriber_id\tsubscriber_email\n";

foreach ( $emailData as $email ) {
	$content .=
	$email['store_id'] . "\t" .
	$email['subscriber_id'] . "\t" .
	$email['subscriber_email'] . "\n";
}

switch ( $exportAsFile ) {
	case true: {
		header( 'Content-type:application/octet-stream' );
		header( 'Content-Disposition:attachment; filename="' . $fileName . '"' );

		echo $content;
		break;
	}
	default: {
		header( 'Content-Type:text/plain, charset=utf-8' );

		echo $content;
		break;
	}
}
