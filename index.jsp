<%@ page language="java" pageEncoding="utf-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="fn"
	uri="http://java.sun.com/jsp/jstl/functions"%><!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Open SAR online</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/opensar.png">
		<link
			href="${pageContext.request.contextPath}/assets/css/bootstrap.css"
			rel="stylesheet"/>
		<link
			href="${pageContext.request.contextPath}/assets/css/bootstrap-responsive.css"
			rel="stylesheet"/>
		<link
			href="${pageContext.request.contextPath}/assets/css/docs.css"
			rel="stylesheet"/>
		<link
			href="${pageContext.request.contextPath}/assets/js/google-code-prettify/prettify.css"
			rel="stylesheet"/>
		<!--[if lt IE 9]>
	      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	    <![endif]-->
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/js/Leaflet-0.6-pre/dist/leaflet.css" />
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/js/Leaflet.draw-0.3-pre/dist/leaflet.draw.css" />
		<!--[if lte IE 8]>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/js/Leaflet-0.6-pre/dist/leaflet.ie.css" />
		<![endif]-->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/js/Leaflet-0.6-pre/debug/css/screen.css" />
		<script
			src="${pageContext.request.contextPath}/js/Leaflet-0.6-pre/build/deps.js"></script>
		<script
			src="${pageContext.request.contextPath}/js/Leaflet-0.6-pre/debug/leaflet-include.js"></script>
		<script
			src="${pageContext.request.contextPath}/js/Leaflet.draw-0.3-pre/dist/leaflet.draw-src.js"></script>
		<script src="${pageContext.request.contextPath}/jslocales.do"></script>
		<script src="${pageContext.request.contextPath}/js/ajax.js"></script>
		<script src="${pageContext.request.contextPath}/js/index.js"></script>
		<script src="${pageContext.request.contextPath}/js/higismap.js"></script>
		<script src="${pageContext.request.contextPath}/js/flows.js"></script>
		<script src="${pageContext.request.contextPath}/js/app.js"></script>
		<script src="${pageContext.request.contextPath}/js/map-interaction.js"></script>
		<script src="${pageContext.request.contextPath}/js/data.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/jquery.js"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
		<script src="${pageContext.request.contextPath}/js/highcharts.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/google-code-prettify/prettify.js"></script>
		<script type="text/javascript">
	var userlogin = ${user!=null};
	var contextPath = "${pageContext.request.contextPath}";
	var earthdatauri = "${configmap['earthdatauri'].value}";
	var hilestacheuri = "${configmap['hilestache'].value}";
	var dataServiceUrl = "${configmap['dataserviceurl'].value}";
	var higis_data_path = "${configmap['data_path'].value}";
	var userName = "${user.email}";
	function funjslocales() {
		var str = arguments[0];
		for ( var i = 1, len = arguments.length; i < len; i++) {
			str = str.replace("{" + (i - 1) + "}", arguments[i]);
		}
		return str;
	}
