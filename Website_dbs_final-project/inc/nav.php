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
                <a class="nav-link <?php if ($pageName == "procedure_test.php") {
                                        echo "active";
                                    } ?>" href="procedure_test.php">Procedure Test</a>
            </li>
        </ul>
    </div>
</nav>