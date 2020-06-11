<?php
// To access the data use the method 
// getJsonData() from the file db.php in db_handler
// this should kind of simulates the data you get from a database
require("db_handler/db.php");

// $studentArray = getJsonData();
$studentArray = json_decode(getJsonData());
// var_dump($studentArray);
// echo $studentArray[1]->Name;

// if (!empty(filter_input(INPUT_GET, "filtervalue"))) {
if (filter_has_var(INPUT_GET, "filtervalue")) {
    // echo "FilterValue:" . filter_input(INPUT_GET, "filtervalue");
    $filtervalue = filter_input(INPUT_GET, "filtervalue");
    foreach ($studentArray as $student) {
        // echo $student->Name;
        // echo strlen($student->Name) . "<br>";
        $length = strlen($filtervalue);
        if (substr($student->Name, 0, $length) == $filtervalue) {
            // echo $student->Name;
            echo "<li class='list-group-item'>$student->Name - Note: $student->Note</li>";
        }
    }
} else {
    echo "No filter";
}
