<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="no"/>


<xsl:variable name="id"></xsl:variable>
<xsl:variable name="lang"></xsl:variable>

<xsl:template match="map">
	<xsl:apply-templates select="places/place[@id=$id]"/>
</xsl:template>


<xsl:template match="node()">
	<xsl:choose>
		<xsl:when test="@xml:lang">
			<xsl:choose>
				<xsl:when test="@xml:lang=$lang">
					<xsl:copy-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="not(../*[name(current())][@xml:lang=$lang]) and not(preceding-sibling::*[name()=name(current())])">
						<xsl:element name="{name()}">[<xsl:value-of select="../*[name(current())][1]"/>]</xsl:element>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:copy>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="node()"/>
			</xsl:copy>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="latLng">
	<latLng><xsl:value-of select="substring-before(.,',')"/></latLng>
	<latLng><xsl:value-of select="substring-after(.,',')"/></latLng>
</xsl:template>


<xsl:template match="place/cat">
	<xsl:apply-templates select="//cats/cat[@id=current()]"/>
</xsl:template>


<xsl:template match="@*">
	<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
</xsl:template>


</xsl:stylesheet>