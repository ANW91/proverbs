<!DOCTYPE html>
<%@ page import="HelloLucene.HelloLucene"%>
<%@ page import="HelloLucene.autoComp"%>
<html lang="en">

  <head>
	<title>Results</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="design.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="jquery-ui.css" />

	<script type="text/javascript" src="jquery-1.10.2.js"> </script>
	<script type="text/javascript" src="jquery-ui.js"> </script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="bootstraptestpage.js"></script>
	<script>
		$(function () {

        $("#searchBar").autocomplete({
            source: "Bugs",
            minLength: 1,
        });
    });
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
			<a class="nav-link disabled active" href="/proverbs/resultsPage.jsp">Results<span class="sr-only">(current)</span></a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/randomProverb.jsp">Random</a>
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
	
	<%
		String arg = request.getParameter("search");
		if(arg != null && arg !="")
		{
			HelloLucene tc = new HelloLucene();
			String[] result = tc.HelloLucene(arg);
			out.print("<p>"+result[0]+"<p>");
	%>
	<div class="table - responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Proverb</th>
					<th>Origin</th>
				</tr>
			</thead>
			<tbody>
				<%
						for (int i=1; i<result.length; i+=2)
						{
							out.print("<tr><td>"+result[i+1]+"</td>");
							out.print("<td>"+result[i]+"</td></tr>");
						}
						autoComp ac = (autoComp)request.getAttribute("0000");
						ac.auto(arg, true);
					}
					else
					{
						out.print("<p>0 results found</p>");
					}
				%>
			</tbody>
		</table>
	</div>
  </body>

</html>