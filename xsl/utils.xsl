<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:urn="urn:oasis:names:tc:opendocument:xmlns:container"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:opf="http://www.idpf.org/2007/opf"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 8, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Albert</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <!--
       Remove /
    -->
    <xsl:template name="get-last-path-part">
        <xsl:param name="content" select="."/>
        
        <xsl:choose>
            <xsl:when test="contains($content,'/')">
                <xsl:variable name="text" select="substring-after($content,'/')"/>
                <xsl:call-template name="get-last-path-part">
                    <xsl:with-param name="content" select="$text"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$content"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="position-bar">
        <xsl:param name="menu"/>
        <xsl:param name="title"/>
        <xsl:param name="menu-global"/>
        <xsl:param name="current-file"/>
        
        <div id="nav-wrap">
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <div id="nav-content">
                            <div id="top"><a class="nav-open-btn" href="#nav" id="nav-open-btn"><span class="visuallyhidden">Open Navigation</span></a><a class="brand" href="index.html"><xsl:value-of select="$title"></xsl:value-of></a></div>
                            <div id="nav">
                                <div class="nav-block">
                                    <ul class="nav">
                                        <xsl:for-each select="$menu-global">
                                        <li>
                                            <xsl:if test="normalize-space($current-file)=@idref">
                                                <xsl:attribute name="class" select="'active'"/>
                                            </xsl:if>    
                                            <a rel="tooltip" href="chapter_{@idref}.html" data-original-title="chapter_{@idref}.html">Chapter <xsl:value-of select="position()"/></a>
                                        </li>
                                        </xsl:for-each>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="position-bar">
            <div class="progress"></div>
            <ul class="nav position-nav">
                <xsl:for-each select="$menu">
                    <li><a class="s1" href="#{@id}" rel="tooltip" title="{.}"><span class="line"></span><span class="visuallyhidden"><xsl:value-of select="."/></span></a></li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
</xsl:stylesheet>
