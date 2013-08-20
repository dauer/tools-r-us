# Garmin TCX tools #

The problem was that my Garmin Forerunner 305 had registered 3 training sessions as one.
So I needed to split it up...

## Examples ##

### Split ###

The first thing to do is to split the .tcx file into individual .tcx files each containing a lap.
If all trainings sessions are registered as the same lap, this script will not help you, I had my sessions registered with laps.

The split.xsl XSLT script does that (I use the Saxon XSLT processor):

	saxon-xslt -s:out/20130804T132325.tcx -xsl:split.xsl

In my example I ended up with these files:

	Running-2013-8-4-lap-1.tcx
	Running-2013-8-4-lap-2.tcx
	Running-2013-8-4-lap-3.tcx
	Running-2013-8-4-lap-4.tcx
	Running-2013-8-4-lap-5.tcx
	Running-2013-8-4-lap-6.tcx
	Running-2013-8-5-lap-7.tcx
	Running-2013-8-5-lap-8.tcx
	Running-2013-8-8-lap-9.tcx

### Merge ###

My first training session consists of 6 laps, I want these laps merged into one .tcx file:

	saxon-xslt -s:out/20130804T132325.tcx -xsl:merge.xsl files="Running-2013-8-4-lap-1.tcx,Running-2013-8-4-lap-2.tcx,Running-2013-8-4-lap-3.tcx,Running-2013-8-4-lap-4.tcx,Running-2013-8-4-lap-5.tcx,Running-2013-8-4-lap-6.tcx" > Running-2013-8-4.tcx

### Align ###

The problem with the second and third session is that they do not start at kilometer 0 but at 5.084km and 10.230km so they need to be aligned.
The second trainng session was substracted the length of the first session (5084.25 meters):

	saxon-xslt -s:Running-2013-8-5-lap-7.tcx -xsl:align.xsl align="5084.25000" > Running-2013-8-5.tcx

I now have 3 valid .tcx files I can upload to my http://www.endomondo.com profile!

## Requirements ##
 * XSLT 2.0 processor (I use Saxon)
