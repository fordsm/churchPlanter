package com.lifeway.utils

import com.lifeway.cpDomain.*;
import javax.persistence.Transient

class CategoryGroupModel {
    public Set<Line> allLines
	public Set<CategoryGroup> categoryGroups
	public Map<CategoryGroup, Set<Threshold>> followUpQuestions
	
	public List<CategoryModel> categoryModels;
	
	CategoryGroupModel(){
		allLines = new LinkedHashSet<>();
		categoryGroups = new LinkedHashSet<>();
		followUpQuestions = new LinkedHashMap<>();
		categoryModels = new ArrayList<>();
	}

}
