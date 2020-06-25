<?php
$link = $_SERVER['PHP_SELF'];
$link_array = explode('/', $link);
$pageName = end($link_array);
?>

<nav>
    <div class="container mt-2">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "account_page.php") {
                                        echo "active";
                                    } ?>" href="account_page.php">Account Page</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "select_user.php") {
                                        echo "active";
                                    } ?>" href="select_user.php">Select User</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "all_view.php") {
                                        echo "active";
                                    } ?>" href="all_view.php">All Views</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "transaction_for_user.php") {
                                        echo "active";
                                    } ?>" href="transaction_for_user.php">Transaction for user</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "messages_for_user.php") {
                                        echo "active";
                                    } ?>" href="messages_for_user.php">Messages for user</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "add_user.php") {
                                        echo "active";
                                    } ?>" href="add_user.php">Add User</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "send_message.php") {
                                        echo "active";
                                    } ?>" href="send_message.php">Send Message</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <?php if ($pageName == "change_user_role.php") {
                                        echo "active";
                                    } ?>" href="change_user_role.php">Change User Role</a>
            </li>
        </ul>
    </div>
</nav>