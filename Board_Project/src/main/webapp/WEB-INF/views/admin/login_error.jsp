<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
<div class="container-fluid">
         <!-- 404 Error Text -->
         <div class="text-center">
             <div class="error mx-auto" data-text="Fail">Fail</div>
             <p class="lead text-gray-800 mt-1">${errorMsg }</p>
             <p class="text-gray-500">${errorMsgEng }</p>
             <a href="javascript:history.back(-1);">← Go Back</a>
         </div>
     </div>
</body>
