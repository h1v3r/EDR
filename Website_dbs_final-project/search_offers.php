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
        <h1>Search all the Offers after a text in their name</h1>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">Searchtext</span>
            </div>
            <input type="text" aria-label="input text" class="form-control" id="inputText">
        </div>

        <div id="output"></div>

    </div>
    <script>
        $(function() {
            document.querySelector("#inputText").addEventListener("keyup", (e) => {
                $.get("inc/ajax_functions/searchOffers.php", {
                    searchText: e.target.value
                }, (data) => {
                    console.log(data);
                    if (data == "<table class='table table-hover'></table>") { //Empty table
                        data = "No data found for that Searchtext";
                    }

                    document.querySelector("#output").innerHTML = data;
                });
            });
        })
    </script>



    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>