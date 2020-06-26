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
        <h1>Search Offers per Saison</h1>
        <form action="search_offers_of_season.php" method="post">
            <div class="form-group row">
                <label for="inputSaisonId" class="col-sm-2 col-form-label">Saison ID</label>
                <div class="col-sm-10">
                    <input type="number" class="form-control" id="inputSaisonId" name="inputSaisonId" required>
                </div>
            </div>
            <button type="submit" class="btn btn-outline-primary" name="searchSaison" value="searchSaison">Search</button>
        </form>


        <?php
        echo "<br><br>";
        if (!empty(filter_input(INPUT_POST, "searchSaison"))) {
            require_once("utility/db_handler.php");
            $saisonId = filter_input(INPUT_POST, "inputSaisonId");
            $oracle_handler->show_cursor_offers_of_season($saisonId);
        }
        ?>

    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>