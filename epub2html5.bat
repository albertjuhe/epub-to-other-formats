
@ECHO ON
REM ***************************************************
REM    epub - html
REM    V.1.0                 
REM ***************************************************
cls
set Code=%1
set origin=.
set Saxon_path=..\SaxonHE9-4-0-1J\saxon9he.jar
set tools=%origin%\tools\
set input_process=%origin%\epub_input\
set output_process=%origin%\output\%Code%
set tmp=%origin%\tmp\%Code%
set xsl=%origin%\xsl\HTML5\
IF NOT EXIST %input_process%%Code%.epub GOTO ERROR_FILE
IF NOT EXIST %Saxon_path% GOTO ERROR_SAXON

echo Opening document %Code%.epub
md %tmp%
md %output_process%
%tools%unzip.exe -d %tmp% %input_process%%Code%.epub
echo Transforming document to HTML5
pause
java -jar %Saxon_path%  %xsl%main.xsl %tmp%/%Code%/META-INF/container.xml -o %output_process%/output.log

PAUSE
copy %tmp%word\media\*.* %output_process%
GOTO FINAL

:ERROR_FILE
echo [ERROR]: Doesn't exists the source file: %input_process%%Code%.epub
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


