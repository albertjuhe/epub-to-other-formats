
@ECHO ON
REM ***************************************************
REM    epub - html
REM    V.1.0                 
REM ***************************************************
cls
set Code=%1
set origin=..\epub2html
set Saxon_path=..\SaxonHE9-4-0-1J\saxon9he.jar
set tools=%origin%\tools
set input_process=%origin%\input\
set output_process=%origin%\output\
set tmp=%origin%\tmp\
set xsl=%origin%\xsl\
IF NOT EXIST %input_process%%Code% GOTO ERROR_FILE
IF NOT EXIST %Saxon_path% GOTO ERROR_SAXON

echo Opening document %Code%
%tools%unzip.exe -d %tmp% %input_process%%Code%
echo Transforming document to HTML5

java -jar %Saxon_path% %tmp%/META-INF/container.xml -o %output_process%/output.html

PAUSE
rem copy %tmp%word\media\*.* %output_process%
GOTO FINAL

:ERROR_FILE
echo [ERROR]: Doesn't exists the source file: %input_process%%Code%
echo OUTPUT ERROR.
GOTO THEEND

:ERROR_SAXON
echo [ERROR]: Can't find %Saxon_path%
echo Saxon is necessary.
echo Output not generated.
GOTO THEEND

:FINAL
echo Process OK

:THEEND
pause


