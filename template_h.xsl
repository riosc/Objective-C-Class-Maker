<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">

<xsl:text>//</xsl:text> <xsl:value-of select="object/name"/>.h
<xsl:text>//</xsl:text> Draft11
<xsl:text>//</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>//</xsl:text> Created by Carlos Rios on 2/26/15.
<xsl:text>//</xsl:text> Copyright (c) 2015 Carlos Rios. All rights reserved.
<xsl:text>//</xsl:text> <xsl:text>&#xA;</xsl:text>
<xsl:text>//</xsl:text> <xsl:value-of select="object/name"/>.h is generate through Apache ANT script. visit https://github.com/riosc/Objective-C-Class-Maker

#import &#x3c;Foundation/Foundation.h&#x3e;
#import "CRParserProtocol.h"

@interface <xsl:value-of select="object/name"/> : NSObject &#x3c;CRParserProtocol, NSCoding, NSCopying&#x3e;

<xsl:for-each select="object/properties/property">
@property (nonatomic, <xsl:choose><xsl:when test="pointer &#x3d; 'YES'">strong</xsl:when><xsl:otherwise>assign</xsl:otherwise>
</xsl:choose>, readonly) <xsl:value-of select="type"/><xsl:text disable-output-escaping="no"> </xsl:text><xsl:if test="pointer &#x3d; 'YES'">* </xsl:if><xsl:value-of select="name"/>;</xsl:for-each>

<xsl:text>&#xA;</xsl:text>
<xsl:text>&#xA;</xsl:text>
@end
</xsl:template>
</xsl:stylesheet>



