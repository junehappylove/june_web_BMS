<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../../common/import.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="${basePath }">
		
		<meta charset="utf-8" />
		<title></title>
		
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</head>

<script type="text/javascript">
	$(top.disloading());
	//保存
	function save(){
		if($("#DIC_CODE").val()=="" || $("#DIC_CODE").val()=="此编码已存在!"){
			$("#DIC_CODE").tips({
				side:3,
	            msg:'请输入编码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DIC_CODE").focus();
			$("#DIC_CODE").val('');
			$("#DIC_CODE").css("background-color","white");
			return false;
		}
		
		if($("#DIC_NAME").val()==""){
			$("#DIC_NAME").tips({
				side:3,
	            msg:'请输入名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DIC_NAME").focus();
			return false;
		}
		
		if($("#DIC_TYPE").val()==""){
			$("#DIC_TYPE").tips({
				side:3,
	            msg:'请选择类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DIC_TYPE").focus();
			return false;
		}
		
		if($("#DIC_SQL").val()==""){
			$("#DIC_SQL").tips({
				side:1,
	            msg:'请输入SQL',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DIC_SQL").focus();
			return false;
		}
		has();
	}
	
	//判断编码是否存在
	function has(){
		var edit = $("#EDIT").val();
		var DIC_CODE = $("#DIC_CODE").val();
		if(edit=="add"){
			var url = "dic/has.do?DIC_CODE="+DIC_CODE+"&tm="+new Date().getTime();
			$.get(url,function(data){
				if(data=="error"){
					$("#DIC_CODE").css("background-color","#D16E6C");
					setTimeout("$('#DIC_CODE').val('此编码已存在!')",500);
				}else{
					$("#Form").submit();
					$("#zhongxin").hide();
					$("#zhongxin2").show();
				}
			});
		}else if(edit=='edit'){
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	
</script>


<body>
	<form  action="dic/save.do" name="Form" id="Form" method="post" >
		<div id="zhongxin">
		<input type="hidden" name="EDIT" id="EDIT" value="${pt.EDIT }">
		<table>
			<tr class="info">
				<td><input type="text" name="DIC_CODE" id="DIC_CODE" placeholder="这里输入编码" value="${pt.DIC_CODE }" title="编码"/></td>
			</tr>
			<tr class="info">
				<td><input type="text" name="DIC_NAME" id="DIC_NAME" placeholder="这里输入名称" value="${pt.DIC_NAME }" title="名称"/></td>
			</tr>
			<tr class="info">
				<td><input type="text" name="DIC_TYPE" id="DIC_TYPE" placeholder="选择类型" value="${pt.DIC_TYPE }" title="类型"/></td>
			</tr>
			<tr class="info">
				<td><textarea name="DIC_SQL" id="DIC_SQL" placeholder="这里输入SQL" title="SQL" rows="8">${pt.DIC_SQL}</textarea></td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><img src="static/images/jzx.gif" style="width: 50px;" /><br/><h4 class="lighter block green"></h4></div>
	</form>
</body>
<script type="text/javascript">
	var msg = '${msg}';
	if(msg == 'no'){
		$("#DIC_CODE").attr("readonly",true);
	}

</script>
</html>