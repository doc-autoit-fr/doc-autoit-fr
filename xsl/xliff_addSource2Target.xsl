<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="urn:oasis:names:tc:xliff:document:1.2"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlf="urn:oasis:names:tc:xliff:document:1.2" xmlns:okp="okapi-framework:xliff-extensions"
    xmlns:its="http://www.w3.org/2005/11/its" xmlns:itsxlf="http://www.w3.org/ns/its-xliff/"
    its:version="2.0" exclude-result-prefixes="xlf its itsxlf">
    <xsl:output method="xml" indent="no" encoding="UTF-8"/>
    <xsl:preserve-space elements="*"/>
    
    <xsl:variable name="srcLng" select="//xlf:file/@source-language"/>
    <xsl:variable name="trgLng" select="//xlf:file/@target-language"/>
    
    <xsl:template match="//xlf:target/xlf:mrk">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            
            <xsl:variable name="mid">
                <xsl:value-of select="@mid"/>
            </xsl:variable>
            <xsl:variable name="mrk_segSrc">
                <xsl:copy-of select="../../xlf:seg-source/xlf:mrk[@mid = $mid]/node()"/>
            </xsl:variable>
            <xsl:variable name="mrk_segTrg">
                <xsl:copy-of select="node()"/>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$mrk_segSrc != $mrk_segTrg">
                    <!--<span class="segments">-->
                    <bpt id="span_segments">
                        <xsl:text><![CDATA[<span class="segments">]]></xsl:text>
                    </bpt>
                    
                    <!--<span lang="en">-->
                    <bpt id="span_srcLng">
                        <xsl:text><![CDATA[<span lang="]]></xsl:text>
                        <xsl:value-of select="$srcLng"/>
                        <xsl:text><![CDATA[">]]></xsl:text>
                    </bpt>
                    
                    <!-- contenu du <mrk> du texte original-->
                    <xsl:copy-of select="$mrk_segSrc"/>
                    
                    <!--</span>-->
                    <ept id="span_srcLng">
                        <xsl:text><![CDATA[</span>]]></xsl:text>
                    </ept>
                    
                    <!--<span lang="fr" style="display: none">-->
                    <bpt id="span_trgLng">
                        <xsl:text><![CDATA[<span lang="]]></xsl:text>
                        <xsl:value-of select="$trgLng"/>
                        <xsl:text><![CDATA[" style="display: none">]]></xsl:text>
                    </bpt>
                    
                    <!-- contenu du <mrk> traduit dans <target> -->
                    <xsl:apply-templates/>
                    
                    <!--</span>-->
                    <ept id="span_trgLng">
                        <xsl:text><![CDATA[</span>]]></xsl:text>
                    </ept>
                    
                    <!--</span>-->
                    <ept id="span_segments">
                        <xsl:text><![CDATA[</span>]]></xsl:text>
                    </ept>
                </xsl:when>
                
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
