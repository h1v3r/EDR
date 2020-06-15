<?php

// define("USERNAME", "s20bwi4_wi18b025");
// define("PASSWORD", "dbss20");
// define("CONNECTIONSTRING", "jdbc:oracle:thin:@infdb.technikum-wien.at:1521:o10");

/* 
CREATE USER testpaul IDENTIFIED BY "test";
--GRANT CREATE SESSION TO testpaul;
GRANT ALL PRIVILEGES TO testpaul;

CREATE TABLE test (testdata NUMBER);
INSERT INTO test VALUES(3);
INSERT INTO test VALUES(1);
INSERT INTO test VALUES(23);
INSERT INTO test VALUES(6);

SELECT * FROM test; 
*/

define("USERNAME", "testpaul");
define("PASSWORD", "test");
define("CONNECTIONSTRING", "localhost:11521");

class oracle_db_handler
{
    private $conn = null;

    function connectToDb()
    {
        $this->conn = oci_connect(USERNAME, PASSWORD, CONNECTIONSTRING);

        if (!$this->conn) {
            $e = oci_error();
            trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }
    }

    private function executeSql($sql)
    {
        $stid = oci_parse($this->conn, $sql);
        if (!$stid) {
            $e = oci_error($this->conn);
            trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }
        $r = oci_execute($stid);
        if (!$r) {
            $e = oci_error($stid);
            trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }
        return $stid;
    }

    private function plotToTableWithoutHead($stid)
    {
        // echo "<div class='container'>";
        echo "<table class='table table-hover table-dark'>";
        while ($row = oci_fetch_array($stid, OCI_ASSOC + OCI_RETURN_NULLS)) {
            echo "<tr>";
            foreach ($row as $item) {
                echo "<td>" . ($item != null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
        // echo "</div>";
    }
    private function plotToTable($stid)
    {
        $header = false; // a way to track if we've output the header.

        echo "<table class='table table-hover'>";

        while ($row = oci_fetch_array($stid, OCI_ASSOC + OCI_RETURN_NULLS)) {

            if ($header == false) {
                // this is the first iteration of the while loop so output the header.
                print '<thead class="thead-dark"><tr>';
                foreach (array_keys($row) as $key) {
                    print '<th>' . ($key !== null ? htmlentities($key, ENT_QUOTES) :
                        '') . '</th>';
                }
                print '</tr></thead>';

                $header = true; // make sure we don't output the header again.
            }

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
        $stid = $this->executeSql('SELECT * FROM test');
        $this->plotToTable($stid);
    }

    function testInsert($value)
    {
        $stid = $this->executeSql('INSERT INTO test VALUES(' . $value . ')');
    }

    function selectUserTable()
    {
        $stid = $this->executeSql('SELECT * FROM "User"');
        $this->plotToTable($stid);
    }
}


$oracle_handler = new oracle_db_handler();
$oracle_handler->connectToDb();
// echo "<h1>connected</h1>";

// $oracle_handler->testSql();
// $oracle_handler->testInsert(68);