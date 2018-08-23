	dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
     /*dataSource {
			pooled = true
			driverClassName = 'com.mysql.jdbc.Driver'
			username = 'cpUser'
			password = 'secret'
           dbCreate = "update" // one of 'create', 'create-drop','update'
			url = 'jdbc:mysql://localhost/cpca3'
        }*/
		
		dataSource {
			pooled = true
			 driverClassName = 'com.mysql.jdbc.Driver'
			 username = 'cpcaUser'
			 password = 'Cpc421686'
			 dbCreate = "update"//"create" // one of 'create', 'create-drop','update'
			 url = "jdbc:mysql://lwymyqndcd01.lifeway.org/cpca2"
			 properties {
				 maxActive = -1
				 minEvictableIdleTimeMillis=1800000
				 timeBetweenEvictionRunsMillis=1800000
				 numTestsPerEvictionRun=3
				 testOnBorrow=true
				 testWhileIdle=true
				 testOnReturn=true
				 validationQuery="SELECT 1"
			  }
		 }
    }
    test {
        dataSource {
           pooled = true
			driverClassName = 'com.mysql.jdbc.Driver'
			username = 'cpcaUser'
			password = 'Cpc421686'
			dbCreate = "update"//"create" // one of 'create', 'create-drop','update'
			url = "jdbc:mysql://lwmysqldev/cpca2"
			properties {
				maxActive = -1
				minEvictableIdleTimeMillis=1800000
				timeBetweenEvictionRunsMillis=1800000
				numTestsPerEvictionRun=3
				testOnBorrow=true
				testWhileIdle=true
				testOnReturn=true
				validationQuery="SELECT 1"
			 }

        }
    }
	model {
		dataSource {
			pooled = true
			driverClassName = 'com.mysql.jdbc.Driver'
			username = 'cpcaUser'
			password = 'Cpc421686'
			dbCreate = "update"//"create" // one of 'create', 'create-drop','update'
			url = "jdbc:mysql://lwmysqltest/cpca2"
		}
	}

    production {
        dataSource {
			driverClassName = 'com.mysql.jdbc.Driver'
			username = 'cpcaUser'
			password = 'Cpc421686'
            dbCreate = "update"
            url = "jdbc:mysql://lwmysql1/cpca2"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}
