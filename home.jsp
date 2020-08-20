<!DOCTYPE html>
<html lang="en">

  <head>
	<title>Proverbs</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="design.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="jquery-ui.css" />

	<script type="text/javascript" src="jquery-1.10.2.js"> </script>
	<script type="text/javascript" src="jquery-ui.js"> </script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script
	<script type="text/javascript" src=bootstraptestpage.js"></script>
	<script>
		$(function () {

        $("#searches").autocomplete({
            source: "Suggestions",
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
		  <li class="nav-item active">
			<a class="nav-link active" href="/proverbs/home.jsp">Home <span class="sr-only">(current)</span></a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link disabled" href="/proverbs/resultsPage.jsp">Results</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/randomProverb.jsp">Random</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/allProverbs.jsp">All Proverbs</a>
		  </li>
		</ul>
		</div>
	</nav>
	
	<div class="d-flex justify-content-center name">
		<h1 style="font-size:4vw;">PROVERBS</h1>
	</div>
	<div class="wrap">
		<div class="form-group">
			<form action="/proverbs/resultsPage.jsp">
				<div class="col active-cyan-4 mb-4">
					<input class="form-control" type="text" placeholder="Search" aria-label="Search" id="searches" name="search" >
				<span for="searches" class="input-group-btn" id="loading">
						<span class="spinner-border text-info"></span>
				</span>
			</form>
		</div>
	</div>
  </body>
  
</html>