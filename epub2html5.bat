
@ECHO ON
REM ***************************************************
REM    epub 
REM    V.1.0                 
REM ***************************************************
cls
set Code=%1
set format_output=%2
set origin=.
set Saxon_path=..\SaxonHE9-4-0-1J\saxon9he.jar
set tools=%origin%\tools\
set input_process=%origin%\epub_input\
set output_process=%origin%\output\%Code%
set tmp=%origin%\tmp
set xsl=%origin%\xsl\%format_output%\
IF NOT EXIST %input_process%%Code%.epub GOTO ERROR_FILE
IF NOT EXIST %Saxon_path% GOTO ERROR_SAXON

echo Opening document %Code%.epub
md %tmp%
md %output_process%
%tools%unzip.exe -d %tmp%\%Code% %input_process%%Code%.epub
echo Transforming document to %format_output%
java -cp  %Saxon_path%;lib/resolver.jar -Dxml.catalog.files=dtds/catalog.xml net.sf.saxon.Transform  -r:org.apache.xml.resolver.tools.CatalogResolver -x:org.apache.xml.resolver.tools.ResolvingXMLReader  -y:org.apache.xml.resolver.tools.ResolvingXMLReader -xsl:%xsl%main.xsl -s:%tmp%/%Code%/META-INF/container.xml -o:%output_process%/output.log code-epub=%Code%

GOTO END

:ERROR_FILE
echo [ERROR]: Doesn't exists the source file: %input_process%%Code%.epub
echo OUTPUT ERROR.
GOTO THEEND

:ERROR_SAXON
echo [ERROR]: Can't find %Saxon_path%
echo Saxon is necessary.
echo Output not generated.
GOTO THEEND

:END
echo Process OK

:THEEND
pause


