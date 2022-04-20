<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xpath-default-namespace="urn:fdc:difi.no:2017:vefa:structure-1">

<xsl:output method="text" indent="no" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<!-- <xsl:text>Root Document </xsl:text><xsl:value-of select="//Document/Term/text()"/><xsl:text>&#xa;</xsl:text>
	<xsl:text>&#xa;</xsl:text>  -->
    <xsl:apply-templates select="//Document" />
</xsl:template>

<xsl:template match="//Document">
<xsl:text>Document;xPath;Element;Name;Cardinality;&#xa;</xsl:text>
<xsl:apply-templates select="Element">
      <xsl:with-param name="prev" select = "''" />
	  <xsl:with-param name="document" select="Term/text()" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="Element" name="Element">
	<xsl:param name = "prev" />
	<xsl:param name = "document" />
	<xsl:value-of select="$document"/><xsl:text>;</xsl:text>
	<xsl:variable name="epath">
		<xsl:value-of select="concat($prev,'/',Term/text())"  />
	</xsl:variable>
	<xsl:value-of select="$epath"/><xsl:text>;</xsl:text>
	<xsl:value-of select="Term/text()"/><xsl:text>;</xsl:text>
	<xsl:value-of select="Name/text()"/><xsl:text>;</xsl:text>
	<xsl:text></xsl:text>
	<xsl:if test="exists(@cardinality)">
		<xsl:value-of select="@cardinality"/>
	</xsl:if>
	<xsl:if test="not(exists(@cardinality))">
		<xsl:value-of select="'1..1'"/>
	</xsl:if>
	<xsl:text>;</xsl:text>
	<xsl:text>&#xa;</xsl:text> 
	<xsl:apply-templates select="Attribute">
      <xsl:with-param name="prev" select = "$epath" />
	  <xsl:with-param name="document" select="$document" />
    </xsl:apply-templates>
	<xsl:apply-templates select="Element">
      <xsl:with-param name="prev" select = "$epath" />
	  <xsl:with-param name="document" select="$document" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="Attribute" name="Attribute">
	<xsl:param name = "prev" />
	<xsl:param name = "document" />
	<xsl:value-of select="$document"/><xsl:text>;</xsl:text>
	<xsl:variable name="epath">
		<xsl:value-of select="concat($prev,'@',Term/text())"  />
	</xsl:variable>
	<xsl:value-of select="$epath"/><xsl:text>;</xsl:text>
	<xsl:value-of select="Term/text()"/><xsl:text>;</xsl:text>
	<xsl:value-of select="Name/text()"/><xsl:text>;</xsl:text>
	<xsl:text></xsl:text>
	<xsl:if test="exists(@usage)">
		<xsl:choose>
			<xsl:when test="contains(@usage,'opt')">
				<xsl:value-of select="'0..1'"/>
			</xsl:when>
			<xsl:when test="contains(@usage,'man')">
				<xsl:value-of select="'1..1'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0..1'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<xsl:if test="not(exists(@usage))">
		<xsl:value-of select="'1..1'"/>
	</xsl:if>
	<xsl:text>;</xsl:text>
	<xsl:text>&#xa;</xsl:text> 
</xsl:template>
</xsl:stylesheet>