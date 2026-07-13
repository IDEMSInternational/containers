<?php
unset($CFG);  // Ignore this line
global $CFG;  // This is necessary here for PHPUnit execution
$CFG = new stdClass();

// Only 'dbtype' currently supported is 'pgsql'
$CFG->dbtype    = 'pgsql';
$CFG->dblibrary = 'native';
$CFG->dbhost    = $_ENV['MOODLE_DB_HOST'];
$CFG->dbname    = $_ENV['MOODLE_DB_NAME'];
$CFG->dbuser    = $_ENV['MOODLE_DB_USER'];
$CFG->dbpass    = $_ENV['MOODLE_DB_PASS'];
// prefix to use for all table names
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array(
    'dbpersist' => false,
    'dbsocket'  => false,
    'dbport'    => filter_var($_ENV['MOODLE_DB_PORT'], FILTER_VALIDATE_INT, ['default' => 5432]),
    'dbhandlesoptions' => false,
);
// For all database config settings see https://docs.moodle.org/en/Database_settings

// Full web address e.g. 'https://moodle.example.com'. Do not include a trailing slash.
$CFG->wwwroot   = $_ENV['MOODLE_WWW_ROOT'];
$CFG->dataroot  = '/var/www/moodledata';
$CFG->routerconfigured = false;
$CFG->directorypermissions = 02777;
$CFG->reverseproxy = filter_var($_ENV['MOODLE_REVERSE_PROXY'], FILTER_VALIDATE_BOOL, false);
$CFG->sslproxy = filter_var($_ENV['MOODLE_SSL_PROXY'], FILTER_VALIDATE_BOOL, false);

if ($_ENV['MOODLE_SESSION_HANDLER'] == 'redis') {
    $CFG->session_handler_class = '\core\session\redis';
    $CFG->session_redis_host = $_ENV['MOODLE_REDIS_HOST'];
    $CFG->session_redis_port = filter_var($_ENV['MOODLE_REDIS_PORT'], FILTER_VALIDATE_INT, ['default' => 6379]);
    $CFG->session_redis_database = filter_var($_ENV['MOODLE_REDIS_DB'], FILTER_VALIDATE_INT, ['default' => 1]);
}

require_once(__DIR__ . '/lib/setup.php'); // Do not edit

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
