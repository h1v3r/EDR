<?php

if (!empty(filter_input(INPUT_GET, "searchText"))) {
    $searchText = filter_input(INPUT_GET, "searchText");

    require_once("../../utility/db_handler.php");
    echo $oracle_handler->show_cursor_filter_offers($searchText);
}