</script>
	</head>

	<body onload="pageini()">
		<div id="div_Login" class="modal hide fade" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					×
				</button>
				<h3>
					${locales.logintitle}
				</h3>
			</div>
			<div class="modal-body" style="min-height: 200px;">
				<form class="form-signin" id="form-login"
					onsubmit="check_login();return false;">
					<input type="text" id="user_email" name="user_email"
						class="input-block-level" placeholder="${locales.emailAddress}">
					<input type="password" id="user_password" name="user_password"
						class="input-block-level" placeholder="${locales.password}">
					<label class="checkbox">
						<input type="checkbox" name="remember_me" value="true">
						${locales.rememberMe}
					</label>
					<button class="btn btn-large btn-primary" type="submit">
						${locales.signIn}
					</button>
					<span id="login_message"
						style="color: red; vertical-align: bottom;"></span>
					<div style="margin-top: 10px;">
						<a href="javascript:void(0)" onclick="check_SignUp()">${locales.signUp}</a>
						<a style="margin-left: 20px;" href="javascript:void(0)">${locales.forgotPassword}</a>
					</div>
				</form>
			</div>
		</div>
		<div id="div_regedit" class="modal hide fade" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					×
				</button>
				<h3>
					${locales.signUp}
				</h3>
			</div>
			<div class="modal-body" style="min-height: 200px;">
				<form id="signUpForm" onSubmit="check_SignUpSubmit();return false;"
					method="post">
					<div>
						<input id="r_user_email" name="r_user_email" size="30" type="text"
							class="input-block-level" value="" onchange="check_SignUpName()"
							placeholder="${locales.signUpuserName}" />
					</div>
					<div>
						<input id="r_user_password" name="r_user_password" size="30"
							class="input-block-level" type="password"
							placeholder="${locales.userPwd}" />
					</div>
					<div>
						<input id="r_user_password_confirmation" class="input-block-level"
							name="r_user_password_confirmation" size="30" type="password"
							placeholder="${locales.userPwd2}" />
					</div>
					<div>
						<input id="sign_in" class="btn btn-large btn-primary"
							type="submit" value="${locales.submit}" />
						<span id="signUpMessage"
							style="color: red;vertical-align: bottom;"></span>
					</div>
				</form>
			</div>
		</div>
		<div id="div_App" class="modal hide fade" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<form id="form_app" name="form_app" action="run.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">
						×
					</button>
					<h3 id="app_title"></h3>
				</div>
				<div class="modal-body" style="min-height: 480px;">
					<div id="div_App_data" class="modal-body appleft"
						onclick="check_showhelp('app.help')"></div>
					<div class="modal-body appright">
						<label style="font-size: 20px;">
							<strong id="helptitle">${locales.help}</strong>
						</label>
						<div id="helpcontent">
							${locales.helpContent}
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" style="float: left;"
						onclick="check_submitapp()" id="check_submitapp_id">
						${locales.submit}
					</button>
					<button type="button" class="btn" data-dismiss="modal"
						style="float: left; margin-left: 10px;" aria-hidden="true">
						${locales.cancel}
					</button>
					<span
						style="color: red; float: left; margin-top: 10px; margin-left: 20px;"
						id="appmessage"></span>
				</div>
			</form>
		</div>
		<div id="div_AddLayer" class="modal hide fade" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					×
				</button>
				<h3>
					${locales.selectData}
					<div class="input-append" style="float: right; margin-right: 30px;">
						<input id="datatype" name="datatype" type="hidden" value="" />
						<input class="span2" type="text" id="t_search"
							placeholder="${locales.dataName}" onkeydown="check_inputSearch()"/>
						<button class="btn" type="button" onclick="check_search()">
							${locales.search}
						</button>
						<button class="btn" type="button">
							${locales.advanced}
						</button>
					</div>
					<div class="btn-group" data-toggle="buttons-radio"
						style="float: right; margin-right: 10px;">
						<button type="button" id="public_but"
							onclick="check_mydata(false)" class="btn">
							${locales.publicData}
						</button>
						<button type="button" id="my_but" onclick="check_mydata(true)"
							class="btn">
							${locales.myData}
						</button>
					</div>
				</h3>
			</div>
			<div id="div_AddLayer_data" class="modal-body"
				style="min-height: 480px;"></div>
			<div class="modal-footer">
				<div id="div_AddLayer_page"
					style="float: left; font-size: 13px; margin-left: 20px;">
					<a href="javascript:void(0);" onclick="check_first()">${locales.first}</a>&nbsp;
					<a href="javascript:void(0);" onclick="check_up()">${locales.up}</a>&nbsp;
					<span id="showPageNum"></span> &nbsp;
					<a href="javascript:void(0);" onclick="check_down()">${locales.down}</a>&nbsp;
					<a href="javascript:void(0);" onclick="check_last()">${locales.last}
					</a>&nbsp; ${fn:split(locales.page,"{0}")[0]}
					<input type="text" id="pageNum"
						style="width: 24px; height: 10px; margin-top: 6px; line-height: 10px;"
						onkeydown="check_inputPage(this.value)" />
					${fn:split(locales.page,"{0}")[1]} &nbsp;
					<span id="allPageNum"></span>
					<span style="margin-left: 20px; display: none;"></span>
				</div>
				<button type="button" class="btn btn-primary"
					onclick="check_AddLayer()">
					${locales.confirm}
				</button>
				<button type="button" class="btn" data-dismiss="modal"
					aria-hidden="true">
					${locales.close}
				</button>
			</div>
		</div>
		<div id="div_uploaddata" class="modal hide fade" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					×
				</button>
				<h3>
					${locales.uploadData}
				</h3>
			</div>
			<div class="modal-body" style="min-height: 200px;">
				<form class="form-signin" id="form-uploaddata"
					enctype="multipart/form-data">
					<table>
						<tr>
							<td>
								${locales.dataType}：
							</td>
							<td>
								<select id="upload_type" name="upload_type"
									style="width: 100px;"
									onchange="onchange_upload_type(this.value)">
									<option value="3">
										${locales.feature}
									</option>
									<option value="4">
										${locales.raster}
									</option>
								</select>
								<span id="upload_type_3" style="margin-left: 10px;">
									${locales.encoding}：<input id="upload_encod"
										style="width: 100px;" name="encoding" type="text" /> </span>
							</td>
						</tr>
						<tr>
							<td>
								<input id="upload_User" name="user" type="hidden" />
							</td>
						</tr>
						<tr>
							<td>
								${locales.file}：
							</td>
							<td>
								<input id="uploadOther" name="data" type="file"
									class="btn" multiple="multiple" onchange="check_changeFile()" />
								${locales.multiSelection}
							</td>
						</tr>
						<tr>
							<td></td>							
							<td>
							<label class="checkbox" style="display: none;">
							<input id="reg_carto" name="reg_carto" value="true" type="checkbox" checked="checked">${locales.registerCartography}
							</label>
							</td>							
						</tr>
						<tr>
							<td>
								${locales.name}：
							</td>
							<td>
								<input id="upload_Name" name="name" class="span3" type="text" style="width:285px;"/>
							</td>
						</tr>
						<tr id="upload_raster_tr" style="display: none;">
							<td>
								${locales.format}：
							</td>
							<td>
								<select name="format" style="width: 150px;">
								<option value="GTIFF">GTIFF</option>
								<option value="TSX">TSX</option>
								<option value="COSAR">COSAR</option>
								</select>
							</td>
						</tr>
						<tr id="upload_feature_tr" style="display: none;">
							<td>
								${locales.format}：
							</td>
							<td>
								<select name="format" style="width: 150px;">
								<option value="ESRI Shapefile">ESRI Shapefile</option>
								</select>
							</td>
						</tr>
						<tr style="display: none;">
							<td>
								${locales.organisation}：
							</td>
							<td>
								<input id="upload_Organisation" name="organisation" class="span3" type="text" style="width:285px;"/>
							</td>
						</tr>
						<tr style="display: none;">
							<td>
								${locales.uploaddescription}：
							</td>
							<td>
								<input id="upload_Description" name="description" class="span3" type="text" style="width:285px;"/>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input style="margin-top: 10px;" type="button" onclick="check_uploaddata()" class="btn"
									value="${locales.upload}" />
								<span id="upload_message"
									style="color: red; vertical-align: bottom; margin-left: 10px;"></span>
									<progress id="upload_progress" style="display: none;"></progress>
							</td>
							</tr>							
							<tr>
							<td></td>
							<td><label style="color: red; margin-top: 20px;">
								${locales.uploadMessage}
							</label></td>							
						</tr>
					</table>
			</form>
			</div>
		</div>
		<div id="graph_updateName" class="modal hide fade" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					×
				</button>
				<h3>
					${locales.contentUpdate}
				</h3>
			</div>
			<div class="modal-body" style="min-height: 200px;">
				<input id="graph_updateName_id" type="text" class="span3" />
				<br />
				<input type="button" class="btn" onclick="graph_updateNameConfirm()"
					value="${locales.confirm}" />
				<input type="button" class="btn" data-dismiss="modal"
					aria-hidden="true" value="${locales.cancel}" />
				<span id="graph_updateName_message" style="color: red"></span>
			</div>
		</div>
		<div class="navbar navbar-inverse navbar-fixed-top">						
			<div class="navbar-inner">				
				<div class="container-fluid">
					<a class="brand" href="javascript:void(0);">Open SAR</a>					
					<div class="nav-collapse collapse">
						<p class="navbar-text pull-right" id="logo"
							style="min-width: 160px; text-align: right;">
							<img id="opensar_img"
									src= "${pageContext.request.contextPath}/images/opensar.png"
									style="width: 32px; height: 32px;">
						</p>							
						<p class="navbar-text pull-right" id="user-info"
							style="min-width: 160px; text-align: right;">
							<c:if test="${user!=null}">
							${locales.welcome}: ${user.name} | 
							<a href="javascript:void(0);" onclick="check_out()"
									class="navbar-link">${locales.signOut}</a>
							</c:if>
							<c:if test="${user==null}">
							${locales.logged}
							<a href="javascript:void(0);" onclick="check_LoginShow()"
									class="navbar-link">${locales.userName}</a>
							</c:if>
						</p>
						<p class="navbar-text" style="margin-right: 50px; float: right;">
							<c:forEach var="info" items="${localeinfos}" varStatus="info_num">
								<c:if test="${info_num.first}">[ </c:if>
								<c:if test="${!info_num.first}">|</c:if>
								<c:if test="${info.filename==defaultlocale}">
									<a href="javascript:void(0);" class="navbar-link"
										style="color: white;"
										onclick="check_locales('${info.filename}',this)">
										${info.name} </a>
								</c:if>
								<c:if test="${info.filename!=defaultlocale}">
									<a href="javascript:void(0);" class="navbar-link" style=""
										onclick="check_locales('${info.filename}',this)">
										${info.name} </a>
								</c:if>
							</c:forEach>
							]
						</p>
						<ul class="nav" id="tabtitle">
							<li id="tab_0" class="" style="display: none;">
								<a href="#Home" onclick="check_TabShow(0)">${locales.home}</a>
							</li>
							<li id="tab_1" class="">
								<a href="#Map" onclick="check_TabShow(1)">${locales.map}</a>
							</li>
							<li id="tab_2" class="">
								<a href="#App" id="a_App" onclick="check_TabShow(2)">${locales.app}</a>
							</li>
							<li id="tab_3" class="">
								<a href="#Data" id="a_Data" onclick="check_TabShow(3)">${locales.data}</a>
							</li>
							<li id="tab_4" class="">
								<a href="#Console" onclick="check_TabShow(4)">${locales.console}<sup
										id="submit_num" class="badge badge-important"
										style="padding-left: 4px; padding-right: 4px; display: none;">
										0
									</sup> </a>
							</li>
							<li id="tab_5" class="">
								<a href="#Flow" onclick="check_TabShow(5)">${locales.flow}</a>
							</li>
							<li id="tab_6" class="">
								<a href="#Development" onclick="check_TabShow(6)">${locales.development}</a>
							</li>
							<li id="tab_7" class="">
								<a href="#About" onclick="check_TabShow(7)">${locales.about}</a>
							</li>
					   <!-- <li id="tab_8" class="">
								<a href="#Algorithm" onclick="check_TabShow(8)">${locales.algorithm}</a>-->
							</li>
						</ul>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
		<div id="tab0" class="mytab hide">
			Home
		</div>
		<div id="tab1" class="mytab">
			<div id="div_layers" style="height: 100%;">
				<div class="well sidebar-nav" style="min-height: 90%;">
					<ul class="nav nav-list">
						<li class="nav-header">
							<a href="javascript:void(0);"><i class="icon-book"></i>
								${locales.operate}</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="check_AddLayerShow();"
								style="margin-left: 2px;"><i class="icon-plus"></i>
								${locales.addLayer}</a>
						</li>
						<li class="nav-header">
							<a href="javascript:void(0);"><i class="icon-book"></i>
								${locales.layer}<span onclick="check_ClearLayers();"
								style="float: right; font-weight: normal;">${locales.clearAllLayers}</span>
							</a>
						</li>
						<li class="active">
							<form id="form_layers">
								<ul id="layers" class="nav nav-list">
								</ul>
							</form>
						</li>
					</ul>
				</div>
				<!--/.well -->
			</div>
			<div id="map" class="div_right"></div>
			<div id="propertyDiv"
				style="display: none; height: 28%; overflow-y: auto;"></div>
			<div id="propertyPageDiv" style="display: none; margin-right: 4%;"></div>
		</div>
		<div id="tab2" class="mytab hide"
			style="padding-left: 10px; padding-right: 10px;">
			<table style="width: 100%; height: 100%;">
				<tr>
					<td valign="top" rowspan="2"
						style="width: 160px; border: 1px solid #CCC; padding: 0; background-color: #EEEEEE;">
						<a href="#App" id="div_myApp_a" onclick="check_apptagtitle(0)"
							style="text-decoration: none;" onmouseover="check_aappover(0)"
							onmouseout="check_aappout(0)">
							<div id="div_myApp"
								style="height: 160px; text-align: center; padding-top: 10px;">
								<img id="div_myApp_img"
									src="${pageContext.request.contextPath}/images/my-algo.png"
									style="width: 100px; height: 100px;">
								<h4>
									${locales.myApp}
								</h4>
							</div> </a>
						<div
							style="height: 0px; background-color: #999999; margin-left: 30px; margin-right: 30px;"></div>
						<img id="id_app_tag_img" ischecked="0"
							style="position: absolute; top: 132px; left: 147px;"
							src="${pageContext.request.contextPath}/images/select.png">
						<a href="#App1" onclick="check_apptagtitle(1)"
							style="text-decoration: none;" onmouseover="check_aappover(1)"
							onmouseout="check_aappout(1)">
							<div id="div_publicApp"
								style="height: 160px; text-align: center; padding-top: 10px;">
								<img id="div_publicApp_img"
									src="${pageContext.request.contextPath}/images/all-algo.png"
									style="width: 100px; height: 100px;">
								<h4>
									${locales.publicApp}
								</h4>
							</div> </a>
					</td>
					<td name="" valign="top"
						style="border: 1px solid #CCC; border-bottom: 0px;">
						<div style="height: 46px; line-height: 40px;">
							<div
								style="float: left; margin: 0; padding: 0; margin-left: 10px; margin-top: 5px;"
								class="input-append">
								<input class="span3" type="text" id="t_search_app"
									placeholder="${locales.appName}"
									onkeydown="check_appinputSearch()">
								<button class="btn" type="button" onclick="check_appsearch()">
									${locales.search}
								</button>
								<button class="btn" type="button" id="uploadAppBtn">
									${locales.upload}
								</button>
							</div>
						</div>
						<div id="apptable" style="margin-left: 30px;"></div>
					</td>
					<td valign="top" rowspan="2"
						style="width: 380px; border: 1px solid #CCC;">
						<div style="height: 500px; padding: 10px;">
							<label style="font-size: 20px;">
								<strong id="apptabletitle">${locales.content}</strong>
							</label>
							<div id="apptableinfo"></div>
						</div>
						<div style="border-top: 1px solid #CCC; padding-left: 20px;">
							<h4 style="margin: 0;">
								${locales.tag}
							</h4>
						</div>
						<div style="padding: 10px; padding-top: 0;" id="div_app_tags"></div>
					</td>
				</tr>

				<tr>
					<td valign="top" style="border-bottom: 1px solid #CCC;">
						<div style="margin-right: 10px; margin-left: 20px;">
							<a href="javascript:void(0);" onclick="check_appfirst()">${locales.first}</a>&nbsp;
							<a href="javascript:void(0);" onclick="check_appup()">${locales.up}
							</a>&nbsp;
							<span id="appshowPageNum"></span> &nbsp;
							<a href="javascript:void(0);" onclick="check_appdown()">${locales.down}
							</a>&nbsp;
							<a href="javascript:void(0);" onclick="check_applast()">${locales.last}
							</a>&nbsp; ${fn:split(locales.page,"{0}")[0]}
							<input type="text" id="apppageNum"
								style="width: 24px; height: 10px; margin-top: 6px; line-height: 10px;"
								onkeydown="check_appinputPage(this.value)" />
							${fn:split(locales.page,"{0}")[1]} &nbsp;
							<span id="appallPageNum">${fn:replace(locales.infoNum,"{0}","0")}</span>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="tab3" class="mytab hide"
			style="padding-left: 10px; padding-right: 10px;">
			<table style="width: 100%; height: 100%;">
				<tr>
					<td valign="top" rowspan="2"
						style="width: 160px; border: 1px solid #CCC; padding: 0; background-color: #EEEEEE;">
						<a href="#Data" id="div_myData_a" onclick="check_datatagtitle(0)"
							style="text-decoration: none;" onmouseover="check_adataover(0)"
							onmouseout="check_adataout(0)">
							<div id="div_myData"
								style="height: 160px; text-align: center; padding-top: 10px;">
								<img id="div_myData_img"
									src="${pageContext.request.contextPath}/images/my-algo.png"
									style="width: 100px; height: 100px;">
								<h4>
									${locales.myData}
								</h4>
							</div> </a>
						<img id="id_data_tag_img" ischecked="0"
							style="position: absolute; top: 132px; left: 147px;"
							src="${pageContext.request.contextPath}/images/select.png">
						<a href="#Data1" onclick="check_datatagtitle(1)"
							style="text-decoration: none;" onmouseover="check_adataover(1)"
							onmouseout="check_adataout(1)">
							<div id="div_publicData"
								style="height: 160px; text-align: center; padding-top: 10px;">
								<img id="div_publicData_img"
									src="${pageContext.request.contextPath}/images/all-algo.png"
									style="width: 100px; height: 100px;">
								<h4>
									${locales.publicData}
								</h4>
							</div> </a>
					</td>
					<td valign="top"
						style="border: 1px solid #CCC; border-bottom: 0px;">
						<div style="height: 46px; line-height: 40px;">
							<div
								style="float: left; margin: 0; padding: 0; margin-left: 20px; margin-top: 5px;"
								class="input-append">
								<input class="span3" type="text" id="t_search_data"
									placeholder="${locales.dataName}"
									onkeydown="check_datainputSearch()">
								<button class="btn" type="button" onclick="check_datasearch()">
									${locales.search}
								</button>
								<button class="btn" type="button"
									onclick="check_uploaddataShow()">
									${locales.upload}
								</button>
							</div>
						</div>
						<div id="datatable" style="margin-left: 30px;"></div>
					</td>
					<td valign="top" rowspan="2"
						style="width: 380px; border: 1px solid #CCC;">
						<div id="layerpropertydiv"
							style="min-height: 400px; padding: 10px;">
							<label style="font-size: 20px;" onclick="check_dataname()">
								<strong id="datatabletitle">${locales.content}</strong>
							</label>
							<input id="dataname" type="text" name="dataname"
								style="display: none" />
							<table id="propertytable" class="table table-hover">
							</table>
							<button id="save"
								style="margin-left: 70%; margin-bottom: 5px; display: none;"
								class="btn btn-mini" onclick="check_save()">
								${locales.save}
							</button>
							<button id="cancel"
								style="margin-left: 10px; margin-bottom: 5px; display: none;"
								class="btn btn-mini" onclick="check_cancel()">
								${locales.cancel}
							</button>
						</div>
						<div style="border-top: 1px solid #CCC; padding-left: 20px;">
							<h4 style="margin: 0;">
								${locales.tag}
							</h4>
						</div>
						<div style="padding: 10px; padding-top: 0;" id="div_data_tags"></div>
					</td>
				</tr>
				<tr>
					<td valign="top" style="border-bottom: 1px solid #CCC;">
						<div style="margin-right: 10px; margin-left: 20px;">
							<a href="javascript:void(0);" onclick="check_datafirst()">${locales.first}</a>&nbsp;
							<a href="javascript:void(0);" onclick="check_dataup()">${locales.up}
							</a>&nbsp;
							<span id="datashowPageNum"></span> &nbsp;
							<a href="javascript:void(0);" onclick="check_datadown()">${locales.down}
							</a>&nbsp;
							<a href="javascript:void(0);" onclick="check_datalast()">${locales.last}
							</a>&nbsp; ${fn:split(locales.page,"{0}")[0]}
							<input type="text" id="datapageNum"
								style="width: 24px; height: 10px; margin-top: 6px; line-height: 10px;"
								onkeydown="check_datainputPage(this.value)" />
							${fn:split(locales.page,"{0}")[1]} &nbsp;
							<span id="dataallPageNum">${fn:replace(locales.infoNum,"{0}","0")}</span>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="tab4" class="mytab hide" style="padding-left: 10px;">
			<div class="div_right" style="overflow: hidden;">
				<table style="width: 100%; height: 100%;">
					<tr>
						<td valign="top"
							style="width: 500px; height: 100%; border-right: 1px solid #CCC;">
							<div
								style="float: left; margin: 0; padding: 0; margin-left: 20px; margin-top: 5px;">
								<h4 style="margin: 0; margin-bottom: 10px;">
									${locales.flows}
								</h4>
							</div>
							<table class="table table-hover flowtable"
								style="margin-bottom: 0;">
								<tr>
									<th style="width: 200px;">
										<span style="margin-left: 46px;">${locales.name}</span>
									</th>
									<th style="width: 100px;">
										${locales.startTime}
									</th>
									<th style="width: 50px;">
										${locales.status}
									</th>
								</tr>
							</table>
							<div
								style="width: 100%; padding: 0; height: 85%; overflow-y: auto;">
								<table id="flowtable" class="table table-hover flowtable"></table>
								<div
									style="font-size: 13px; margin-left: 20px; margin-top: -10px;">
									<a href="javascript:void(0);" onclick="check_flowsfirst()">${locales.first}</a>&nbsp;
									<a href="javascript:void(0);" onclick="check_flowsup()">${locales.up}
									</a>&nbsp;
									<span id="flowsshowPageNum"></span> &nbsp;
									<a href="javascript:void(0);" onclick="check_flowsdown()">${locales.down}
									</a>&nbsp;
									<a href="javascript:void(0);" onclick="check_flowslast()">${locales.last}
									</a>&nbsp; ${fn:split(locales.page,"{0}")[0]}
									<input type="text" id="flowspageNum"
										style="width: 24px; height: 10px; margin-top: 6px; line-height: 10px;"
										onkeydown="check_flowsinputPage(this.value)" />
									${fn:split(locales.page,"{0}")[1]} &nbsp;
									<span id="flowsallPageNum">${fn:replace(locales.infoNum,"{0}","0")}</span>
								</div>
							</div>
						</td>
						<td valign="top"
							style="height: 100%; margin-top: 10px; font-size: 14px;">
							<fieldset class="appfieldset"
								style="margin-left: 10px; margin-right: 8px;">
								<legend class="applegend" style="font-weight: bolder;">
									${locales.jobInfo}
								</legend>
								<div style="padding-left: 10px;">
									<table>
										<tr style="height: 40px;">
											<td style="width: 80px;">
												${locales.name}：
											</td>
											<td id="td_jobname" style="width: 300px;"></td>
											<td style="margin-left: auto; margin-right: 10px;"></td>
											<td rowspan="6" valign="top" style="width: 600px;">
												<div id="container"
													style="min-width: 300px; height: 300px; margin: 0 auto; margin-top: -10px;">
												</div>
											</td>
										</tr>
										<tr style="height: 40px;">
											<td>
												${locales.status}：
											</td>
											<td id="td_jobstatus"></td>
											<td></td>
										</tr>
										<tr style="height: 40px;">
											<td>
												${locales.ioTime}：
											</td>
											<td>
												<div class="progress progress-danger"
													style="margin-bottom: 0;">
													<div id="td_jobionum" class="bar" style="width: 0"></div>
												</div>
											</td>
											<td id="td_jobio"
												style="padding-left: 10px; font-size: 16px; color: #A6332D"></td>
										</tr>
										<tr style="height: 40px;">
											<td>
												${locales.computingTime}：
											</td>
											<td>
												<div class="progress progress-success"
													style="margin-bottom: 0;">
													<div id="td_jobcomputingnum" class="bar" style="width: 0"></div>
												</div>
											</td>
											<td id="td_jobcomputing"
												style="padding-left: 10px; font-size: 16px; color: #499049"></td>
										</tr>
										<tr style="height: 40px;">
											<td>
												${locales.totalTime}：
											</td>
											<td>
												<div class="progress progress-info"
													style="margin-bottom: 0;">
													<div id="td_jobtotalnum" class="bar" style="width: 0"></div>
												</div>
											</td>
											<td id="td_jobtotal"
												style="padding-left: 10px; font-size: 16px; color: #2C849D"></td>
										</tr>
									</table>
								</div>
							</fieldset>
							<fieldset class="appfieldset"
								style="margin-top: 10px; margin-right: 8px; margin-left: 10px; max-height: 620px;">
								<legend class="applegend" style="font-weight: bolder;">
									${locales.jobResult}
								</legend>
								<div id="jobresult"
									style="padding-top: 10px; word-break: break-all; word-wrap: break-word; overflow-y: auto; height: 250px;"></div>
 								 <div id="showchart"
                                                                        style="padding:10px,0,0,30px;height: 150px;">
									<script language="JavaScript1.2" type="text/JavaScript1.2">
										var popUpWin=0;
										function popUpWindow()
											{
												//判断该窗口(popUpWin)是否已经存在，如果已经存在，则先关闭窗口，然后再打开新窗口
												if(popUpWin)
													{
													if(!popUpWin.closed) popUpWin.close();
													}
														//根据参数定位弹出窗口的展示位置
									popUpWin = window.open('showchart.html','','width=600,height=500,Scrollbar=no,titlebar=no,menubar=no');
											}
									</script>
									<!--	<input type="button" value="显示评估曲线" onClick="javascript:popUpWindow();">-->
							</fieldset>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="tab5" class="mytab hide" style="margin-left: 10px;">
			<div id="graphContainer"
				style="overflow:auto;position:relative;width:100%;height:90%;background:url('${pageContext.request.contextPath}/images/grid.gif');cursor:default;">
			</div>
			<div id="outlineContainer"
				style="width: 160px; height: 120px; background: white; border-style: solid; border-color: lightgray;">
			</div>
			<button id="graph_ZoomActual" title="${locales.zoomActual}"
				class="btn">
				<i class="icon-fullscreen"></i>
			</button>
			<button id="graph_ZoomIn" title="${locales.zoomIn}" class="btn">
				<i class="icon-zoom-in"></i>
			</button>
			<button id="graph_ZoomOut" title="${locales.zoomOut}" class="btn">
				<i class="icon-zoom-out"></i>
			</button>
			<button id="graph_Undo" title="${locales.undo}" class="btn">
				<img src="${pageContext.request.contextPath}/images/undo.png" />
			</button>
			<button id="graph_Redo" title="${locales.redo}" class="btn">
				<img src="${pageContext.request.contextPath}/images/redo.png" />
			</button>
			<button id="graph_SelectAll" class="btn" title="${locales.selectAll}">
				<img src="${pageContext.request.contextPath}/images/selectall.png" />
			</button>
			<button id="graph_Delete" class="btn" title="${locales.delete}">
				<img src="${pageContext.request.contextPath}/images/delete.png" />
			</button>
			<button id="graph_DeleteAll" class="btn" title="${locales.clear}">
				<img src="${pageContext.request.contextPath}/images/clear.png" />
			</button>
			<button id="graph_Hierarchical" title="${locales.hierarchical}"
				class="btn">
				<i class="icon-tasks"></i>
			</button>
			<button id="graph_Organic" title="${locales.organic}" class="btn">
				<i class="icon-random"></i>
			</button>
			<input id="graph_FlowName" style="margin-top: 8px;" class="span2"
				type="text" placeholder="${locales.flowName}"
				value="${locales.defaultFlowName}" />
			<button id="graph_SaveFlow" class="btn">
				<img src="${pageContext.request.contextPath}/images/save.png" />
				${locales.saveFlow}
			</button>
			<button id="graph_Run" class="btn">
				<i class="icon-play"></i> ${locales.run}
			</button>
			<span id="graph_RunMessage" style="color: red;"></span>
			<input id="graph_Map" class="btn"
				style="float: right; margin-right: 40px;" type="button"
				value="${locales.graphMap}" />
			<input id="graph_MyData" class="btn"
				style="float: right; margin-right: 10px;" type="button"
				value="${locales.myData}" />
			<input id="graph_MyApp" class="btn"
				style="float: right; margin-right: 10px;" type="button"
				value="${locales.myApp}" />
			<label style="float: right; margin-right: 10px; line-height: 40px;">
				${locales.tools}
			</label>
			<div style="display: none;">
				<form id="jobsSubmitForm" method="post" onsubmit="return false;">
					<textarea id="jobsTextarea" name="jobsTextarea"
						style="display: none;" rows="0" cols="0"></textarea>
					<textarea id="flowsxml" name="flowsxml" style="display: none;"
						rows="0" cols="0"></textarea>
					<input id="flowsname" name="flowsname" type="text">
				</form>
				<div id="graphData">
					<table>
						<tr>
							<td style="padding-left: 18px;">
								<input class="span2" type="text" id="graph_t_search_data"
									style="float: left;" placeholder="${locales.dataName}"
									onkeydown="graph_datainputSearch()">
								<button class="btn" type="button"
									style="float: left; margin-left: 10px; margin-top: -3px;"
									onclick="graph_datasearch()">
									${locales.search}
								</button>
							</td>
						</tr>
						<tr>
							<td id="graphDataDiv"></td>
						</tr>
						<tr>
							<td>
								<a href="javascript:void(0);" onclick="graph_datafirst()">${locales.first}</a>&nbsp;
								<a href="javascript:void(0);" onclick="graph_dataup()">${locales.up}
								</a>&nbsp;
								<span id="graphdatashowPageNum"></span> &nbsp;
								<a href="javascript:void(0);" onclick="graph_datadown()">${locales.down}
								</a>&nbsp;
								<a href="javascript:void(0);" onclick="graph_datalast()">${locales.last}
								</a>&nbsp; ${fn:split(locales.page,"{0}")[0]}
								<input type="text" id="graphdatapageNum"
									style="width: 24px; height: 14px; margin-top: 6px; line-height: 10px;"
									onkeydown="graph_datainputPage(this.value)" />
								${fn:split(locales.page,"{0}")[1]} &nbsp;
								<span id="graphdataallPageNum">${fn:replace(locales.infoNum,"{0}","0")}</span>
								<span id="textWidth" style="font-size: 14px;"></span>
							</td>
						</tr>
					</table>
				</div>
				<div id="graphApp">
					<table>
						<tr>
							<td style="padding-left: 18px;">
								<input class="span2" type="text" id="graph_t_search_app"
									style="float: left;" placeholder="${locales.appName}"
									onkeydown="graph_appinputSearch()">
								<button class="btn" type="button"
									style="float: left; margin-left: 10px; margin-top: -3px;"
									onclick="graph_appsearch()">
									${locales.search}
								</button>
							</td>
						</tr>
						<tr>
							<td id="graphAppDiv"></td>
						</tr>
						<tr>
							<td>
								<a href="javascript:void(0);" onclick="graph_appfirst()">${locales.first}</a>&nbsp;
								<a href="javascript:void(0);" onclick="graph_appup()">${locales.up}
								</a>&nbsp;
								<span id="graphappshowPageNum"></span> &nbsp;
								<a href="javascript:void(0);" onclick="graph_appdown()">${locales.down}
								</a>&nbsp;
								<a href="javascript:void(0);" onclick="graph_applast()">${locales.last}
								</a>&nbsp; ${fn:split(locales.page,"{0}")[0]}
								<input type="text" id="graphapppageNum"
									style="width: 24px; height: 14px; margin-top: 6px; line-height: 10px;"
									onkeydown="graph_appinputPage(this.value)" />
								${fn:split(locales.page,"{0}")[1]} &nbsp;
								<span id="graphappallPageNum">${fn:replace(locales.infoNum,"{0}","0")}</span>
								<span id="textWidth"></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div id="tab6" class="mytab hide" style="margin-left: 10px;">
			<jsp:include page="onlineapi.jsp" />
		</div>

		<div id="tab7" class="mytab hide" style="margin-left: 10px; background-color:rgb(210,210,210);">

