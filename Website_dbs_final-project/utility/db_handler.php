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
            return "error";
            // $e = oci_error($stid);
            // trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
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

    function show_view_transPerSaison()
    {
        $stid = $this->parseSql("SELECT * FROM transaktion_per_saison");
        $stid = $this->executeParsedSql($stid);
        $this->plotToTable($stid);
    }

    function show_view_userBioAverage()
    {
        $stid = $this->parseSql("SELECT * FROM Bio_Faktor_User_Durchschnitt");
        $stid = $this->executeParsedSql($stid);
        $this->plotToTable($stid);
    }

    function show_view_userDetail()
    {
        $stid = $this->parseSql("SELECT * FROM User_Details");
        $stid = $this->executeParsedSql($stid);
        $this->plotToTable($stid);
    }

    function show_view_userProdukte()
    {
        $stid = $this->parseSql("SELECT * FROM view_user_produkte");
        $stid = $this->executeParsedSql($stid);
        $this->plotToTable($stid);
    }

    function errorHappened($errorOut)
    {
        if (!empty($errorOut)) {
            echo '<div class="alert alert-danger" role="alert"><h3>Error happened :(<h3><h6>Oracle (php) Error message: ' . $errorOut . '</h6></div>';
            return true;
        }

        return false;
    }

    function plotToTableCursor($curs)
    {
        echo "<table class='table table-hover'>";
        oci_execute($curs);
        $header = false;
        while (($row = oci_fetch_array($curs, OCI_ASSOC + OCI_RETURN_NULLS))) {

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
        oci_free_statement($curs);
        echo "</table>";
    }


    function show_cursor_transaction_from_user($userid)
    {
        $errorOut = "";
        $curs = oci_new_cursor($this->conn);
        $stid = $this->parseSql("begin :cursor := f_transaktion_userx(:p1, :p2); end;");
        oci_bind_by_name($stid, ":p1", $userid);
        oci_bind_by_name($stid, ":p2", $errorOut, 300);
        oci_bind_by_name($stid, ":cursor", $curs, -1, OCI_B_CURSOR);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            $this->plotToTableCursor($curs);
        }
    }

    function show_cursor_messages_from_user($userid)
    {
        $errorOut = "";
        $curs = oci_new_cursor($this->conn);
        $stid = $this->parseSql("begin :cursor := f_Nachrichten_UserX(:p1, :p2); end;");
        oci_bind_by_name($stid, ":p1", $userid);
        oci_bind_by_name($stid, ":p2", $errorOut, 300);
        oci_bind_by_name($stid, ":cursor", $curs, -1, OCI_B_CURSOR);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            $this->plotToTableCursor($curs);
        }
    }

    function show_cursor_filter_offers($filterstring)
    {
        $errorOut = "";
        $curs = oci_new_cursor($this->conn);
        $stid = $this->parseSql("begin :cursor := f_filter_ang_prodname_cur(:p1); end;");
        oci_bind_by_name($stid, ":p1", $filterstring, 100);
        oci_bind_by_name($stid, ":cursor", $curs, -1, OCI_B_CURSOR);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            $this->plotToTableCursor($curs);
        }
    }

    function insert_ort($plz, $ortname)
    {
        $stid = $this->parseSql("begin sp_add_ort(:p1, :p2, :p3, :p4); end;");
        oci_bind_by_name($stid, ":p1", $plz);
        oci_bind_by_name($stid, ":p2", $ortname);
        oci_bind_by_name($stid, ":p3", $pkOut, 20);
        oci_bind_by_name($stid, ":p4", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return $pkOut;
        } else {
            return "error";
        }
    }

    function insert_adress($plz, $strasse, $hausnummer)
    {
        $stid = $this->parseSql("begin sp_add_adresse(:p1, :p2, :p3, :p4, :p5); end;");
        oci_bind_by_name($stid, ":p1", $plz);
        oci_bind_by_name($stid, ":p2", $strasse);
        oci_bind_by_name($stid, ":p3", $hausnummer);
        oci_bind_by_name($stid, ":p4", $pkOut, 20);
        oci_bind_by_name($stid, ":p5", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return $pkOut;
        } else {
            return "error";
        }
    }

    function insert_rolle($titel, $beschreibung)
    {
        $stid = $this->parseSql("begin sp_add_rolle(:p1, :p2, :p3, :p4); end;");
        oci_bind_by_name($stid, ":p1", $titel);
        oci_bind_by_name($stid, ":p2", $beschreibung);
        oci_bind_by_name($stid, ":p3", $pkOut, 20);
        oci_bind_by_name($stid, ":p4", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return $pkOut;
        } else {
            return "error";
        }
    }

    function insert_user($rollePK, $vorname, $nachname, $dob, $addressePK)
    {
        $stid = $this->parseSql("begin sp_add_user(:p1, :p2, :p3, :p4, :p5, :p6, :p7); end;");
        oci_bind_by_name($stid, ":p1", $rollePK);
        oci_bind_by_name($stid, ":p2", $vorname);
        oci_bind_by_name($stid, ":p3", $nachname);
        oci_bind_by_name($stid, ":p4", $dob, 20);
        oci_bind_by_name($stid, ":p5", $addressePK);
        oci_bind_by_name($stid, ":p6", $pkOut, 20);
        oci_bind_by_name($stid, ":p7", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return $pkOut;
        } else {
            return "error";
        }
    }

    function add_User($vorname, $nachname, $dob, $rollePK, $plz, $ortname, $strasse, $hausnummer)
    {
        $pkOrt = $this->insert_ort($plz, $ortname);
        $pkAdresse = $this->insert_adress($pkOrt, $strasse, $hausnummer);
        $pkUser = $this->insert_user($rollePK, $vorname, $nachname, $dob, $pkAdresse);
        return $pkUser;
    }

    function add_message($useridSender, $useridEmpf, $inhalt)
    {
        $stid = $this->parseSql("begin sp_sendMessage(:p1, :p2, :p3, :p4); end;");
        oci_bind_by_name($stid, ":p1", $useridSender);
        oci_bind_by_name($stid, ":p2", $useridEmpf);
        oci_bind_by_name($stid, ":p3", $inhalt);
        oci_bind_by_name($stid, ":p4", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "Message sent!";
        } else {
            return "error";
        }
    }

    function change_user_role($userid, $newRoleId)
    {
        $stid = $this->parseSql("begin sp_updateUserRolle(:p1, :p2, :p3); end;");
        oci_bind_by_name($stid, ":p1", $userid);
        oci_bind_by_name($stid, ":p2", $newRoleId);
        oci_bind_by_name($stid, ":p3", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "Rolle updated!";
        } else {
            return "error";
        }
    }
    // (l_n_angebotid_in IN NUMBER, l_n_useridKaeufer_in IN NUMBER, l_v_bewertungVerkaeuferT_in IN VARCHAR, l_n_bewertungVerkaeuferV_in IN NUMBER, l_v_bewertungKaeuferT_in IN VARCHAR, l_n_bewertungKaeuferV_in IN NUMBER, l_v_error_ou OUT VARCHAR) AS
    function add_transaction($angebotid, $useridKaeufer, $bewertungVerkaeuferT, $bewertungVerkaeuferV, $bewertungKaeuferT, $bewertungKaeuferV)
    {
        $stid = $this->parseSql("begin sp_addTransaction(:p1, :p2, :p3, :p4, :p5, :p6, :p7); end;");
        oci_bind_by_name($stid, ":p1", $angebotid);
        oci_bind_by_name($stid, ":p2", $useridKaeufer);
        oci_bind_by_name($stid, ":p3", $bewertungVerkaeuferT);
        oci_bind_by_name($stid, ":p4", $bewertungVerkaeuferV);
        oci_bind_by_name($stid, ":p5", $bewertungKaeuferT);
        oci_bind_by_name($stid, ":p6", $bewertungKaeuferV);
        oci_bind_by_name($stid, ":p7", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "Transaction added!";
        } else {
            return "error";
        }
    }

    function delete_user($userid)
    {
        $stid = $this->parseSql("begin sp_delete_user(:p1, :p2); end;");
        oci_bind_by_name($stid, ":p1", $userid);
        oci_bind_by_name($stid, ":p2", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "User deleted!";
        } else {
            return "error";
        }
    }

    function add_product($saisonId, $bioId, $name)
    {
        $stid = $this->parseSql("begin sp_addProduct(:p1, :p2, :p3, :p4); end;");
        oci_bind_by_name($stid, ":p1", $saisonId);
        oci_bind_by_name($stid, ":p2", $bioId);
        oci_bind_by_name($stid, ":p3", $name);
        oci_bind_by_name($stid, ":p4", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "Product added!";
        } else {
            return "error";
        }
    }

    function show_cursor_offers_of_season($saisonId)
    {
        $errorOut = "";
        $curs = oci_new_cursor($this->conn);
        $stid = $this->parseSql("begin :cursor := f_angebote_saison(:p1, :p2); end;");
        oci_bind_by_name($stid, ":p1", $saisonId);
        oci_bind_by_name($stid, ":p2", $errorOut, 300);
        oci_bind_by_name($stid, ":cursor", $curs, -1, OCI_B_CURSOR);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            $this->plotToTableCursor($curs);
        }
    }

    function add_offer($userIdVerkaeuf, $kategorieId, $anzeigetext)
    {
        $stid = $this->parseSql("begin sp_addOffer(:p1, :p2, :p3, :p4); end;");
        oci_bind_by_name($stid, ":p1", $userIdVerkaeuf);
        oci_bind_by_name($stid, ":p2", $kategorieId);
        oci_bind_by_name($stid, ":p3", $anzeigetext);
        oci_bind_by_name($stid, ":p4", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "Offer added!";
        } else {
            return "error";
        }
    }

    function add_product_to_offer($angebotId, $productId, $menge)
    {
        $stid = $this->parseSql("begin sp_addProductOffer(:p1, :p2, :p3, :p4); end;");
        oci_bind_by_name($stid, ":p1", $angebotId);
        oci_bind_by_name($stid, ":p2", $productId);
        oci_bind_by_name($stid, ":p3", $menge);
        oci_bind_by_name($stid, ":p4", $errorOut, 300);
        $stid = $this->executeParsedSql($stid);

        if (!$this->errorHappened($errorOut)) {
            return "Added Product to the offer!";
        } else {
            return "error";
        }
    }
}


$oracle_handler = new oracle_db_handler();
$oracle_handler->connectToDb();
// echo "<h1>connected</h1>";

// $oracle_handler->testSql();
// $oracle_handler->testInsert(68);
