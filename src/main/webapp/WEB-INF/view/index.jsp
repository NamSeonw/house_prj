<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="utf-8">

<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/resources/js/sb-admin-2.min.js"></script>

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<title>SB Admin 2 - Dashboard</title>
<script>
	$(function() {
		$("#datepicker").datepicker({
			dateFormat : 'yy-mm-dd' //Input Display Format 변경
			,
			showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,
			showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
			,
			changeYear : true //콤보박스에서 년 선택 가능
			,
			changeMonth : true //콤보박스에서 월 선택 가능                
			,
			minDate : "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
			,
			maxDate : "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
		});
	})

	function date_send() {
		$("#date_send").submit();
	}
</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="left_side.jsp" %>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="top.jsp" %>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
					</div>

					<!-- Content Row -->
					<div class="row">
						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4"
							style="padding-right: 6.75rem;">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<h6>날짜별 검색</h6>
											<form id=date_send autocomplete=”off”>
												<input type="text" id="datepicker" name="date" placeholder="날짜를 입력해주세요." autocomplete=”off”>
												<button class="btn btn-primary" type="button"
													onclick="date_send()">
													<i class="fas fa-search fa-sm"></i>
												</button>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Content Row -->

					<div class="row">

						<!-- Area Chart -->
						<div class="col-xl-8 col-lg-7">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<!-- Card Body -->
								<div class="card-body"></div>
								<h3>${date}</h3>
								<table style="text-align: center;">
									<thead>
										<th>사건번호</th>
										<th>물건용도</th>
										<th>소재지</th>
										<th>비고</th>
										<th>감정평가액<br> 최저매각가격</th>
										<th>담당계<br> 매각기일</th>
										<th>진행상태</th>
									</thead>
									<tbody>
										<c:forEach var="h" items="${houselist}">
											<tr>
												<td>${h.incident_num}</td>
												<td>${h.purpose}</td>
												<td><a href="/index?date=${h.reg_date}&id=${h.id}">${h.full_address}</a></td>
												<td>${h.remark}</td>
												<td><div>${h.appraisal_amount}</div><div>${h.row_appraisal_amount}</div></td>
												<td><div>${h.host}</div><div>${h.date_of_sale }</div></td>
												<td>${h.progress}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- Content Row -->
					<div class="row">
						<!-- Content Column -->
						<div class="col-lg-6 mb-4">
							<!-- Project Card Example -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Projects</h6>
								</div>
								<div class="card-body">
									<table class="Ltbl_dt" summary="물건기본정보 표">
										<tbody>
											<tr>
												<th width="13%">사건번호</th>
												<td width="20%">${house.incident_num}</td>
												<th width="13%">물건번호</th>
												<td width="19%">${house.id}</td>
												<th width="13%">물건종류</th>
												<td width="22%">${house.purpose}</td>
											</tr>
											<tr>
												<th width="13%">감정평가액</th>
												<td>${house.appraisal_amount}원</td>
												<th width="13%">최저매각가격</th>
												<td>${house.row_appraisal_amount}원</td>
												<th width="13%">입찰방법</th>
												<td>기일입찰</td>
											</tr>

											<tr>
												<th width="13%">매각기일</th>
												<td colspan="5">${house.date_of_sale}</td>
											</tr>

											<tr>
												<th>물건비고</th>
												<td colspan="5">${house.house_info }<br>
												</td>
											</tr>

											<tr>
												<th>목록1 소재지</th>
												<td colspan="5">${house.full_address })</td>
											</tr>

											<tr>
												<th>담당</th>
												<td colspan="5">${house.host}</td>
											</tr>
										</tbody>
									</table>
									<table class="Ltbl_dt" summary="물건기본정보 표2">
										<tbody>
											<tr>
												<th width="13%">사건접수</th>
												<td width="37%">${house.incident_case }</td>
												<th width="13%">경매개시일</th>
												<td width="37%">${house.start }</td>
											</tr>
											<tr>
												<th>배당요구종기</th>
												<td>${house.dividend_request_date }</td>
												<th>청구금액</th>
												<td>${house.billing_amount}원</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<!-- Color System -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Projects</h6>
								</div>
								<div class="card-body">
									Primary
									<div class="text-white-50 small">#4e73df</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- End of Main Content -->

		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="login.html">Logout</a>
					</div>
				</div>
			</div>
		</div>
</body>

</html>
