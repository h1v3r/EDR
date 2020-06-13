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
    // include("inc/check_logged_in.php");
    // include("inc/nav.php");
    // include("inc/logout.php");
    include("inc/default_inc.php");
    ?>
    <div class="container">
        <h1>Hello <?= $_SESSION["logged_Username"]; ?>!</h1>

        <p>User account page is out of scope for this project</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus condimentum gravida ipsum sit amet vulputate. Nunc ut elit quis urna dictum ullamcorper. In non egestas turpis. Ut vitae sem non lacus auctor malesuada. Praesent malesuada urna id porta tincidunt. Duis consectetur mi sit amet massa mollis, non fringilla felis semper. Nunc tempus viverra dui, in commodo augue auctor ut. Vivamus sed justo bibendum, vehicula ipsum ac, hendrerit est. Duis eget sem in mi ullamcorper laoreet. Suspendisse et mauris rutrum, suscipit elit ut, venenatis justo. </p>
        <p>In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Cras vel dapibus risus, vel tincidunt nunc. Donec feugiat ullamcorper arcu, at scelerisque ante. Nam sit amet sollicitudin ante. Donec convallis tortor ex, eget porta nisl euismod eget. In hac habitasse platea dictumst. </p>

    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>

</html>