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
            session_start();
            $_SESSION["logged_Username"] = $username;
            header("Location: account_page.php");
        } else {
            $alert_kombination = true;
        }
    }
}
?>


<!DOCTYPE html>

<html>

<head>
    <meta charset="UTF-8">
    <!-- Jquery JS -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="js/popover.js"></script>
    <title></title>
</head>

<body>


    <div class=" container mt-3">
        <a tabindex="0" class="btn btn-sm btn-secondary mb-2" id="dismissbtn" data-placement="left" role="button" data-toggle="popover" data-trigger="focus" title="Registered usernames and passwords:" data-content="[Username => Password] // sarah => 123456, markus => phpisgreat, dominik => supersafe4k">Registered Users</a>
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




    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>