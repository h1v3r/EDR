<?php
$message = "";
if (!empty(filter_input(INPUT_POST, "addUser"))) {
    require_once("utility/db_handler.php");
    $vorname = filter_input(INPUT_POST, "inputVorname");
    $nachname = filter_input(INPUT_POST, "inputNachname");
    $geburtstag = filter_input(INPUT_POST, "inputGeburtstag");
    $plz = filter_input(INPUT_POST, "inputPlz");
    $ort = filter_input(INPUT_POST, "inputOrt");
    $strasse = filter_input(INPUT_POST, "inputStrasse");
    $hausnummer = filter_input(INPUT_POST, "inputHausnummer");

    $geburtstag = ""; //Format mit Geburtstag ist noch falsch - deswegen hier auf nichts gesetzt

    $message = $oracle_handler->add_User($vorname, $nachname, $geburtstag, 1, $plz, $ort, $strasse, $hausnummer);
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
            if (is_numeric($message)) {
                $message = "User added!";
            }
            echo '<div class="alert alert-info" role="alert"><h3>' . $message . '</h3></div>';
        }
        ?>

        <h1>Add User</h1>
        <form action="add_user.php" method="post">
            <div class="form-group row">
                <label for="inputVorname" class="col-sm-2 col-form-label">Vorname</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputVorname" name="inputVorname" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputNachname" class="col-sm-2 col-form-label">Nachname</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputNachname" name="inputNachname" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputGeburtstag" class="col-sm-2 col-form-label">Geburtstag [Format: 'YYYY-MM-DD']</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputGeburtstag" name="inputGeburtstag">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPlz" class="col-sm-2 col-form-label">Plz</label>
                <div class="col-sm-10">
                    <input type="number" class="form-control" id="inputPlz" name="inputPlz" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputOrt" class="col-sm-2 col-form-label">Ort</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputOrt" name="inputOrt" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputStrasse" class="col-sm-2 col-form-label">Straße</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputStrasse" name="inputStrasse" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputHausnummer" class="col-sm-2 col-form-label">Hausnummer</label>
                <div class="col-sm-10">
                    <input type="number" class="form-control" id="inputHausnummer" name="inputHausnummer" required>
                </div>
            </div>
            <button type="submit" class="btn btn-outline-primary" name="addUser" value="newUser">Add User</button>
        </form>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>