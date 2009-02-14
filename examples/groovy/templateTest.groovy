// templateTest.groovy

import groovy.text.SimpleTemplateEngine

def tpl_src =
'''

<% def formatDate(date) {
    new java.text.SimpleDateFormat("EEE, MMM d, ''yy").format(date)
}%>

The date today is <% print formatDate(date) %>

'''

def binding = [ "date": Calendar.getInstance().getTime() ]

def engine = new SimpleTemplateEngine()

println engine.createTemplate(tpl_src).make(binding)