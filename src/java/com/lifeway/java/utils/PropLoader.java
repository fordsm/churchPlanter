package com.lifeway.java.utils;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class PropLoader {
	static Log log = LogFactory.getLog(PropLoader.class);
	Properties properties = new Properties();
	
	public PropLoader(String propFileName){
        Properties props = new Properties();
        try{
        InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(propFileName);
        
        if (inputStream == null) {
            throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
        }

        props.load(inputStream);

        this.properties = props;
        }catch (Exception e){
        	log.error(e);
        }
    }

	public Properties getProperties() {
		return properties;
	}
	
	public void setProperties(Properties properties) {
		this.properties = properties;
	}
}
