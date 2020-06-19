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


/*
CREATE OR REPLACE PROCEDURE myproc(p1 IN NUMBER, p2 OUT NUMBER) AS
BEGIN
    p2 := p1 * 2;
END;
*/

/*
  CREATE OR REPLACE FUNCTION myfunc(p1 IN NUMBER) RETURN SYS_REFCURSOR AS
      rc SYS_REFCURSOR;
  BEGIN
      OPEN rc FOR SELECT testdata FROM test WHERE ROWNUM < p1;
      RETURN rc;
  END;
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

    private function parseSql($sql)
    {
        $stid = oci_parse($this->conn, $sql);
        if (!$stid) {
            $e = oci_error($this->conn);
            trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
        }
        return $stid;
    }

    private function executeParsedSql($stid)
    {
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
                echo '<thead class="thead-dark"><tr>';
                foreach (array_keys($row) as $key) {
                    echo '<th>' . ($key !== null ? htmlentities($key, ENT_QUOTES) :
                        '') . '</th>';
                }
                echo '</tr></thead>';

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
        $stid = $this->parseSql('SELECT * FROM test');
        $stid = $this->executeParsedSql($stid);
        $this->plotToTable($stid);
    }

    function testInsert($value)
    {
        $stid = $this->executeParsedSql($this->parseSql('INSERT INTO test VALUES(' . $value . ')'));
    }

    function selectUserTable()
    {
        $stid = $this->executeParsedSql($this->parseSql('SELECT * FROM "User"'));
        $this->plotToTable($stid);
    }

    function testProcedure()
    {
        $p1 = 6;
        $stid = $this->parseSql("begin myproc(:p1, :p2); end;");
        oci_bind_by_name($stid, ":p1", $p1);
        oci_bind_by_name($stid, ":p2", $p2, 420);
        $stid = $this->executeParsedSql($stid);
        echo "p1: $p1 / p2: $p2\n";
    }

    function testCursorFunction()
    {
        $stid = $this->parseSql("SElECT myfunc(20) AS mfrc FROM dual");
        $stid = $this->executeParsedSql($stid);
        echo "<table class='table table-hover'>";
        while (($row = oci_fetch_array($stid, OCI_ASSOC))) {
            echo "<tr>";
            $rc = $row['MFRC'];
            oci_execute($rc);  // returned column value from the query is a ref cursor
            while (($rc_row = oci_fetch_array($rc, OCI_ASSOC))) {
                echo "    <td>" . $rc_row['TESTDATA'] . "</td>";
            }
            oci_free_statement($rc);
            echo "</tr>";
        }
        echo "</table>";
    }
}


$oracle_handler = new oracle_db_handler();
$oracle_handler->connectToDb();
// echo "<h1>connected</h1>";

// $oracle_handler->testSql();
// $oracle_handler->testInsert(68);