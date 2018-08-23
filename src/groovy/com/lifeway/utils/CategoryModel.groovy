package com.lifeway.utils

import java.math.BigDecimal;
import java.util.List;

import com.lifeway.cpDomain.Category;
import com.lifeway.cpDomain.CategoryGroup;
import com.lifeway.cpDomain.CategoryLine;

class CategoryModel{
	Category category
	CategoryGroup categoryGroup
	String color
	String name
	BigDecimal score
	List<CategoryLine> lineList
	
	CategoryModel(){
		color = "#000000"
	}
	CategoryModel(Category category, BigDecimal score){
		this();
		this.category = category
		this.score = score
		lineList = new ArrayList<>()
	}
	
	CategoryModel(CategoryGroup categoryGroup, Category category, String color, BigDecimal score, String name, List<CategoryLine> lineList){
		this(category, score)
		this.color = color
		this.name = name
		this.lineList = lineList
		this.categoryGroup = categoryGroup
	}
}
