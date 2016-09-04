<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ include file="../../common/import.jsp"%>
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
<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/js/bootbox.min.js"></script>
<script type="text/javascript" src="static/common/iscas_june.1.0.js"></script>
<!-- 确认窗口 -->

<script type="text/javascript">
	$(top.disloading());//取消加载...
	
	function search_() {
		top.loading();
		$("#dicForm").submit();
	}
	
	function clearall() {
		$("input[name='SEARCH_KEY']").val('');
	}
	
	function add(){
		top.loading();
		var url = "${ctx}/dic/add";
		var diag = iscas.dialog("新增", url, 223, 370, null);
	}
	function edit(DIC_CODE){
		var url = "${ctx}/dic/edit.do?DIC_CODE="+DIC_CODE;
		iscas.dialog("编辑", url, 223, 370, null);
	}
	function del(DIC_CODE){
		bootbox.confirm("确定要删除此条记录吗?", function(result) {
			if(result) {
				top.loading();
				var url = "${ctx}/dic/del.do?DIC_CODE="+DIC_CODE+"&tm="+iscas.time();
				$.get(url,function(data){
					iscas.log(data);
					nextPage('${page.currentPage}');
				});
			}
		});
	}
</script>
</head>

<body>
<div class="container-fluid" id="main-container">
	<div id="page-content" class="clearfix">
		<div class="row-fluid">
			<!-- 检索  -->
			<form action="${ctx}/dic/dicinfo.do" method="post" name="dicForm" id="dicForm">
				<table>
					<tr>
						<td><span class="input-icon"> 
							<input autocomplete="off" id="nav-search-input" type="text"
								name="SEARCH_KEY" value="${pt.SEARCH_KEY }" placeholder="这里输入关键词" /> 
							<i id="nav-search-icon" class="icon-search"></i>
						</span></td>
						<td style="vertical-align: top;">
							<a class="btn btn-mini btn-light" onclick="search_();" title="检索"><i id="nav-search-icon" class="icon-search"></i></a>
							<!-- <button class="btn btn-mini btn-light" onclick="search()" title="检索">
								<i id="nav-search-icon" class="icon-search"></i>
							</button> -->
						</td>
						<td style="vertical-align: top;">
							<a class="btn btn-mini btn-light" onclick="clearall();" title="清空"><i id="nav-search-icon" class="icon-remove"></i></a>
							<!-- <button class="btn btn-mini btn-light" onclick="clear_()" title="清空">
								<i id="nav-search-icon" class="icon-remove"></i>
							</button> -->
						</td>
					</tr>
				</table>
				<!-- 检索  -->

				<table id="table_report" class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th class="center" style="width: 50px;">序号</th>
							<th class='center'>编码</th>
							<th class='center'>名称</th>
							<th class='center'>类型</th>
							<th class='center'>SQL语句</th>
							<th class='center'>是否系统字典</th>
							<th class='center'>操作</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${not empty varList}">
							<c:forEach items="${varList}" var="var" varStatus="vs">
								<tr>
									<td class='center' style="width: 30px;">${vs.index+1}</td>
									<td class="center">${var.DIC_CODE }</td>
									<td class='center'>
										<a href="${ctx}/dicdatas.do?DIC_CODE=${var.DIC_CODE }" title="查看数据"><i class="icon-arrow-right  icon-on-right"></i>&nbsp;${var.DIC_NAME }</a></td>
									<td class='center'>${var.DIC_TYPE }</td>
									<td class='center' width="40%">${var.DIC_SQL }</td>
									<td class='center'><c:if test="${var.IS_SYS == 'T'}">
											<b class="green">是</b>
										</c:if> <c:if test="${var.IS_SYS != 'T'}">
											<b class="red">否</b>
										</c:if></td>
									<td style="width: 68px;">
										<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${var.DIC_CODE }')"><i class='icon-edit'></i></a> 
										<a class='btn btn-mini btn-danger' title="删除" onclick="del('${var.DIC_CODE }')"><i class='icon-trash'></i></a>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="100" class="center">没有相关数据</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>

				<div class="page-header position-relative">
					<table style="width: 100%;">
						<tr>
							<td style="vertical-align: top; width: 50px;"><a class="btn btn-small btn-success" onclick="add();">新增</a></td>
							<td style="vertical-align: top;"><div class="pagination" style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	</div>
</body>
</html>