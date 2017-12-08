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
    
    <xsl:template match="p"  mode="copy-all">
        <div class="row-fluid">
            <div class="span9">
                <div class="para" id="{generate-id()}">
                        <xsl:copy-of select="@*"/>
                        <xsl:apply-templates mode="copy-all"/>
                </div>
            </div>
            <div class="span3"/>
        </div>
    </xsl:template>
    
    <xsl:template match="img"  mode="copy-all">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="src" select="concat('img/',@src)"/>
            <xsl:apply-templates mode="copy-all"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="h1 | h2 | h3 | h4 | h5 | h6"  mode="copy-all">
        <div class="row-fluid">
            <div class="span9">
                <div class="para" id="{generate-id()}">
                    <header>
                    <xsl:copy>
                     <xsl:copy-of select="@*"/>
                        <xsl:if test="not(@id)">
                            <xsl:attribute name="id" select="generate-id()"/>
                        </xsl:if>
                     <xsl:apply-templates mode="copy-all"/>
                    </xsl:copy>
                        </header>
                </div>
            </div>
            <div class="span3"/>
        </div>
    </xsl:template>
    
</xsl:stylesheet>
