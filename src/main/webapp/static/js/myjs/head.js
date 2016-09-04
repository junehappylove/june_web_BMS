
var locat = (window.location+'').split('/'); 

$(function() {
	if ('main' == locat[3]) {
		locat = locat[0] + '//' + locat[2];
	} else {
		locat = locat[0] + '//' + locat[2] + '/' + locat[3];
	}
});


//菜单状态切换
var fmid = "fhindex";
var mid = "fhindex";
function siMenu(id,fid,MENU_NAME,MENU_URL){
	if(id != mid){
		$("#"+mid).removeClass();
		mid = id;
	}
	if(fid != fmid){
		$("#"+fmid).removeClass();
		fmid = fid;
	}
	$("#"+fid).attr("class","active open");
	$("#"+id).attr("class","active");
	top.mainFrame.tabAddHandler(id,MENU_NAME,MENU_URL);
	if(MENU_URL != "druid/index.html"){
		loading();
	}
}

$(function(){
	//换肤
	$("#skin-colorpicker").ace_colorpicker().on("change",function(){
		var b=$(this).find("option:selected").data("class");
		hf(b);
		var url = locat+'/head/setSKIN.do?SKIN='+b+'&tm='+new Date().getTime();
		$.get(url,function(data){});
	
	});
});

var USER_ID;

$(function(){
	$.ajax({
		type: "POST",
		url: locat+'/head/getUname.do?tm='+new Date().getTime(),
    	data: encodeURI(""),
		dataType:'json',
		//beforeSend: validateData,
		cache: false,
		success: function(data){
			//alert(data.list.length);
			 $.each(data.list, function(i, list){
				 
				 //登陆者资料
				 $("#user_info").html('<small>Welcome</small> '+list.NAME+'');
				 USER_ID = list.USER_ID;//用户ID
				 hf(list.SKIN);//皮肤
				 
				 if(list.USERNAME != 'admin'){
					 $("#adminmenu").hide();	//隐藏菜单设置
					 $("#adminzidian").hide();	//隐藏数据字典
					 $("#systemset").hide();	//隐藏系统设置
					 $("#productCode").hide();	//隐藏代码生成
				 }
				 
			 });
		}
	});
});

function hf(b){
	var a=$(document.body);
	a.attr("class",a.hasClass("navbar-fixed")?"navbar-fixed":"");
	if(b!="default"){
		a.addClass(b);
	}if(b=="skin-1"){
		$(".ace-nav > li.grey").addClass("dark");
	}else{
		$(".ace-nav > li.grey").removeClass("dark");
	}
	if(b=="skin-2"){
			$(".ace-nav > li").addClass("no-border margin-1");
			$(".ace-nav > li:not(:last-child)").addClass("white-pink")
			.find('> a > [class*="icon-"]').addClass("pink").end()
			.eq(0).find(".badge").addClass("badge-warning");
	}else{
			$(".ace-nav > li").removeClass("no-border").removeClass("margin-1");
			$(".ace-nav > li:not(:last-child)").removeClass("white-pink")
			.find('> a > [class*="icon-"]').removeClass("pink").end()
			.eq(0).find(".badge").removeClass("badge-warning");
	}
	if(b=="skin-3"){
		$(".ace-nav > li.grey").addClass("red").find(".badge").addClass("badge-yellow");
	}else{
		$(".ace-nav > li.grey").removeClass("red").find(".badge").removeClass("badge-yellow");
	}
}

/**
 * 修改个人资料
 */
function editUserH(){
	 loading();
	 var URL = locat+'/user/goEditU.do?USER_ID='+USER_ID+'&fx=head';
	 iscas.dialog("个人资料",URL,225,389);
}

/**
 * 系统设置
 */
function editSys(){
	 loading();
	 var URL = locat+'/head/goSystem.do';
	 iscas.dialog("系统设置",URL,600,596);
}

/**
 * 代码生成
 */
function productCode(){
	 loading();
	 var URL = locat+'/head/goProductCode.do';
	 iscas.dialog("代码生成器",URL,800,450, disloading);	
}

/**
 * 数据字典
 */
function zidian(){
	 loading();
	 var URL = locat+'/dictionaries.do?PARENT_ID=0';
	 iscas.dialog("数据字典",URL,799,460);	 
}

/**
 * 菜单
 */
function menu(){
	 loading();
	 var URL = locat+'/menu.do';
	 iscas.dialog("菜单编辑",URL,720,390);
}

/**
 * 切换菜单
 */
function changeMenu(){
	window.location.href=locat+'/main/yes';
}

/**
 * 清除加载进度
 */
function disloading(){
	$("#loading").hide();
}

/**
 * 显示加载提示
 */
function loading(){
	$("#loading").show();
}