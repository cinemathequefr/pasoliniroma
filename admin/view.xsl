<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="no"/>

<xsl:template match="map">
    <xsl:apply-templates select="places"/>
</xsl:template>

<xsl:template match="places">
    <table summary="">
        <tr>
            <th class="w5">Id</th>
            <th class="w5">Json</th>
            <th class="w5">Card Trello</th>
            <th class="w5">Lat, Lng</th>
            <th class="w5">Timeline</th>
            <th class="w5">Date</th>
            <th class="w20">Intitulé</th>
            <th class="w10">Catégorie</th>
        </tr>
        <xsl:apply-templates match="place">
            <xsl:sort select="cat" data-type="number" order="ascending"/>
            <xsl:sort select="@id" data-type="number" order="ascending"/>
        </xsl:apply-templates>
    </table>
</xsl:template>

<xsl:template match="place">
    <tr class="bg{cat}">
        <td class="c"><a target="_blank" href="../index.htm#!/fr/map/{@id}"><xsl:value-of select="@id"/></a></td>
        <td class="c"><a target="_blank" href="../data/places/{@id}-fr.json">Json</a></td>
        <td class="c">
            <xsl:if test="trello/text()">
                <a target="_blank" href="https://trello.com/c/{trello}">Card Trello</a>
            </xsl:if>
        </td>
        <td class="c"><xsl:value-of select="latLng"/></td>
        <td class="c"><xsl:value-of select="pos"/></td>
        <td class="c"><xsl:value-of select="date"/></td>
        <td>
            <xsl:choose>
                <xsl:when test="name[@xml:lang='fr']"><xsl:value-of select="name[@xml:lang='fr']"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="name[1]"/></xsl:otherwise>
            </xsl:choose>
        </td>
        <td class="c"><xsl:apply-templates select="cat"/></td>
    </tr>
</xsl:template>

<xsl:template match="place/cat">
    <xsl:value-of select="/map/cats/cat[@id=current()]/name[@xml:lang='fr']"/>
</xsl:template>

<xsl:template match="cats"></xsl:template>

</xsl:stylesheet>

