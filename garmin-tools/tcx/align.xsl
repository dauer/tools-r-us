<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:garmin="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" xmlns="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" exclude-result-prefixes="garmin">

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
                    <TotalTimeSeconds>
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:TotalTimeSeconds" />
                    </TotalTimeSeconds>
                    <DistanceMeters>
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:DistanceMeters" />
                    </DistanceMeters>
                    <MaximumSpeed>
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:MaximumSpeed" />
                    </MaximumSpeed>
                    <Calories>
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:Calories" />
                    </Calories>
                    <Intensity>
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:Intensity" />
                    </Intensity>
                    <TriggerMethod>
                        <xsl:value-of select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:TriggerMethod" />
                    </TriggerMethod>
                    <Track>
                        <xsl:for-each select="./garmin:Activities/garmin:Activity/garmin:Lap/garmin:Track/garmin:Trackpoint">
                            <Trackpoint>
                                <Time>
                                    <xsl:value-of select="./garmin:Time" />
                                </Time>
                                <!-- TODO Add extra fields if they exist -->
                                <xsl:if test="./garmin:Position">
                                    <Position>
                                        <LatitudeDegrees>
                                            <xsl:value-of select="./garmin:Position/garmin:LatitudeDegrees" />
                                        </LatitudeDegrees>
                                        <LongitudeDegrees>
                                            <xsl:value-of select="./garmin:Position/garmin:LongitudeDegrees" />
                                        </LongitudeDegrees>
                                    </Position>
                                    <AltitudeMeters>
                                        <xsl:value-of select="./garmin:AltitudeMeters" />
                                    </AltitudeMeters>
                                    <DistanceMeters>
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
