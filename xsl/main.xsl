<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:urn="urn:oasis:names:tc:opendocument:xmlns:container"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:opf="http://www.idpf.org/2007/opf"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 7, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Albert Juhé Brugué</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    <xsl:include href="utils.xsl"/>
    <xsl:include href="match.xsl"/>

    <xsl:output method="xhtml" encoding="UTF-8"  indent="yes"/>

    <xsl:param name="epub-path" select="'epub_input/pg76/'"/>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="urn:container">
        <!-- Where is toc.ncx? -->
        <xsl:variable name="content.opf"
            select="/urn:container/urn:rootfiles/urn:rootfile/@full-path"/>
        <xsl:variable name="file-name">
            <xsl:call-template name="get-last-path-part">
                <xsl:with-param name="content" select="$content.opf"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="path.content.opf" select="substring-before($content.opf,$file-name)"/>
        <!-- test content.opf existence to start processing -->
        <xsl:variable name="file-name-content-opf" select="concat($epub-path,$content.opf)"/>
        
        <xsl:if test="not(doc-available($file-name-content-opf))">
            <xsl:message terminate="yes">Error: File <xsl:value-of select="$file-name-content-opf"/>
                doesn't exists.</xsl:message>
        </xsl:if>
       
        <!-- 
            We have to read de spine tag, The spine element defines the default reading order of the EPUB Publication.
        -->
        <xsl:apply-templates select="document($file-name-content-opf)/opf:package">
            <xsl:with-param name="global-path" tunnel="yes" select="$path.content.opf"/>
        </xsl:apply-templates>
        
    </xsl:template>

    <xsl:template match="opf:package">
        <xsl:param name="global-path"  tunnel="yes" />
        <!-- <itemref idref="id00000" linear="yes"/> -->
        
        <xsl:variable name="title" select="opf:metadata/dc:title"/>
        <xsl:variable name="menu-global" select="opf:spine/opf:itemref"></xsl:variable>
        <xsl:for-each select="opf:spine/opf:itemref">
            <xsl:variable name="id-item" select="@idref"/>
            <xsl:variable name="file-name-html" select="ancestor::opf:package/opf:manifest/opf:item[@id=$id-item]/@href"/>
            <xsl:variable name="path-filename-html" select="$epub-path,$global-path,$file-name-html"/>
            <xsl:value-of select="$path-filename-html"></xsl:value-of>
            <xsl:result-document href="chapter_{$id-item}.html" doctype-system="html" method="xhtml"  xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all">
                <xsl:variable name="epub-file" select="document($path-filename-html)"/>               
                <html>
                    <head><meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
                        
                        <meta charset="utf-8" />
                        <title><xsl:value-of select="$title"/></title>
                        <meta content="width=device-width, initial-scale=1.0, minimum-scale=1" name="viewport" />
                        <meta content="Titol" name="{$title}" />
                        <meta content="" name="author" />
                        <link href="./css/prettify.css" rel="stylesheet" />
                        <link href="./css/annotator.css" rel="stylesheet" />
                        <link href="./css/style.css" rel="stylesheet" />
                        <script src="/socket.io/socket.io.js"></script>
                        
                        <script src="./locale/en/annotator.js"></script><script src="./js/modernizr-2.6.2.min.js"></script><title><xsl:value-of select="$title"/></title>
                    </head>
                    <body data-offset="550" data-spy="scroll" data-target="#position-bar">
                        <div id="outer-wrap">
                            <div id="inner-wrap">
                                <xsl:call-template name="position-bar">
                                    <xsl:with-param name="menu" select="$epub-file/html:html/html:body//*[self::h1 or self::h2 or self::h3]"/>
                                    <xsl:with-param name="title" select="$title"/>
                                    <xsl:with-param name="menu-global" select="$menu-global"/>
                                    <xsl:with-param name="current-file" select="$id-item"></xsl:with-param>
                                </xsl:call-template>
                                <div class="container" id="container">
                                    <div id="content">
                                        <h1><xsl:value-of select="$title"/></h1>
                                        <xsl:apply-templates select="$epub-file/html:html/html:body/*" mode="copy-all"/>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <script src="./js/jquery-1.9.1.js"></script><script src="./js/bootstrap-custom.min.js"></script><script src="./js/prettify.js"></script><script src="./js/jquery.masonry.min.js"></script><script src="./js/main.js"></script>
                        </body>
                </html>
            </xsl:result-document>
            
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*" mode="copy-all">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="copy-all"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*"/>

</xsl:stylesheet>
