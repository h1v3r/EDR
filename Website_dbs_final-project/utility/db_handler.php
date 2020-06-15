<?php

// define($username, "s20bwi4_wi18b025");
// define($password, "dbss20");
// define($connectionString, "jdbc:oracle:thin:@infdb.technikum-wien.at:1521:o10");

class oracle_db_handler
{
    private $conn = null;

    function connectToDb()
    {
        $this->conn = oci_connect("s20bwi4_wi18b025", "dbss20", "jdbc:oracle:thin:@infdb.technikum-wien.at:1521:o10");

        if (!$this->conn) {
            $e = oci_error();
            trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }
    }

    private function executeSql($sql)
    {
        $stid = oci_parse($this->conn, $sql);
        oci_execute($stid);
        return $stid;
    }

    private function plotToTable($stid)
    {
        echo "<table class='table table-hover table-dark'>";
        while ($row = oci_fetch_array($stid, OCI_ASSOC + OCI_RETURN_NULLS)) {
            echo "<tr>";
            foreach ($row as $item) {
                echo "<td>" . ($item != null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    }

    function testSql()
    {
        $stid = $this->executeSql('SELECT * FROM "user"');
        $this->plotToTable($stid);
    }
}

$oracle_handler = new oracle_db_handler();
$oracle_handler->connectToDb();
echo "<h1>connected</h1>";
$oracle_handler->testSql();
