<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 引入标签库 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap/css/bootstrap.css">
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-2.0.0.min.js"></script>
</head>
<body>
	<!--开始的相对路径，赵资源，以当前资源的路径为基准，经常容易处问题 
以/开始的相对路径，以服务器的路径为标准 
	http://localhost:3306/crud
-->
<!-- 员工修改的模态框-->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
							<p class="form-control-static" id="empName_uptate_static"></p>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="447332241@qq.com">
									<span  class="help-block"></span>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M" checked="checked">
								<!-- values指定提交值 --> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<!-- 部门提交部门id即可 -->
							<div class="col-sm-4"> <!-- 变成4列 -->
								<select class="form-control" name="dId" id="dept_add_select">

								</select>
							</div>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_uptate_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 员工添加的模态框-->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName">
									<span  class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="447332241@qq.com">
									<span  class="help-block"></span>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M" checked="checked">
								<!-- values指定提交值 --> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<!-- 部门提交部门id即可 -->
							<div class="col-sm-4"> <!-- 变成4列 -->
								<select class="form-control" name="dId" id="dept_add_select">

								</select>
							</div>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<div class="containner">
		<!--标题-->
		<div class="row"></div>
		<div class="col-md-12">
			<h1>SSM_CRUD</h1>
		</div>
		
		<form id="upload_form" enctype="multipart/form-data"> 
             <input id="news_scheme_upload_file" name="file" type="text" style="width:300px" data-options="required:true,prompt:'请选择导出生成的excel文件'">
        	<button class="btn btn-primary" id="emp_upload">上传</button>
        </form>

		<!--按钮-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all">删除</button>
			</div>
		</div>
		<!--表格数据-->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
						<th>
							<input type="checkbox" id="check_all">
						</th> 
							<th>#</th>
							<th>empname</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<!-- 表格体 -->

					</tbody>

				</table>
			</div>
		</div>
		<!--分页信息-->
		<div class="row">
			<!--分页文字信息-->
			<div class="col-md-6" id="page_info_area"></div>
			<!--分页条信息-->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>
	<script type="text/javascript">
	
	
		 var totalRecord,currentPage;
		//1.在页面加载完成以后，直接去发送一个ajax请求,要到分页数据
		$(function() {
			//去首页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//解析显示分页条数据
					build_page_nav(result);

				}
			});
		}

		function build_emps_table(result) {
			//清空table 表格
			//emps_table tbody
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptName = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyph icon-pencil")).append("编辑");
				
				//为编辑按钮添加一个自定义的属性,来表示当前员工的id
				editBtn.attr("edit-id",item.empId);
			 
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");
				
				//为删除按钮添加一个自定义的属性来表示当前员工的删除id
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
							.append(empIdTd)
							.append(empIdTd)
							.append(empNameTd)
					     	.append(genderTd)
					    	.append(emailTd)
					    	.append(deptName)
						    .append(btnTd)
						    .appendTo("#emps_table tbody")
			})
		}

		//解析显示分页信息
		function build_page_info(result) {
			//page_info_area
			$("#page_info_area ").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页,总"
							+ result.extend.pageInfo.pages + "页,总"
							+ result.extend.pageInfo.total + "条记录数");
		 totalRecord=result.extend.pageInfo.total; //赋值为总记录数
		 currentPage = result.extend.pageInfo.pageNum;

		}
		//解析显示分页条
		function build_page_nav(result) {
			//page_nav
			$("#page_nav ").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			//为元素添加点击翻页的事件
			firstPageLi.click(function() {
				to_page(1);
			})

			prePageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum - 1);
			})

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));

			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				})

				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				})
			}

			//添加首页和前一页的提示
			ul.append(firstPageLi).append(prePageLi);
			//1.2.3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				})
				ul.append(numLi);
			});
			//添加下一页和末页提示
			ul.append(nextPageLi).append(lastPageLi);

			//把ul加入到nav元素中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav");

		}

		//清空表单样式以及内容
		function reset_form(ele){
			$(ele)[0].reset;
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
			//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			//清除表单数据(表单完整重置(表单的数据，表单的样式))
			reset_form("#empAddModal form");
			$("#empAddModal form")[0].reset();
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({ //利用js创建模态框
				backdrop : "static"
			});
		});
		
		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele){
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url: "${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					console.log(result);
					//显示部门信息在下拉列表中
					//$("#dept_add_select").append("")
					$.each(result.extend.depts,function(){
					var optionEle = $("<option ></option>").append(this.deptName).attr("value",this.deptId);
					optionEle.appendTo(ele);
					})
					
				}
			});		
		};	
		
		
		function validate_add_form(){
			//1.拿到要校验的数据.使用正则表达式
			var empName = $("#empName_add_input").val(); 
			var regName=  /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//小写或者大写的a-z或者0-9   或者_或者-  3到16位  或者中文2到5位
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success"," ");
			}
			
			//2.校验邮箱信息
			var email = $("#email_add_input").val(); //拿到email的值 
			var regemail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regemail.test(email)){
			//	alert("邮箱格式不正确");
			//应该清空这个元素之前的样式
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input","success"," ");
				return true;
				
			}
		};
		
		function show_validate_msg(ele,status,msg){
			//清除当前元素的检验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text(" ");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
				
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data: "empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						 show_validate_msg("#empName_add_input","success","用户名可用");
						 $("#emp_save_btn").attr("ajax_va","success"); //给按钮添加一个属性 内容为success
						
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						 $("#emp_save_btn").attr("ajax_va","error");
					}
				}
				 
			});
		});
		
		//点击保存，保存员工.
		$("#emp_save_btn").click(function(){
			
			//1.模态框中填写的表单数据提交给服务器进行保存
			//2.现对要提交给服务器的数据进行校验
			  if(!validate_add_form()){
				return false;
			}  
			//3.判断之前的ajax用户名校验是否成功，如果成功
			if($(this).attr("ajax_va")=="error"){
				return false;
			}
			//4.发送ajax请求保存员工 
			//alert($("#empAddModal form").serialize());
		 	$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
						//alert(result.msg);
						if(result.code == 100){
							//员工保存成功
							//1.关闭模态框
							$("#empAddModal").modal("hide");
							//2.来到最后一页,显示刚才保存的数据
							//发送ajax请求显示最后一页数据
							//
							to_page(99999); //数字足够大会直接去最后一面
						}else{
							//显示失败信息
							//console.log(result);
							//有哪个字段的错误信息就显示哪个字段
							if( undefined != result.extend.errorFields.email){
								//显示邮箱错误信息
								show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
							}
							if(undefined != result.extend.errorFields.empName){
								//显示员工名字的错误信息
								show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
							}
							
						}
						 									
				}
			}) 
		});
		
		 
		//1.我们是按钮创建之前就绑定了click,所以绑定不上
		//1.我们可以在创建按钮的时候绑定事件.  2.绑定点击 live
		//jquery新版没有live,使用on进行替代
		//
		$(document). on("click", ".edit_btn" ,function(){
			//0.查出员工信息，显示员工信息
			//1.查出部门信息，并显示部门列表
			getDepts("#empUpdateModal select");
		 	getEmp($(this).attr("edit-id")); //获取当前按钮的id 
		 	//3.把员工的id传递给模态框的更新按钮
		 	$("#emp_uptate_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({ //利用js创建模态框
				backdrop : "static"
			});
									
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_uptate_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]); //当单选框被选中
					$("#empUpdateModal select").val([empData.dId]);
				} 
				
			})
		}
		
		//点击更新,更新员工信息
		$("#emp_uptate_btn").click(function(){
			//验证邮箱是否合法
			//1.校验邮箱信息
			var email = $("#email_update_input").val(); //拿到email的值 
			var regemail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regemail.test(email)){
			//应该清空这个元素之前的样式
				show_validate_msg("#email_update_input","error","邮箱格式不正确"); 
				return false;
			}else{
				show_validate_msg("#email_update_input","success"," ");	
			}
			//2.发送ajax请求保存更新员工的数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(), //获取表单序列化后的结果,改方法为put
				success:function(result){
					//alert(result.msg);
					//1.关闭对话框
					$("#empUpdateModal").modal("hide");
					//2.回到本页面
					to_page(currentPage);
				}
			});			
		});
		
		//单个删除
		$(document). on("click", ".delete_btn" ,function(){
			 //1.弹出是否确认删除对话框
			 var empName = $(this).parents("tr").find("td:eq(2)").text();
			 var empId = $(this).attr("del-id");
			 //alert($(this).parents("tr").find("td:eq(1)").text());
			 if(confirm("确定删除["+empName+"]吗?")){
				 //确认.发送ajax请求删除
				 $.ajax({
					 url:"${APP_PATH}/emp/"+empId,
					 type:"DELETE",
					 success:function(result){
						 alert(result.msg);
						 //回到本页
						 to_page(currentPage);
						 
					 }
				 })
			 }
		})
		
		//完成全选/全不选
		$("#check_all").click(function(){
			//attr获取checked是undefined 
			//我们这些dom原生的属性:attr获取自定义属性的值,prop获取原生的值
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document). on("click", ".check_item" ,function(){
			//判断当前选中的元素是不是5个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
			
		});
		
		//点击全部删除,就批量删除
		$("#emp_delete_all").click(function(){
			//$(".check_item:checked")
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//this
				empNames+=($(this).parents("tr").find("td:eq(2)").text())+",";
				//组装员工id字符串
				del_idstr+=($(this).parents("tr").find("td:eq(1)").text())+"-"
				
			});
			//去除empNames多余的,
			empNames = empNames.substring(0, empNames.length-1);
			//去除删除的id多余的-
			del_idstr =del_idstr.substring(0, del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
		});
		
		
		
		
		
        $('#emp_upload').on('click',function(){
        	
            	//使用FormData，进行Ajax请求并'上传文件'.普通异步传递无法传传递文件,下面一句相当于把表单中的所有属性都封装进去了.
                var formData = new FormData(document.getElementById("upload_form")); 
                $.ajax({ 
                    url : '${APP_PATH}/upload', 
                    type : 'POST', 
                    data : formData, 
                    // 告诉jQuery不要去处理发送的数据
                    processData : false, 
                    // 告诉jQuery不要去设置Content-Type请求头
                    contentType : false,
                    success : function(data) {}
                });
        });

	</script>

	<script type="text/javascript"
		src="${APP_PATH}/static/bootstrap/js/bootstrap.js"></script>
</body>
</html>