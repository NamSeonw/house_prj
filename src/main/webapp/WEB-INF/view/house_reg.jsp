<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="utf-8">
<!-- 기본 js -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
<!-- 기본 js -->

<link href="/resources/css/dropzone.css" rel="stylesheet">

<title>SB Admin 2 - Dashboard</title>
<script>
//파일 리스트 번호
var fileIndex = 0;
// 등록할 전체 파일 사이즈
var totalFileSize = 0;
// 파일 리스트
var fileList = new Array();
// 파일 사이즈 리스트
var fileSizeList = new Array();
// 등록 가능한 파일 사이즈 MB
var uploadSize = 50;
// 등록 가능한 총 파일 사이즈 MB
var maxUploadSize = 500;

$(function(){
	drag_drop();
})

function drag_drop(){
	var a = $("#dropzone_cut");

	a.on('dragenter', function(e) {
		e.stopPropagation();
		e.preventDefault();
	})
	a.on('dragleave', function(e) {
		e.stopPropagation();
		e.preventDefault();
	})
	a.on('dragover', function(e) {
		e.stopPropagation();
		e.preventDefault();
		
	})
	a.on('drop', function(e) {
		e.stopPropagation();
		e.preventDefault();
		
		var files = e.originalEvent.dataTransfer.files;
		
        if(files != null){
            if(files.length < 1){
                alert("폴더 업로드 불가");
                return;
            }
            selectFile(files)
        }else{
            alert("ERROR");
        }
	})	
}

function selectFile(fileObject){
    var files = null;

    if(fileObject != null){
        // 파일 Drag 이용하여 등록시
        files = fileObject;
        fileList = fileObject;
    }else{
        // 직접 파일 등록시
        files = $('#multipaartFileList_' + fileIndex)[0].files;
    }
     
    // 다중파일 등록
    if(files != null){
        for(var i = 0; i < files.length; i++){
            // 파일 이름
            var fileName = files[i].name;
            var fileNameArr = fileName.split("\.");
            // 확장자
            var ext = fileNameArr[fileNameArr.length - 1];
            // 파일 사이즈(단위 :MB)
            var fileSize = files[i].size / 1024 / 1024;
            
            if($.inArray(ext, ['exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml']) >= 0){
                // 확장자 체크
                alert("등록 불가 확장자");
                break;
            }else if(fileSize > uploadSize){
                // 파일 사이즈 체크
                alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                break;
            }else{
                // 전체 파일 사이즈
                totalFileSize += fileSize;
                // 파일 배열에 넣기
                fileList[fileIndex] = files[i];
                // 파일 사이즈 배열에 넣기
                fileSizeList[fileIndex] = fileSize;
                // 업로드 파일 목록 생성
                addFileList(fileIndex, fileName, fileSize);
                // 파일 번호 증가
                fileIndex++;
                $(".here").hide()
            }
        }
    }else{
        alert("ERROR");
    }
}

// 업로드 파일 목록 생성
function addFileList(fIndex, fileName, fileSize){
    var html = "";
    html += "<tr id='fileTr_" + fIndex + "'>";
    html += "    <td class='left' >";
    html +=         fileName + " / " + fileSize + "MB "  + "<a href='#' onclick='deleteFile(" + fIndex + "); return false;' class='btn small bg_02'>삭제</a>"
    html += "    </td>"
    html += "</tr>"

    $('#file_name').append(html);
}
function deleteFile(fIndex){
    // 전체 파일 사이즈 수정
    totalFileSize -= fileSizeList[fIndex];
     
    // 파일 배열에서 삭제
    delete fileList[fIndex];
     
    // 파일 사이즈 배열 삭제
    delete fileSizeList[fIndex];
     
    // 업로드 파일 테이블 목록에서 삭제
    $("#fileTr_" + fIndex).remove();
}

