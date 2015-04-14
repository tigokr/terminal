start /min c:\terminal\metrokiller.exe
timeout /t 1
c:\terminal\enter.vbs
timeout /t 1
c:\terminal\enter.vbs
timeout /t 1
start c:\terminal\run.bat
timeout /t 15

c:\terminal\xampp\php\php.exe -c c:\terminal\xampp\php\php.ini c:\terminal\www\install\import_items.php
c:\terminal\xampp\php\php.exe -c c:\terminal\xampp\php\php.ini c:\terminal\www\install\import_counts.php 
c:\terminal\xampp\php\php.exe -c c:\terminal\xampp\php\php.ini c:\terminal\www\install\import_items_photos.php 
c:\terminal\xampp\php\php.exe -c c:\terminal\xampp\php\php.ini c:\terminal\www\install\import_desc.php

start /min c:\terminal\rests.bat
start /min c:\terminal\nomenclature.bat