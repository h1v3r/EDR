<?php
$message = "";
if (!empty(filter_input(INPUT_POST, "addMessage"))) {
    require_once("utility/db_handler.php");
    $idSender = filter_input(INPUT_POST, "inputidSender");
    $idEmpf = filter_input(INPUT_POST, "inputidEmpf");
    $inhalt = filter_input(INPUT_POST, "inputInhalt");

    $message = $oracle_handler->add_message($idSender, $idEmpf, $inhalt);
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
    <title></title>
</head>

<body>

    <?php
    include("inc/default_inc.php");
    ?>
    <div class="container">

        <?php
        if (!empty($message)) {
            if ($message == "error") {
                echo '<div class="alert alert-danger" role="alert"><h3>Something went wrong - No message sent</h3></div>';
            } else {
                echo '<div class="alert alert-info" role="alert"><h3>' . $message . '</h3></div>';
            }
        }
        ?>

        <h1>Send Message</h1>
        <form action="send_message.php" method="post">
            <div class="form-group row">
                <label for="inputidSender" class="col-sm-2 col-form-label">ID Sender</label>
                <div class="col-sm-10">
                    <input type="number" class="form-control" id="inputidSender" name="inputidSender" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputidEmpf" class="col-sm-2 col-form-label">ID Empfänger</label>
                <div class="col-sm-10">
                    <input type="number" class="form-control" id="inputidEmpf" name="inputidEmpf" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputInhalt" class="col-sm-2 col-form-label">Inhalt</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputInhalt" name="inputInhalt" required>
                </div>
            </div>
            <button type="submit" class="btn btn-outline-primary" name="addMessage" value="newMessage">Send Message</button>
        </form>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>