// 파일 등록
function uploadFile(){
    // 등록할 파일 리스트
    var uploadFileList = fileList;
    
    // 파일이 있는지 체크
    /* if(uploadFileList.length == 0){
        // 파일등록 경고창
        alert("파일이 없습니다.");
        return;
    }
      */
    // 용량을 500MB를 넘을 경우 업로드 불가
    if(totalFileSize > maxUploadSize){
        // 파일 사이즈 초과 경고창
        alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
        return;
    }
         
    if(confirm("등록 하시겠습니까?")){
        // 등록할 파일 리스트를 formData로 데이터 입력
        var form = $('#form_submit');
        var formData = new FormData(form[0]);
        console.log("formData" , formData)
        console.log("upload",uploadFileList)
        for(var i = 0; i < uploadFileList.length; i++){
            formData.append('files', fileList[uploadFileList[i]]);
        }
        
        $.ajax({
            url:"house_reg",
            data:formData,
            type:'POST',
            enctype:'multipart/form-data',
            processData:false,
            contentType:false,
            dataType:'json',
            cache:false,
            success:function(result){
                if(result.data.length > 0){
                    alert("성공");
                    location.reload();
                }else{
                    alert("실패");
                    location.reload();
                }
            }
        });
    }
}
</script>

</head>

<style>
table input[type='text'] {
	margin-top: 16px;
	margin-left: 61px;
}

td span {
	margin-left: 10px;
}

tr th {
	background: #dcf0ff;
}

td {
	width: 10%;
	background: #f1f9ff;
}

.dropzone_div {
	width: 295px;
	display: inline-block;
	height: 277px;
	text-align: center;
	background: #dcf0ff;
}

.dropzone_span {
	top: 46%;
	position: relative;
	color: #858796;
	font-family: Nunito, -apple-system, BlinkMacSystemFont, "Segoe UI",
		Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji",
		"Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	font-weight: bold;
}

.dropzone {
	border: 2px dashed #0087F7;
	border-radius: 5px;
	background: white;
}

.dz-preview {
	position: absolute;
	left: 400px;
}

.save_button {
	width: 51px;
	background: red;
	border: none;
	outline: none;
	color: white;
	font-weight: bold;
	margin-left: auto;
	margin-right: auto;
	margin-top: 10px;
}
</style>

<body id="page-top">
	<div id="wrapper">
		<%@ include file="left_side.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="top.jsp"%>
				<div class="container-fluid">
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">글쓰기</h1>
					</div>

					<div class="row">
						<div class="col-lg-6">
							<div class="card shadow"
								style="width: 1334px; height: 760px; margin-bottom: 0px">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">부동산</h6>
								</div>
								<div class="card-body">
									<form id="form_submit" action="/house_reg" method="post"
										enctype="multipart/form-data">
										<div class="card shadow mb-4" style="height: 640px">
											<table class="Ltbl_dt" summary="물건기본정보 표">
												<tbody>
													<tr>
														<th width="13%">사건번호</th>
														<td width="20%"><input name="asd" type="text"></td>
														<th width="13%">물건번호</th>
														<td width="19%"><input type="text"></td>
													</tr>
													<tr>
														<th width="13%">감정평가액</th>
														<td><input type="text"><span>원</span></td>
														<th width="13%">최저매각가격</th>
														<td><input type="text"><span>원</span></td>
													</tr>

													<tr>
														<th width="13%">매각기일</th>
														<td>${house.date_of_sale}</td>
													</tr>

													<tr>
														<th width="13%">물건비고</th>
														<td width="20%"><input type="text"><br></td>
														<th width="13%">물건종류</th>
														<td><input type="text" width="20%"></td>
													</tr>

													<tr>
														<th width="13%">목록1 소재지</th>
														<td width="20%"><input type="text"></td>
														<th>입찰방법</th>
														<td style="text-align: center">기일입찰</td>
													</tr>

													<tr>
														<th>담당</th>
														<td><input type="text"></td>
													</tr>
													<tr>
														<th width="13%">사건접수</th>
														<td width="37%"><input type="text"></td>
														<th width="13%">경매개시일</th>
														<td width="37%"><input type="text"></td>
													</tr>
													<tr>
														<th>배당요구종기</th>
														<td><input type="text"></td>
														<th>청구금액</th>
														<td><input type="text"><span>원</span></td>
													</tr>
												</tbody>
											</table>

											<div style="display: flex;">
												<div class="dropzone_div">
													<span class="dropzone_span">첨부파일</span>
												</div>
												<div style="width: 1000px;" class="dropzone"
													id="dropzone_cut">
													<div class="dz-message">
														<h1 class="display-4">
															<i class=" mdi mdi-progress-upload"></i>
														</h1>
														<span class="here">파일을 드랍해주세요.</span><BR>
														<div id="file_name"></div>
														<div class="p-t-5">
															<a style='position: relative; top: 50px;' href="#"
																class="btn btn-lg btn-primary">Upload File</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</form>
									<button class="save_button" onclick="uploadFile()">저장</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
</body>
</html>