<div id="left" style="float: left;
    width:20%;
    height:1500%;
    background-color: white;border-right:2px solid #e9e9e9;">
    <div id="table" style="position: relative;
         left: 16px;top: 3px;">
       <table>
        <tr>
         <td bgcolor="#f5f5f5">
          <p><b>联系我们</b></p>
             <font size="2" face="arial" color="DimGray">	
                  地址:</br>上海交通大学(东川路800号)<br/>微电子楼301室<br/>
	         </font>
	     <p>
            <font size="2" face="arial" color="DimGray">
	          电话：</br>(+86)021-34207443<br/>
                  E-mail:opensar(at)sjtu.edu.cn<br/></font>
	     </p>
	   </td>
     </tr>
    </table>
  </div>
<div style="position:relative;left:0px;top:3px;">
    <img src="${pageContext.request.contextPath}/images/ISNLogo.gif"
                                   title="上海交大感知与导航所" width="200px" height="200px"/>
</div>
</div>
<div id="right" style="float: right;
    width:20%;
    height:1500%;
    background-color: white;">
</div>
<div id="middle" style="background-color:rgb(255,255,255);padding: 0px 160px 5px 160px;
         margin: 0px;height:auto">
    <div style="position: relative;left: 80px;top: 3px;right:50px">
	<h2>关于Open SAR:</h2>
	   <p>OpenSAR是一个SAR图像目标认知解译技术测试评估与合作交流平台，基于<a href="http://higis.me">HiGIS</a>平台开发。OpenSAR通过开放共享方式为用户提供SAR图像解译研究所需的测试样本数据，
	                       并可对用户提交的SAR图像解译算法进行测试和评估。</p>
	   <p>OpenSAR具有如下功能</p>
		  <ul>
			  <li>提供带真值标注的测试数据</li>
			  <li>评估测试数据的质量</li>
			  <li>提供基本算法/软件组件</li>
			  <li>提供基础测试流程</li>
			  <li>提供效能评估流程</li>
			  <li>评价技术成熟度</li>
			  <li>数据浏览、检索、上传、下载、注册</li>
		 </ul>
  </div>
