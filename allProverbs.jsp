<!DOCTYPE html>
<%@ page import="HelloLucene.allProverbs"%>

<html lang="en">

  <head>
	<title>All Proverbs</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="design.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="bootstraptestpage.js"></script>
	<script>

	function filterText()
		{  
			var rex = new RegExp($('#filterText').val());
			if(rex =="/all/"){clearFilter()}else{
				$('.content').hide();
				$('.content').filter(function() {
				return rex.test($(this).text());
				}).show();
		}
		}
		
	function clearFilter()
		{
			$('.filterText').val('');
			$('.content').show();
		}
	</script>
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
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/randomProverb.jsp">Random</a>
		  </li>
		  <li class="nav-item active">
			<a class="nav-link active" href="/proverbs/allProverbs.jsp">All Proverbs</a>
		  </li>
		</ul>
		<form class="form-inline my-0 my-lg-0" action="/proverbs/resultsPage.jsp">
		  <div class="col active-cyan-4 mb-4">
				<input class="form-control mr-sm-2" id="searchBar" type="text" placeholder="Search" aria-label="Search" name="search">
			</div>
		</form>
		</div>
	</nav>
	<div class="table - responsive">
		<table id="table" class="table table-striped">
			<thead>
				<tr>
					<th>Proverb</th>
					<th>Origin
						<select id='filterText' style='display:inline-block' onchange='filterText()'>
							<option disabled selected>Select</option>
							<option value='African'>African</option>
							<option value='Chinese'>Chinese</option>
							<option value='English'>English</option>
							<option value='Jewish'>Jewish</option>
							<option value='Latin'>Latin</option>
							<option value='Norse'>Norse</option>
							<option value='Russian'>Russian</option>
							<option value='Yiddish'>Yiddish</option>
							<option value='all'>All</option>
						</select>
					</th>
				</tr>
			</thead>
			<tbody>
			<%
				String jspPath = session.getServletContext().getRealPath("/WEB-INF");
				allProverbs ap = new allProverbs();
				String[][] provs = ap.getAllProverbs(jspPath);
				for(int i=0; i<provs[0].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[0][i]+"</th><th>African</th></tr>");
				}
				for(int i=0; i<provs[1].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[1][i]+"</th><th>Chinese</th></tr>");
				}
				for(int i=0; i<provs[2].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[2][i]+"</th><th>English</th></tr>");
				}
				for(int i=0; i<provs[3].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[3][i]+"</th><th>Jewish</th></tr>");
				}
				for(int i=0; i<provs[4].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[4][i]+"</th><th>Latin</th></tr>");
				}
				for(int i=0; i<provs[5].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[5][i]+"</th><th>Norse</th></tr>");
				}
				for(int i=0; i<provs[6].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[6][i]+"</th><th>Russian</th></tr>");
				}
				for(int i=0; i<provs[7].length; i++){
					out.print("<tr class=\"content\"><th>"+provs[7][i]+"</th><th>Yiddish</th></tr>");
				}
				
			%>
			</tbody>
	
</body>
</html>