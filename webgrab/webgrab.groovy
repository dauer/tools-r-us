#!/usr/bin/env groovy

/**
 * We need the Jsoup library for parsing web pages
 */
@Grab('org.jsoup:jsoup:1.8.3')
import org.jsoup.Jsoup

def cli = new CliBuilder(usage:   "webgrab.groovy")
cli.u(args:1, argName: "url",     "Grab specified url")
cli.e(args:1, argName: "element", "XPath/CSS selector for element to grab from html")
cli.p(args:0, argName: "print",   "Select only print stylesheets")

def options = cli.parse(args)
if(!options.u || !options.e) {
    // Missing required paramaters, print usage and then quit!
    cli.usage()
    return
}

def doc     = '';
def url     = '';
def baseUrl = '';

try {
    url = new URL(options.u)
    doc = Jsoup.parse(url.text)
} catch(e) {
    // Invalid URL specified, show error message then quit!
    System.err.println "Invalid url specified:"
    System.err.println "\t\t" + e.getMessage()
    return
}

/**
 * Extract the specified content element and head, title, meta and style tags
 * from the html document
 */
def element = doc.select(options.e).toString()
def head    = doc.select("html > head").toString()
def meta    = doc.select("html > head > meta").toString()
def title   = doc.select("html > head > title").toString()
def styles  = ''

/**
 * Get related stylesheets: <link type="text/css" href="...css" />
 * If '-p' option is specified only include print stylesheets
 */
def css = ((options.p)
        ? doc.select("[rel=stylesheet][media~=print]")
        : doc.select("[rel=stylesheet]"))

for (s in css) {
    styles += s.toString() + "\n"
}

/**
 * Not all websites specify absolute urls so we add a baseurl to make relative
 * links work
 */
baseUrl = "<base href=\"" + url.getHost() + "\"/>"

/**
 * Output new html containing only a simple html skeleton and the selected
 * elements
 */
print """
<!DOCTYPE html>
<html>
    <head>
        ${baseUrl}
        ${title}
        ${meta}
        ${styles}
    </head>
    <body>
        ${element}
    </body>
</html>
"""