<div style="position: relative;left: 80px;top: 50px;right:50px">
     <h2>使用说明</h2>
	<img src="${pageContext.request.contextPath}/images/userguide/userGuide1.png" width=50%  title="首页"/>
	
	<h3>一、登陆</h3>
<h5>1·点击登陆（或注册新用户）</h5>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide2.png" width=50% title="登陆"/>
 
<h5>2·输入登录用户名和密码</h5>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide3.png"width=50% title="输入用户名密码"/>
<br/>
<h3>二、应用</h3>
<h5>1·应用查看、搜索</h5>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide4.png" width=50% title="应用搜索"/>
 
<h5>2·应用上传</h5>
   <h6>2.1·前台网页端参数设置</h6>
 <img src="${pageContext.request.contextPath}/images/userguide/userGuide5.png"width=50%  title="应用上传参数设置"/>
	<p>填写“基本信息”:“发布名称”、“版本号”、“作者”、“单位”、“编程语言”、“标签”如实填写；</p>
	<p>程序目录<br/><img src="${pageContext.request.contextPath}/images/userguide/userGuide6.png" width=50% title="程序目录"/></p>
	<p>摘要:摘要可以理解为算法描述，建议填写规范如下：<br/>
	其中“算法原理描述”和“开发者联系方式”为必要内容，其他为可选内容。<br/>
	<ol>
	<li>算法原理描述:基本思路、采用的方法等。</li>
	<li>算法效果描述:定性或定量，如准确率、运行时间等。</li>
	<li>注意事项:算法对数据的要求、存在的缺陷等。</li>
	<li>已发表论文</li>
	  <blockquote>
		[1] K. He, J. Sun, and X. Tang, “Guided Image Filtering,” 
	      IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 35, no. 6, pp. 1397-1409, 2013.
    </blockquote>

	<li>参考文献</li>
	  <blockquote>
		[1] K. He, J. Sun, and X. Tang, “Guided Image Filtering,”
 	      IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 35, no. 6, pp. 1397-1409, 2013.
 	  </blockquote>

	<li>开发者联系方式:姓名，邮箱。</li>
