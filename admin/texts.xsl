<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="no"/>

<xsl:template match="/map">
    <xsl:apply-templates select="pages"/>
    <hr/>
    <xsl:apply-templates select="places"/>
</xsl:template>


<xsl:template match="pages">
    <xsl:apply-templates select="page"/>
</xsl:template>

<xsl:template match="page">
    <section>
        <h2>
            <xsl:value-of select="title[@xml:lang='fr']"/>.
        </h2>
        <div class="text">
            <xsl:value-of select="text[@xml:lang='fr']" disable-output-escaping="yes"/>
        </div>
    </section>
</xsl:template>

<xsl:template match="places">
    <xsl:apply-templates select="place">
        <xsl:sort select="@id" data-type="number" order="ascending"/>
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="place">
    <section>
        <a name="place{@id}"></a>
        <h2>
            <xsl:value-of select="@id"/>.
            <xsl:choose>
                <xsl:when test="name[@xml:lang='fr']"><xsl:value-of select="name[@xml:lang='fr']"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="name[1]"/></xsl:otherwise>
            </xsl:choose>
        </h2>
        <!--<p><a href="http://www.pasoliniroma.com/#!/fr/map/{@id}">www.pasoliniroma.com/#!/fr/map/<xsl:value-of select="@id"/></a></p>-->
        <div class="text">
            <xsl:value-of select="desc[@xml:lang='fr']" disable-output-escaping="yes"/>
        </div>
        <xsl:for-each select="m[caption/@xml:lang='fr']">
            <p><strong>Légende n° <xsl:value-of select="position()"/>&#160;: </strong> <xsl:value-of select="caption[@xml:lang='fr']"/></p>
        </xsl:for-each>
    </section>
</xsl:template>

<xsl:template match="cats"/>

</xsl:stylesheet>

