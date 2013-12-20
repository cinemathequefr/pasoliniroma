<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="no"/>

<xsl:template match="map">
	<xsl:apply-templates select="places"/>
</xsl:template>

<xsl:template match="node()">
	<xsl:copy>
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="place|name[1]|latLng|pos|cat|text()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="@*">
	<xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
</xsl:template>


<xsl:template match="cat">
	<cat><xsl:value-of select="text()"/></cat>
	<cat-it><xsl:apply-templates select="../cat[1]" mode="with-lang"><xsl:with-param name="lang">it</xsl:with-param><xsl:with-param name="id"><xsl:value-of select="text()"/></xsl:with-param></xsl:apply-templates></cat-it>
	<cat-ca><xsl:apply-templates select="../cat[1]" mode="with-lang"><xsl:with-param name="lang">ca</xsl:with-param><xsl:with-param name="id"><xsl:value-of select="text()"/></xsl:with-param></xsl:apply-templates></cat-ca>
	<cat-es><xsl:apply-templates select="../cat[1]" mode="with-lang"><xsl:with-param name="lang">es</xsl:with-param><xsl:with-param name="id"><xsl:value-of select="text()"/></xsl:with-param></xsl:apply-templates></cat-es>
	<cat-en><xsl:apply-templates select="../cat[1]" mode="with-lang"><xsl:with-param name="lang">en</xsl:with-param><xsl:with-param name="id"><xsl:value-of select="text()"/></xsl:with-param></xsl:apply-templates></cat-en>
	<cat-fr><xsl:apply-templates select="../cat[1]" mode="with-lang"><xsl:with-param name="lang">fr</xsl:with-param><xsl:with-param name="id"><xsl:value-of select="text()"/></xsl:with-param></xsl:apply-templates></cat-fr>
	<cat-de><xsl:apply-templates select="../cat[1]" mode="with-lang"><xsl:with-param name="lang">de</xsl:with-param><xsl:with-param name="id"><xsl:value-of select="text()"/></xsl:with-param></xsl:apply-templates></cat-de>
</xsl:template>

<xsl:template match="cat" mode="with-lang">
	<xsl:param name="lang"/>
	<xsl:param name="id"/>
	<xsl:choose>
		<xsl:when test="/map/cats/cat[@id=$id]/name[@xml:lang=$lang]">
			<xsl:value-of select="/map/cats/cat[@id=$id]/name[@xml:lang=$lang]"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="/map/cats/cat[@id=$id]/name[1]"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>




<xsl:template match="name">
	<name-it><xsl:apply-templates select="../name[1]" mode="with-lang"><xsl:with-param name="lang">it</xsl:with-param></xsl:apply-templates></name-it>
	<name-ca><xsl:apply-templates select="../name[1]" mode="with-lang"><xsl:with-param name="lang">ca</xsl:with-param></xsl:apply-templates></name-ca>
	<name-es><xsl:apply-templates select="../name[1]" mode="with-lang"><xsl:with-param name="lang">es</xsl:with-param></xsl:apply-templates></name-es>
	<name-en><xsl:apply-templates select="../name[1]" mode="with-lang"><xsl:with-param name="lang">en</xsl:with-param></xsl:apply-templates></name-en>
	<name-fr><xsl:apply-templates select="../name[1]" mode="with-lang"><xsl:with-param name="lang">fr</xsl:with-param></xsl:apply-templates></name-fr>
	<name-de><xsl:apply-templates select="../name[1]" mode="with-lang"><xsl:with-param name="lang">de</xsl:with-param></xsl:apply-templates></name-de>
</xsl:template>

<xsl:template match="name" mode="with-lang">
	<xsl:param name="lang"/>
	<xsl:choose>
		<xsl:when test="../name[@xml:lang=$lang]">
			<xsl:value-of select="../name[@xml:lang=$lang]"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="../name[1]"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="latLng">
	<latLng><xsl:value-of select="substring-before(.,',')"/></latLng>
	<latLng><xsl:value-of select="substring-after(.,',')"/></latLng>
</xsl:template>

</xsl:stylesheet>