</ol>
        <p>参数设置<br/>需要设置算法模块输入参数和输出参数两个部分，</p>
<p>输入参数设置</p>
<p>显示类型选择文本框，参数key填写input，名称填写输入图像，数据类型选择栅格数据，参数类型选择输入数据。</p>
 <img src="${pageContext.request.contextPath}/images/userguide/userGuide7.png" width=40% title="输入参数设置"/>
 <img src="${pageContext.request.contextPath}/images/userguide/userGuide8.png" width=50%/>
 
<p>输出参数设置</p>
<p>其他与输入参数设置一致，只是在参数key填写output，名称填写输出图像，数据类型选择栅格数据，参数类型选择输出数据。</p>
 <img src="${pageContext.request.contextPath}/images/userguide/userGuide9.png" width=50% title="输出参数设置"/>
<p>点击确定。</p>

<h5>3·运行应用</h5>
<p>选择一个应用模块，选择点击下方的“运行”。</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide10.png" width=50%/>
<p>系统会弹出一个参数设置窗口，选择”输入图像”，写入正确的输出图像名称，并设置”进程数”（这里建议设置进程数为1）。</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide11.png" width=50%/>
 <p>选择输入原始图像</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide12.png" width=50%/>
<p>参数选择完毕，确认后，开始执行算法应用。在导航栏“控制”栏会有小图标提示正在运行的应用数目。
在导航栏“控制”栏会有小图标提示正在运行的应用数目。</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide13.png" width=50%/>
<br/>
<h3>三、控制</h3> 
<p>进入“控制”标题栏，左侧有已经运行或者正在运行的应用，点击刚才运行的应用，
页面右侧会根据算法应用的结果绘制出这个算法应用的状态（运行成功、失败）、IO时间、
计算时间、总时间，并画出饼状图。并在下方显示算法应用的计算结果图像。
点击图像，可以在地图上看到此运算结果。</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide14.png" width=50%/>
 
