<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:garmin="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" xmlns="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" exclude-result-prefixes="#default">

    <!-- Specify the 'align' parameter on CLI-->
    <xsl:param name="align">0</xsl:param>

    <xsl:template match="/garmin:TrainingCenterDatabase">
        <TrainingCenterDatabase>
            <Activities>
                <Activity>
                <xsl:attribute name="Sport">
                    <xsl:value-of select="./garmin:Activities/garmin:Activity/@Sport" />
                </xsl:attribute>
                <Id>
                    <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Id" />
                </Id>
                <Lap>
                    <xsl:attribute name="StartTime">
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/@StartTime" />
                    </xsl:attribute>
                    <!-- Direct copy of all child elements except <Track> -->
                    <xsl:for-each select="./garmin:Activities/garmin:Activity/garmin:Lap/*[local-name() != 'Track']">
                        <xsl:copy-of select="." />
                    </xsl:for-each>
                    <Track>
                        <xsl:for-each select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:Track/garmin:Trackpoint">
                            <Trackpoint>
                                <xsl:copy-of select="./garmin:Time" />
                                <!-- Add extra fields if they exist -->
                                <xsl:if test="./garmin:Position">
                                    <xsl:copy-of select="./garmin:Position" />
                                    <xsl:copy-of select="./garmin:AltitudeMeters" />
                                    <DistanceMeters>
                                        <!-- Calculate new distance in meters -->
                                        <xsl:value-of select="format-number(./garmin:DistanceMeters - $align, '0.#####')" />
                                    </DistanceMeters>
                                </xsl:if>
                            </Trackpoint>
                        </xsl:for-each>
                    </Track>
                </Lap>
                </Activity>
            </Activities>
        </TrainingCenterDatabase>
    </xsl:template>

</xsl:stylesheet>
