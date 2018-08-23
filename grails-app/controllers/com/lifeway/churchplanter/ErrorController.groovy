package com.lifeway.churchplanter

import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.Environment

class ErrorController {
 
    def index() {
        if ( Environment.PRODUCTION == Environment.current) {
            // Production: show a nice error message
            render(view:'production')
        } else {
            // Not it production? show an ugly, developer-focused error message
            render(view:'development')
        }
    }
}
