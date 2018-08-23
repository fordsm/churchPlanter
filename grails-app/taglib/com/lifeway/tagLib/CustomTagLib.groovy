package com.lifeway.tagLib

import com.lifeway.cpDomain.Country
import com.lifeway.cpDomain.Locale
class CustomTagLib {
	def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib()
	def stateDropDown = { attrs ->
		def country = Country.findByAbbrv(attrs.countryAbbrv)
		def stateList = country.states.sort{a,b-> a.name.compareTo(b.name)}
		if(stateList.size() > 0){
			out << "<select name='" + attrs.name + "' id='${attrs.id}'>"
			out << "<option value=''>Select...</option>"
			stateList.each {
				out << "<option value='${it.abbrv}'"
				if(attrs.selectedValue == it.name || attrs.selectedValue == it.abbrv){
					out << " selected='selected'"
				}
				out << ">${it.name}</option>"
			}
			out << "</select>"
		}else{
			out << "<input type='text' name='" + attrs.name + "' value='" + attrs.selectedValue + "' />"
		}

		out << "<script>"

		out << "\$('#country').change(function() {"

		out << " \$.ajax({"
		out << ' type: "POST",'
		out << ' url: "' + g.createLink(controller:'churchPlanter', action:'showStates') + '?countryAbbrv=" + $(\'#country\').val() + "&fieldName=' + attrs.name + '",'
		out << 'cache:false,'
		out << 'success: function(data) {'
		out << "\$('#state').html(data);"
		out << ' }});'
		out << '})'
		out << '</script>'
	}

	def abbr = { attrs ->
		def elipsis = (attrs.value.size() > attrs.maxLength.toInteger())? "..." : ""

		out << org.apache.commons.lang.StringUtils.substring( attrs.value,
				0, attrs.maxLength.toInteger() ) + elipsis
	}
	def locale = {attrs ->
		def locales = Locale.findAll().sort{a,b-> a.description.compareTo(b.description)}

		out << "<select name='" + attrs.name + "'>"
		out << "<option value=''>Select...</option>"
		locales.each {
			out << "<option value='${it.id}'"
			if(attrs.selectedValue == it.id){
				out << " selected='selected'"
			}
			out << ">${it.description}</option>"
		}
		out << "</select>"
	}
}
