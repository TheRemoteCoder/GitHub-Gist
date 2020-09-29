<?php

/**
 * Database queries.
 */
class Database
{
  /**
   * DB host.
   */
  private $_host = '';

  /**
   * DB user password.
   */
  private $_pass = '';

  /**
   * DB name.
   */
  private $_db = '';

  /**
   * DB user.
   */
  private $_user = '';

  /**
   * Flag to mark if DB connection is ok.
   * Used to determine if methods can be executed.
   */
  private $_connectionOk = false;

  /**
   * Flag to mark if SQL query is ok.
   * Used to determine if methods can be executed.
   */
  private $_queryOk = false;

  /**
   * DB connection object.
   */
  private $_connection = null;

  /**
   * SQL query result object or error.
   */
  private $_query = null;

  /**
   * Constructor sets DB access.
   */
  public function __construct($host, $pass, $db, $user = '')
  {
    $this->_host = $host;
    $this->_pass = $pass;
    $this->_db   = $db;
    $this->_user = $user ? $user : $db;
  }

  /**
   * Try to connect to DB and store object.
   * Set 'ok'-flag on success or call 'auto-clean/close'.
   */
  public function connect()
  {
    $this->connection = new mysqli($this->_host, $this->_user, $this->_pass, $this->_db);

    if ($this->connection->connect_errno) {
      $this->close();

      throw Exception('Failed to connect: ' . $this->connection->connect_errno);
    } else {
      $this->_connectionOk = true;
      return $this;
    }
  }

  /**
   * Query DB and return result or error.
   * Set 'ok'-flag on success or call 'auto-clean/close'.
   */
  public function query($query = '')
  {
    if ($this->_connectionOk) {

      if ($this->_query = mysqli_query($this->connection, $query)) {
        $this->_queryOk = true;

        return $this;
      }
    }

    return $this->close();
  }

  /**
   * Global auto-clean/close method.
   * Try to close databse connection, free query results and reset properties.
   */
  public function close()
  {
    // Free query and reset properties
    if ($this->_query !== null) {

      if ($this->_query !== false) {
        mysqli_free_result($this->_query);
      }

      $this->_queryOk = false;
      $this->_query   = null;
    }

    // Close connection
    if ($this->connection !== null) {
      mysqli_close($this->connection);

      $this->_connectionOk = false;
      $this->connection    = null;
    }

    return $this;
  }

  /**
   * Write query result to associative array and close connection.
   * Call this function last.
   */
  public function toArray()
  {
    if ($this->_queryOk && !empty($this->_query)) {
      $result = [];

      while ($item = mysqli_fetch_array($this->_query, MYSQLI_ASSOC)) {
        $result[] = $item;
      }

      $this->close();
      return $result;
    }

    $this->close();
    return false;
  }
}
