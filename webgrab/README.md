WEBGRAB
=======

A small tool written in Groovy for extracting parts of an html document.

## Requirements ##
* Groovy
* Jsoup

## Documentation ##
"Modern" websites are often stuffed with content and commercial elements that not allways make them small screen friendly.
I wrote webgrab so I could easily extract relevant elements from a website.

Imagine you are going to a conference and you would like to bring a copy of the schedule with you, but their website doesn't work very well on your mobilephone, what to do?
Hypothetically this could be the conference website:

http://opensourcedays.org/2013/saturday

So you run it through webgrab to get a html document containing only the table with the schedule:

./webgrab.groovy -u http://www.opensourcedays.org/2013/saturday -e "#main table" > table.html

## Usage ##

webgrab takes 3 parameters:
* -u &lt;url&gt; : The url you want to parse
* -e &lt;element&gt; : The element you want to extract (XPath / CSS selector)
* -p : Include only print stylesheets

### Example ###
The following code extracts the conference schedule table by specifying a CSS selector "#main table" (you may specify XPath selectors if that is your prefered dialect) that matches the element in the html document from the specified website and save it in the file "table.html"

./webgrab.groovy -u http://www.opensourcedays.org/2013/saturday -e "#main table" > table.html

## TODO ##
Webgrab is in an early development stage and so it is by no means perfect.

The code could be better structured and the selector rules are probably not general enough to match all scenarios...
