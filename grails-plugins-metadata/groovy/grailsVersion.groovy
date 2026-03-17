#!/usr/bin/env groovy

@Grapes([
    @Grab(group='tech.tablesaw', module='tablesaw-jsplot', version='0.44.4'),
])

import groovy.json.JsonSlurper
import tech.tablesaw.plotly.components.Figure
import tech.tablesaw.plotly.Plot
import tech.tablesaw.api.Table
import tech.tablesaw.api.StringColumn
import tech.tablesaw.plotly.components.Layout
import tech.tablesaw.plotly.traces.PieTrace
import tech.tablesaw.api.IntColumn

def slurper = new JsonSlurper()
def url = new URL('https://raw.githubusercontent.com/apache/grails-plugins-metadata/refs/heads/main/grails-plugins-index.json')
def data = slurper.parse(url)

def pluginsMaxVersion = GQ {
    from o in data
    select o.name, o.versions.grailsVersion.sort().last()?[0] as version
}

def countByVersion = GQ {
    from i in pluginsMaxVersion
    groupby i.version
    select count(i), i.version
}

String[] grails = []
Integer[] count = []

countByVersion.each { x, y ->
    grails += 'Grails ' + y
    count  +=  x
}

Table table = Table.create("Releases")
        .addColumns(
            StringColumn.create("grails ", grails),
            IntColumn.create("count", count))

PieTrace trace =
        PieTrace.builder(table.categoricalColumn("grails"), table.numberColumn("count")).build()

Layout layout = Layout.builder().title("Plugins by max Grails version").build()

Plot.show(new Figure(layout, trace));
