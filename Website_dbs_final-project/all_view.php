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
        <button type="submit" class="btn btn-outline-info mb-3" id="view-transPerSaison">Transaction per Saison</button>
        <button type="submit" class="btn btn-outline-info mb-3" id="view-BioFactorPerUser">Average Bio Faktor per User</button>
        <button type="submit" class="btn btn-outline-info mb-3" id="view-UserDetails">User Details</button>
        <button type="submit" class="btn btn-outline-info mb-3" id="view-UserProdukte">User Produkte</button>

        <script>
            $(function() {
                // Add Events to each button that call the select php file which calls the db function
                document.querySelector("#view-transPerSaison").addEventListener("click", () => {
                    $.get("inc/ajax_views/transPerSaison.php", (data) => {
                        document.querySelector("#outputView").innerHTML = data;
                    });
                });
                document.querySelector("#view-BioFactorPerUser").addEventListener("click", () => {
                    $.get("inc/ajax_views/avgBioFactor.php", (data) => {
                        document.querySelector("#outputView").innerHTML = data;
                    });
                });
                document.querySelector("#view-UserDetails").addEventListener("click", () => {
                    $.get("inc/ajax_views/userDetails.php", (data) => {
                        document.querySelector("#outputView").innerHTML = data;
                    });
                });
                document.querySelector("#view-UserProdukte").addEventListener("click", () => {
                    $.get("inc/ajax_views/userProducts.php", (data) => {
                        document.querySelector("#outputView").innerHTML = data;
                    });
                });
            })
        </script>

        <div id="outputView"></div>


    </div>




    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>