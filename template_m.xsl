<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">

<xsl:text>//</xsl:text> <xsl:value-of select="object/name"/>.m
<xsl:text>//</xsl:text> Draft11
<xsl:text>//</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>//</xsl:text> Created by Carlos Rios on 2/26/15.
<xsl:text>//</xsl:text> Copyright (c) 2015 Carlos Rios. All rights reserved.

#import "<xsl:value-of select="object/name"/>.h"
#define NOT_NIL(var) (var) ? var : @""

<xsl:for-each select="object/properties/property">
static NSString * const k<xsl:value-of select="name"/>Key = @"<xsl:value-of select="name"/>";</xsl:for-each>

@implementation <xsl:value-of select="object/name"/>


- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
	<xsl:for-each select="object/properties/property">
	_<xsl:value-of select="name"/> = [dict safeObjectForKey:k<xsl:value-of select="name"/>Key];</xsl:for-each>
    }
    return self;
}

- (id) serializeAttributes
{
    return @{
		    <xsl:for-each select="object/properties/property">
			k<xsl:value-of select="name"/>Key : <xsl:choose> <xsl:when test="pointer &#x3d; 'YES'"> NOT_NIL(_<xsl:value-of select="name"/>),</xsl:when> <xsl:otherwise>NOT_NIL(@(_<xsl:value-of select="name"/>)),</xsl:otherwise></xsl:choose></xsl:for-each>
             };
}

+ (NSArray *) objsFromJSONArray:(NSArray *)array
{
    NSMutableArray * mutable = [NSMutableArray new];
    for (NSDictionary * dic in array)
        [mutable addObject:[[[self class] alloc] initWithDictionary:dic]];
    
    return mutable;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"&#x3c;%@&#x3e;", [self serializeAttributes]];
}

#pragma mark -- NSCoding Protocol

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self)
    {
        <xsl:for-each select="object/properties/property">
        _<xsl:value-of select="name"/> = [coder decodeObjectForKey:k<xsl:value-of select="name"/>Key];</xsl:for-each>
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    <xsl:for-each select="object/properties/property">
    [coder encodeObject:NOT_NIL(_<xsl:value-of select="name"/>) forKey:k<xsl:value-of select="name"/>Key];</xsl:for-each>
}

#pragma mark -- NSCopy Protocol

- (id) copyWithZone:(NSZone *)zone
{
    <xsl:value-of select="object/name"/> * newObject        = [[self class] allocWithZone:zone];
    <xsl:for-each select="object/properties/property">
    newObject->_<xsl:value-of select="name"/>   = [_<xsl:value-of select="name"/> copy];</xsl:for-each>
    
    return newObject;
}

<xsl:text>&#xA;</xsl:text>
<xsl:text>&#xA;</xsl:text>
@end
</xsl:template>
</xsl:stylesheet>



