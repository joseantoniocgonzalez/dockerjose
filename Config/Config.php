<?php
define('base_url', getenv('BASE_URL') ?: 'http://172.22.9.151:8081/');
define('host', getenv('DB_HOST') ?: 'mariadb');
define('user', getenv('DB_USER') ?: 'biblioteca_user');
define('pass', getenv('DB_PASS') ?: 'biblioteca_pass');
define('db', getenv('DB_NAME') ?: 'biblioteca_db');
define('charset', 'charset=utf8');
?>