<p>对于目标检测与识别类算法模块，只要模块算法运行的结果提供包含检测结果信息的XML文件，
点击“显示评估曲线”，平台将调用XML文件评估此检测算法的性能，
并且以在网页端以图标形式绘制出性能曲线。</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide15.png" width=50%/>
<br/>
<h3>四、流程</h3>
<p>从我的应用中，拉出自己想用的模块到左边的空白处，例如舰船检测模型，如下图</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide16.png" width=50%/>
<p>双击第一个模块，输入数据，写出输出数据的名称，进程数设为1，点击保存。</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide17.png" width=50%/>
<p>第一个模块输入之后的显示如下图</p>
<img src="${pageContext.request.contextPath}/images/userguide/userGuide18.png" width=20%/>
<p>双击第二个模块，输入原始图像处已变为之前第一个模块输出图像的名称。
	然后，写入输出检测结果的数据名，将进程数设置为1，点击保存。</p>
	<img src="${pageContext.request.contextPath}/images/userguide/userGuide19.png" width=50%/>
	<p>点击运行</p>
	<img src="${pageContext.request.contextPath}/images/userguide/userGuide20.png" width=40%/>
	<p>出现以下对话框，点击确定。</p>
	<img src="${pageContext.request.contextPath}/images/userguide/userGuide21.png" width=40%/>
	<p>流程已开始运行，控制菜单右上角出现提醒脚标，点击打开控制菜单</p>
	<img src="${pageContext.request.contextPath}/images/userguide/userGuide22.png" width=50%/>
	<p>如下图所示，在流程图作业中，有两个模块的作业，作业1和作业2。</p>
	<p>双击模块，在右侧显示各个模块算法信息及计算结果。 </p>
	<img src="${pageContext.request.contextPath}/images/userguide/userGuide23.png" width=50%/>
	<p>至此，流程成功结束。</p>
