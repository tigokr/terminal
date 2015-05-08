@echo off

rem -------------------------------------------------------------
rem  Yii command line bootstrap script for Windows.
rem
rem  @author Qiang Xue <qiang.xue@gmail.com>
rem  @link http://www.yiiframework.com/
rem  @copyright Copyright (c) 2008 Yii Software LLC
rem  @license http://www.yiiframework.com/license/
rem -------------------------------------------------------------

@setlocal

cd %~dp0

set TERM_PATH=%~dp0

if "%PHP_COMMAND%" == "" set PHP_COMMAND=%TERM_PATH%\xampp\php\php.exe

"%PHP_COMMAND%" "%TERM_PATH%terminal_console" %*

@endlocal