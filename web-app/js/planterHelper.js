$(document).ready(function() {
	if ($(".educationLevel option:selected").val()=="1"){
	    $("#educationInstitutionRow").hide('slow', function() {});
	  }else{
		  $("#educationInstitutionRow").show('slow', function() {});
		}
	if ($(".ethnicity option:selected").val()=="5"){
	    $("#otherEthnicityRow").show('slow', function() {});
	  }else{
		  $("#otherEthnicityRow").hide('slow', function() {});
		}
	});
$(".educationLevel").change(function() {
  if ($(".educationLevel option:selected").val()=="1"){
    $("#educationInstitutionRow").hide('slow', function() {
    	$("input#educationInstitution").val("");
        });
  }else{
	  $("#educationInstitutionRow").show('slow', function() {});
	}
});
$(".ethnicity").change(function() {
	  if ($(".ethnicity option:selected").val()=="5"){
	    $("#otherEthnicityRow").show('slow', function() {});
	  }else{
		  $("#otherEthnicityRow").hide('slow', function() {
			  $("input#otherEthnicity").val("");
			  });
		}
	});