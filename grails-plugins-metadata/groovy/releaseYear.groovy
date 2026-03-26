#!/usr/bin/env groovy

@Grapes([
    @Grab(group='tech.tablesaw', module='tablesaw-jsplot', version='0.44.4'),
])

import groovy.json.JsonSlurper
import java.time.LocalDate
import tech.tablesaw.plotly.Plot
import tech.tablesaw.api.Table
import tech.tablesaw.api.StringColumn
import tech.tablesaw.api.IntColumn
import tech.tablesaw.plotly.api.HorizontalBarPlot

def slurper = new JsonSlurper()

URL url = new URI('https://raw.githubusercontent.com/apache/grails-plugins-metadata/refs/heads/main/grails-plugins-index.json').toURL()
def obj = slurper.parse(url)

def result = GQ {
    from o in obj select o.versions.first().date
}

List<LocalDate> datoer = []
result.each {
    LocalDate localDate = LocalDate.parse(it.toString().substring(0, 4) + '-12-31')
    datoer.add(localDate)
}

def res = GQ {
    from n in datoer
    groupby n
    orderby n
    select n as year, count(n) as updated
}

String[] years    = []
Integer[] updates = []

res.each { year, updated ->
    years   += year.toString().take(4)
    updates += updated
}

Table table = Table.create("Releases")
        .addColumns(
                IntColumn.create("price", updates),
                StringColumn.create("rating", years)
        )

Plot.show(HorizontalBarPlot.create("Plugins last updated year", table, "rating", "price"))