<?php

if (!empty(filter_input(INPUT_GET, "userid"))) {
    $userid = filter_input(INPUT_GET, "userid");

    require_once("../../utility/db_handler.php");
    echo $oracle_handler->show_cursor_messages_from_user($userid);
}
