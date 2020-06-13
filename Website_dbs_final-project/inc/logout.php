<?php
if (filter_has_var(INPUT_POST, "clear_session")) {
    // echo "Clear Session";
    unset($_SESSION["logged_Username"]);
    header("Location: login_page.php");
}
?>
<div class="container mt-3 mb-3 d-flex justify-content-end">
    <form method="post">
        <input type="submit" class="btn btn-danger" name="clear_session" value="Log out" />
    </form>
</div>