<br/>	
<h3>五、应用接口</h3>
	<p>分两种情况，（1）上传程序为可执行文件；（2） 上传程序为算法源码</p>
	<ol>
		<li><p>上传为可执行文件时，输入输出参数均以命令行参数的形式输入，
			须是linux服务器下编译正确的可执行文件，并且需要上传已可执行文件命名的.meta文件，
			文件内容为：</p>
			<img src="${pageContext.request.contextPath}/images/userguide/userGuide24.png" width=20%/>
			</li>
			
		<li><p>上传为算法源码时，需要提供算法源码。如果需要依赖第三方函数库的，
			需要指明函数库路径。目前系统已经配置的函数库路径如下：</p>
			<p>Opencv2.3,头文件路径为：/usr/local/include/opencv ，
				/usr/local/include/opencv2 ， /usr/local/include</p>
				<p>Gdal头文件路径为：/usr/local/include;
					 库目录路径为： /usr/local/lib</p>
			</li>
	</ol>
  </div>
</div>
<div id="footer" style="clear: both;background-color:white;border-top: 1px solid #e9e9e9;">
   	<div style="position:relative;top:6px;line-height:0;">
				<p align="center">
					Copyright:SAR Group@上海交通大学&HiGIS Group@国防科学技术大学
				</p>
				<p align="center">
                              <img src="${pageContext.request.contextPath}/images/SJTUISN.gif"
                                   title="上海交大感知与导航所" width="250px" height="75px"/>
                              <img src="${pageContext.request.contextPath}/images/gies_logo.png"
                                   title="gies_logo" width="50px" height="80px"/>
                              <img src="${pageContext.request.contextPath}/images/logo.png"
                                   title="higis_logo" width="90px" height="75px"/>
				</p>

			</div>
 </div>
</div>

<!--<div id="tab8" class="mytab hide" style="margin-left: 10px;">
	
 <div id="left1" style="float: left;
     width: 250px;
     height:700px;
     background-color:rgb(245,245,245);">
     Port side text...
 </div>
 <div id="right1" style="float: right;
     width: 250px;
     height:700px;
     background-color:rgb(245,245,245);">
     Starboard side text...
 </div>
 <div id="middle1" style="
    padding: 0px 160px 5px 160px;
     margin: 0px;
    background-color: white;
     height:500px;">
 </div>
</div>-->
		<script type="text/javascript">
	var graph_datapath = "${configmap['data_path'].value}";;
</script>
		<!-- Le javascript ================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-transition.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-alert.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-modal.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-dropdown.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-scrollspy.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-tab.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-tooltip.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-popover.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-button.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-collapse.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-carousel.js"></script>
		<script
			src="${pageContext.request.contextPath}/assets/js/bootstrap-typeahead.js"></script>
		<script src="${pageContext.request.contextPath}/uriname.do"></script>
		<script src="${pageContext.request.contextPath}/js/mxgraph.js"></script>
		<script
			src="${pageContext.request.contextPath}/js/mxgraph/src/js/mxClient.js"></script>
	</body>
</html>
