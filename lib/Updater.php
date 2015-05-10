<?php
/**
 * Created by PhpStorm.
 * User: Artem
 * Date: 14.04.2015
 * Time: 12:37
 */

namespace lib;


class Updater {

    const EXIT_NO_ERROR = 0;
    const EXIT_NOT_LOADED_MODULES = 1;
    const EXIT_ARCHIVE_ERROR = 2;

    public $modules;
    public $config;

    public $version_local;
    public $version_remote;

    public $release;

    public $zipball;

    private $_client;

    public function __construct($config){
        $this->config = $config;
        $this->modules = $this->requirements();
    }

    /**
     *
     * @param string $tag which branch/tag/release takes for update
     * @return int exit code
     */
    public function run(){
        if(in_array(false, $this->modules))
            return self::EXIT_NOT_LOADED_MODULES;

        $this->checkVersionLocal();
        $this->checkVersionRemote();

        echo "Local version: ".$this->version_local."\n";
        echo "Remote version: ".$this->version_remote."\n";

        if(version_compare($this->version_remote, $this->version_local)>1) {
            echo "...\n";
            $res = $this->update();
            echo $res==self::EXIT_NO_ERROR?"Done!\n":"";
            return $res;
        } else {
            echo 'Ok. Bye!';
            return self::EXIT_NO_ERROR;
        }
    }

    /**
     * Downloads and update files in working dir
     * @param int $tries
     * @return int
     */
    public function update(& $tries = 0){

        if($tries > 2)
            return self::EXIT_ARCHIVE_ERROR;

        $this->download();

        $zip = new \ZipArchive;
        $res = $zip->open($this->zipball);
        if ($res === TRUE) {
            $zip->extractTo($this->config['local']['tmpDir'].'/remote');
            $zip->close();
        } else {
            echo "Error extracting archive. One more try...";
            $this->update(++$tries);
        }

        // copy files
        $r = glob('tmp/remote/anharchenko-terminal*');
        if(count($r)>0)
            $source = $r[0];
        else {
            return self::EXIT_ARCHIVE_ERROR;
        }

        self::copyr($source, $this->config['local']['dest']);

        /*
         * TODO: cleanup tmp dir
         */

        return self::EXIT_NO_ERROR;
    }

    /**
     * Download zipball from github
     * TODO: exceptions
     */
    public function download(){
        $this->authorization();

        $result = $this->_client->api('repos')->archiveLink($this->config['remote']['owner'], $this->config['remote']['repo'], 'zipball', $this->version_remote);

        if(!file_exists($this->config['local']['tmpDir']))
            mkdir($this->config['local']['tmpDir'], 0777, true);

        $this->zipball = $this->config['local']['tmpDir'].'latest.zip';
        $fp = fopen($this->zipball, 'w');
        fwrite($fp, $result);
        fclose($fp);
    }

    /**
     * Checks local version of app
     * @return string
     */
    public function checkVersionLocal(){
        if(empty($this->version_local))
            if(file_exists(ROOT.DS.$this->config['local']['version']))
                return $this->version_local = file_get_contents(ROOT.DS.$this->config['local']['version']);
            else
                return 'None.';
        else
            return $this->version_local;
    }

    /**
     * Checks remote version
     * @return string version
     */
    public function checkVersionRemote(){
        if(empty($this->version_remote)) {
            $this->authorization();
            $this->release = $this->_client->api('repos')->releases()->show($this->config['remote']['owner'], $this->config['remote']['repo'], $this->config['remote']['ref']);
            return $this->version_remote = $this->release['tag_name'];
        } else
            return $this->version_remote;
    }

    /**
     *  Authorizes on github
     */
    public function authorization(){
        $this->_client = new \Github\Client();
        return $this->_client->authenticate($this->config['remote']['token'], null, \Github\Client::AUTH_HTTP_TOKEN);
    }

    /**
     * Checking need PHP modules
     * @return array
     */
    private function requirements(){
        return [
            'zip'=>extension_loaded('zip'),
            'curl'=>extension_loaded('curl'),
            'mongo'=>extension_loaded('mongo'),
        ];
    }

    /**
     * Gets input from STDIN and returns a string right-trimmed for EOLs.
     *
     * @param boolean $raw If set to true, returns the raw string without trimming
     * @return string the string read from stdin
     */
    public static function stdin($raw = false) {
        return $raw ? fgets(\STDIN) : rtrim(fgets(\STDIN), PHP_EOL);
    }

    /**
     * Prints a string to STDOUT.
     *
     * @param string $string the string to print
     * @return int|boolean Number of bytes printed or false on error
     */
    public static function stdout($string)
    {
        return fwrite(\STDOUT, $string);
    }

    /**
     * Asks user to confirm by typing y or n.
     *
     * @param string $message to print out before waiting for user input
     * @param boolean $default this value is returned if no selection is made.
     * @return boolean whether user confirmed
     */
    public static function confirm($message, $default = true)
    {
        while (true) {
            static::stdout($message . ' (y|n) [' . ($default ? 'y' : 'n') . ']:');
            $input = trim(static::stdin());

            if (empty($input)) {
                return $default;
            }

            if (!strcasecmp ($input, 'y') ) {
                return true;
            }

            if (!strcasecmp ($input, 'n') ) {
                return false;
            }
        }
    }

    /**
     * Copy a file, or recursively copy a folder and its contents
     *
     * @author      Aidan Lister <aidan@php.net>
     * @version     1.0.1
     * @link        http://aidanlister.com/2004/04/recursively-copying-directories-in-php/
     * @param       string   $source    Source path
     * @param       string   $dest      Destination path
     * @return      bool     Returns TRUE on success, FALSE on failure
     */
    public static function copyr($source, $dest)
    {
        // Check for symlinks
        if (is_link($source)) {
            return symlink(readlink($source), $dest);
        }

        // Simple copy for a file
        if (is_file($source)) {
            return copy($source, $dest);
        }

        // Make destination directory
        if (!is_dir($dest)) {
            mkdir($dest);
        }

        // Loop through the folder
        $dir = dir($source);
        while (false !== $entry = $dir->read()) {
            // Skip pointers
            if ($entry == '.' || $entry == '..') {
                continue;
            }

            // Deep copy directories
            self::copyr("$source/$entry", "$dest/$entry");
        }

        // Clean up
        $dir->close();
        return true;
    }

}