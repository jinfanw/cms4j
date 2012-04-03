<%--
 相册管理
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-2
  Time: 下午5:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>相册管理列表</title>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>

    <!-- Add fancyBox -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>

    <!-- Optionally add button and/or thumbnail helpers -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>

    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>相册管理列表</h2>

        <p>下面列出了所有相册里面的图片。</p>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/small/white/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/small/white/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form id="imageList" name="imageList" method="post">
        <div class="box grid_16 round_all">
            <table class="display table">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>缩略图</th>
                    <th>标题</th>
                    <th>描述</th>
                    <th>URL</th>
                    <th>上传时间</th>
                    <th>操作</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${images}" var="image" begin="0" step="1">
                <tr>
                    <td><input type="checkbox" name="isSelected"  value="${image.id}"></td>
                    <td><a href="#" rel="fancybox-thumb" class="fancy_box"><img src="${ctx}/static/uploads/gallery/${image.imageUrl}" width="50px"/></a></td>
                    <td>${image.title}</td>
                    <td><a href="#">点击查看</a> </td>
                    <td>${image.imageUrl}</td>
                    <td>${image.createTime}</td>
                    <td><a href="${ctx}/image/edit/${image.id}">【编辑】</a>
                        <c:choose><c:when test="${image.deleted}"><a href="${ctx}/image/delete/${image.id}">【恢复】</a></c:when>
                            <c:otherwise><a href="${ctx}/image/delete/${image.id}" id="delete">【删除】</a></c:otherwise></c:choose></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <button class="button_colour" id="deleteAll"><img height="24" width="24" alt="Bended Arrow Right"
                                                          src="${ctx}/static/dashboard/images/icons/small/white/BendedArrowRight.png"/><span>批量删除</span>
        </button>
    </form>
</div>
    <script type="text/javascript">
            $(document).ready(function() {
                $(".fancy_box").fancybox({
                    prevEffect:'none',
                    nextEffect:'none',
                    helpers:{
                        title:{
                            type:'outside'
                        },
                        overlay:{
                            opacity:0.8,
                            css:{
                                'background-color':'#000'
                            }
                        },
                        thumbs:{
                            width:50,
                            height:50
                        }
                    }
                });
                $('#deleteAll').click(function () {
                    if (confirm("确定批量删除吗？")) {
                        $("#imageList").attr("action", "${ctx}/image/batchDelete").submit();
                    } else {
                        return false;
                    }
                });
                $('#delete').click(function(){
                    if(confirm('确定删除？')){
                        return true;
                    }else{
                        return false;
                    }
                });

            });
</script>
</body>
</html>