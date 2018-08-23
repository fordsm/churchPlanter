<%@ page import="com.lifeway.cpDomain.Category"%>
<%@ page import="com.lifeway.cpDomain.CategoryGroup"%>
<%@ page import="com.lifeway.utils.CategoryGroupModel"%>
<%@ page import="com.lifeway.utils.CategoryModel"%>

<html id="newWindowHTML">
<head>
<title><g:message
		code="message.churchPlanter.categoryGroupReport.title"
		args="[surveyResponse.survey.getTranslationByLocale()?.name?:'',churchPlanter.firstName + ' ' + churchPlanter.lastName]" /></title>
<meta name="layout" content="main" />
<link rel='stylesheet' href="${resource(dir:'css', file:'umbrellaprint.css') }" media="print"/>
<link rel='stylesheet'
	href="${resource(dir:'css', file:'jquery.fancybox.css') }" />
<style>
a:hover {
	color: black;
	font-weight: normal;
}
</style>
<g:javascript src="amcharts.js" />
<g:javascript src="serial.js" />
<g:javascript src="amexport.js" />
<g:javascript src="canvg.js" />
<g:javascript src="rgbcolor.js" />
<g:javascript src="filesaver.js" />
<g:javascript src="light.js" />
<script type="text/javascript">
		/*
		
					"amExport":{
						"top":0,
						"right":0,
						"exportJPG":true,
						"exportPNG":true
					},
		*/

	
					
		var chart = AmCharts.makeChart("chartdiv",
				{
					"type": "serial",
					"pathToImages": "http://cdn.amcharts.com/lib/3/images/",
					"categoryField": "category",
					"startDuration": 1,
					"fontSize": 13,
					"theme": "light",
					"categoryAxis": {
						"autoRotateAngle": 90,
						"autoRotateCount": 1,
						"autoWrap": true,
						"gridPosition": "start",
						"tickPosition": "start",
						"fontSize": 1,
						"labelFrequency": 1,
						"labelOffset": 1
					},
					"graphs": [
							{
								"balloonText": "[[category]]:[[value]]",
								"colorField": "color",
								"fillAlphas": 1,
								"id": "graph-1",
								"labelPosition": "inside",
								"labelText": "",
								"legendAlpha": 0,
								"showAllValueLabels": true,
								"title": "Umbrella Groups",
								"visibleInLegend":false,
								"type": "column",
								"valueField": "score"
							},
							<g:each in="${categoryGroupModel.allLines}" var="line" status="i">
								{
										"balloonText": "[[title]] of [[category]]:[[value]]",
										"bullet": "round",
										"lineColor":"${line.color}",
										"id": "${line.id}",
										"labelText": "",
										"lineThickness": 2,
										"title": "${line.name}",
										"valueField": "${line.id}",
										"connect":true
								},
							</g:each>
					],
					"guides": [],
					"valueAxes": [
						{
							"id": "ValueAxis-1",
							"autoGridCount": false,
							"fillColor": "#000000",
							"fontSize": 10,
							"labelFrequency": 1,
							"labelRotation": 0,
							"title": "Score",
							"maximum":100,
							"min":0
						}
						
					],
					"categoryAxis":{
					    "gridPosition": "start",
			        	"labelRotation": 90,
			        	"fontSize":10,
			        	"autoGridCount":false,
			        	"gridCount":${categoryGroupModel.categoryModels.size()}
					},
					"allLabels": [],
					"balloon": {},
					"legend": {
						"position": "top",
						"useGraphSettings": true,
						"valueWidth": 49
					},
					"titles": [
						{
							"id": "Title-1",
							"size": 15,
							"text": "Umbrella Categories"
						}
					],
					"startDuration":0,
					"dataProvider": [			
						<g:each in="${categoryGroupModel.categoryModels}" var="categoryModel" status="i">
						{
							"category": "${categoryModel.name}",
							"score": ${categoryModel.score},
							<g:each in="${categoryModel.lineList}" var="line" status="j">
							"${line.line.id}":${line.value},
							</g:each>
							"color": "${categoryModel.color}"
						},
						</g:each>
					]
				}
			);


			function beforePrint(){
				$("#chartdiv").css("width","925px");
				$("#chartdiv").css("height","600px");
				chart.invalidateSize();
			}

			function afterPrint(){
				$("#chartdiv").css("width","650px");
				$("#chartdiv").css("height","400px");
				chart.invalidateSize();
				chart.validateNow();
			}

			var resize = onResized;

			function printMe(){
				chart.addListener("drawn", resize);
				beforePrint();
			}

			function onResized(event){
				chart.removeListener(chart, "drawn", resize);
				setTimeout(function(){
					window.print();
					
					afterPrint();					
					return true;
					},3000);
			}
		</script>
</head>

<body>
	<g:javascript src="jquery.fancybox.js" />
	<script type="text/javascript">
	$(document).ready(function(){
		$("#inline").fancybox({
			'hideOnContentClick': true,
			'autoDimensions':false,
			'autoScale':false,
			'width':900,
			'maxWidth':950,
			'height':300,
			'autoScale':true,
			'beforeShow':function(){
				$("#chartdiv").css("width","950px");
				$("#chartdiv").css("height","800px");
				chart.invalidateSize();
			},
			'afterClose':function(){
				$("#inline").css("display","");
				$("#chartdiv").css("width","650px");
				$("#chartdiv").css("height","400px");
				chart.invalidateSize();
			}
		});
	});
	</script>
	
	<div id="pageBody">
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<a id="inline">
		<div class="dialog">
			<h1>
				<g:message code="message.churchPlanter.umbrellaReport.title"
					args="[surveyResponse.survey.getTranslationByLocale()?.name?:'',churchPlanter.toString()]" />
			</h1>
			<h2>
				<g:message code="message.churchPlanter.umbrellaReport.prepared"
					args="[churchPlanter.organization.name]" />
			</h2>
			<p>
			${surveyResponse.survey.getTranslationByLocale()?.umbrellaOverview?:message(code:"message.churchPlanter.general.noTranslation") }
			</p></div>
				<table style="text-align: left; width: 100%">
					<tr>
						<g:each in="${categoryGroupModel.categoryGroups}"
							var="categoryGroup" status="i">
							<g:if test="${i%3 == 0}">
					</tr>
					<tr>
						</g:if>
						<td style="font-size: 13;vertical-align:center"><div
							style="background-color:${categoryGroup.color};height:20px;width:40px;display:inline-block;margin-right:5px;-webkit-print-color-adjust: exact;"></div>${categoryGroup.name}
						</td>
						</g:each>
					</tr>
				</table>

				<div id="chartdiv"
					style="width: 650px; height: 400px; background-color: #FFFFFF;"></div>

				<g:if test="${categoryGroupModel.followUpQuestions.size() > 0 }">
					<h2 style="text-align:left">Follow Up Questions:</h2>
				</g:if>
				<ul
					style="margin: 0px 0px 0px 10px; list-style-type: circle; padding-bottom: 50px; text-align: left">
					<g:each in="${categoryGroupModel.followUpQuestions}" var="questionModel"
						status="i">

						<li style="font-size: 15">
						 <h3>${questionModel?.key?.name }</h3>
						 <g:each in="${questionModel?.value}" var="question">
							<h4 style="color: #666666; margin: 5px;">
								${question?.title}
							</h4>
							<div style="margin: 5px; margin-right: 20px;">
								${question?.followUpText}
							</div>
						</g:each>
						</li>
					</g:each>
				</ul>
	</a>
	<input id="printButton" type="button" value="print" onclick="printMe();"/>
		</div>
	
</body>
</html>