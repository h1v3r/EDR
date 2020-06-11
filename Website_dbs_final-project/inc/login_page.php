<?php
$alert_username = false;
$alert_password = false;
$alert_kombination = false;
$username = "";
$password = "";

$user_logins = ["sarah" => "123456", "markus" => "phpisgreat", "dominik" => "supersafe4k"];
// echo "<h6>Registered usernames and passwords:</h6>";
// var_dump($user_logins);
?>
<a tabindex="0" class="btn btn-sm btn-secondary" id="dismissbtn" data-placement="left" role="button" data-toggle="popover" data-trigger="focus" title="Registered usernames and passwords:" data-content="[Username => Password] // sarah => 123456, markus => phpisgreat, dominik => supersafe4k">Registered Users</a>
<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    if (!empty(filter_input(INPUT_POST, "username"))) {
        $username = filter_input(INPUT_POST, "username", FILTER_SANITIZE_STRING);
    } else {
        $alert_username = true;
    }

    if (!empty(filter_input(INPUT_POST, "password"))) {
        $password = filter_input(INPUT_POST, "password", FILTER_SANITIZE_STRING);
    } else {
        $alert_password = true;
    }

    if (!empty($username) && !empty($password)) {
        if (!empty($user_logins[$username]) && $user_logins[$username] == $password) {
            echo "Should not be seen";
            $_SESSION["logged_Username"] = $username;
            header("Location: "); //Should have done everything with two different sites
            //Dirty solution
        } else {
            $alert_kombination = true;
        }
    }
}
?>


<div class=" container mt-3">
    <form action="" method="post">

        <?php
        if ($alert_kombination) {
        ?>

            <div class="alert alert-danger" role="alert">
                Kombination aus Username und Passwort ist falsch
            </div>

        <?php
        }
        ?>




        <?php
        if ($alert_username) {
        ?>

            <div class="alert alert-danger" role="alert">
                Username vergessen
            </div>

        <?php
        }
        ?>


        <div class="form-group">
            <label for="username_field">Username</label>
            <input type="text" class="form-control" id="username_field" name="username" value="<?php
                                                                                                if (!empty($username)) {
                                                                                                    echo $username;
                                                                                                }
                                                                                                ?>">
        </div>

        <?php
        if ($alert_password) {
        ?>

            <div class="alert alert-danger" role="alert">
                Password vergessen
            </div>

        <?php
        }
        ?>

        <div class="form-group">
            <label for="password_field">Password</label>
            <input type="password" class="form-control" id="password_field" name="password">
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
</div>