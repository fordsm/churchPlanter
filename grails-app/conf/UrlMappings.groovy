class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"{
		 controller = "home"
		 action = "login"
	  }

		"500"(view:'/error')
	}
}
