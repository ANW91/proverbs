<!DOCTYPE html>
<%@ page import="HelloLucene.randomProverb"%>

<html lang="en">

  <head>
	<title>Random Proverb</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="design.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="bootstraptestpage.js"></script>
  </head>
  
  <body>
  <nav class="navbar navbar-expand-lg topnav">
	  <a class="navbar-brand" href="/proverbs/home.jsp">PROVERBS</a>
	  <button class="navbar-toggler navbar-dark" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/home.jsp">Home</a>
		  </li>
		  <li class="nav-item active">
			<a class="nav-link disabled" href="/proverbs/resultsPage.jsp">Results<span class="sr-only">(current)</span></a>
		  </li>
		  <li class="nav-item active">
			<a class="nav-link active" href="/proverbs/randomProverb.jsp">Random</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/allProverbs.jsp">All Proverbs</a>
		  </li>
		</ul>
		<form class="form-inline my-0 my-lg-0" action="/proverbs/resultsPage.jsp">
		  <div class="col active-cyan-4 mb-4">
				<input class="form-control mr-sm-2" id="searchBar" type="text" placeholder="Search" aria-label="Search" name="search">
			</div>
		</form>
		</div>
	</nav>
	<div class="d-flex justify-content-center name">
	<p style="font-size:2vw;">
		<%
			String jspPath = session.getServletContext().getRealPath("/WEB-INF");
			String txtFilePath = jspPath+ "/allProverbs.txt";
			randomProverb tc = new randomProverb();
			out.print(tc.choose(txtFilePath));
		%>
	</div>
	</p>
</body>
