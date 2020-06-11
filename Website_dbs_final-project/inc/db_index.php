<?php
if (filter_has_var(INPUT_POST, "clear_session")) {
    // echo "Clear Session";
    unset($_SESSION["logged_Username"]);
    header("Location: "); //Again. Not good that way
}
?>
<form method="post">
    <input type="submit" class="btn btn-danger" name="clear_session" value="Log out" />
</form>

Nothing here yet