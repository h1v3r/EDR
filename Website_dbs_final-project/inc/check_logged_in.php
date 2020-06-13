<?php
session_start();
if (empty($_SESSION["logged_Username"])) {
    echo "<h3>You are not logged in and are not allowed to see anything</h3>"; //Should not be seen
    header("Location: login_page.php");
}
