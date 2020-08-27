<!DOCTYPE html>
<%@ page import="HelloLucene.MarkovChain"%>

<html lang="en">

  <head>
	<title>Proverb Generator</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="design.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="bootstraptestpage.js"></script>
	
	<style>
		
		#buttonWrapper{ 
            display: flex;
			align-items: center;
			justify-content: center;
        } 
		#textWrapper{
			display: flex;
			align-items: center;
			justify-content: center;
		}
		.infodisp{
			box-sizing: border-box;
			border: 5px solid;
			border-radius: 4px;
			border-color: #000000;
			height: 15%;
			width: 50%;
			padding: 10px;
			top: 15%;
			left: 20%;
			margin: auto;
		}
	</style>
	
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
		  <li class="nav-item">
			<a class="nav-link disabled" href="/proverbs/resultsPage.jsp">Results<span class="sr-only">(current)</span></a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/randomProverb.jsp">Random</a>
		  </li>
		  <li class="nav-item">
			<a class="nav-link" href="/proverbs/allProverbs.jsp">All Proverbs</a>
		  </li>
		  <li class="nav-item active">
			<a class="nav-link active" href="/proverbs/proverbGenerator.jsp">Proverb Generator</a>
		  </li>
		</ul>
		<form class="form-inline my-0 my-lg-0" action="/proverbs/resultsPage.jsp">
		  <div class="col active-cyan-4 mb-4">
				<input class="form-control mr-sm-2" id="searchBar" type="text" placeholder="Search" aria-label="Search" name="search" autocomplete="off">
			</div>
		</form>
		</div>
	</nav>
	<h1 style="text-align:center"> Proverb Generator</h1>
	<div class="infodisp"> 
	<p style="text-align:center">This uses a markov chain algorithm to generate proverbs.</p>
	<p style="text-align:center">Unfortunately with only 1700 proverbs, it doesn't always work great. Sometime it creates proverbs that already exist.</p>
	<p style="text-align:center">Variable Key Size allows the key size to decrease whenever it reaches a null suffix.</p>
	<p style="text-align:center">For example, if a keysize of 2 is selected when key size 2 no longer returns any suffixes, the keysize will reduce to 1.</p>
	<br>
	<form action="/proverbs/proverbGenerator.jsp" method="post">
	<div style="d-flex p-2">
	<div class="form-check form-check-inline">
	<label for="keySize">Key size:	</label>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="keySize" id="inlineRadio1" value="1" <%
		if(request.getParameter("keySize") != null && Integer.parseInt(request.getParameter("keySize")) == 1)
		{
			out.print("checked");
		}
	%>>
	  <label class="form-check-label" for="inlineRadio1">1 </label>
	</div>
	  <input class="form-check-input" type="radio" name="keySize" id="inlineRadio2" value="2" <%
		if((request.getParameter("keySize") == null || Integer.parseInt(request.getParameter("keySize")) == 2) )
		{
			out.print("checked");
		}
	%>>
	  <label class="form-check-label" for="inlineRadio2">2</label>
	</div>
	<div class="form-check form-check-inline">
	  <input class="form-check-input" type="radio" name="keySize" id="inlineRadio3" value="3" <%
		if(request.getParameter("keySize") != null && Integer.parseInt(request.getParameter("keySize")) == 3)
		{
			out.print("checked");
		}
	%>>
	  <label class="form-check-label" for="inlineRadio3">3 </label>
	</div>
	<div style="display:flex; flex-direction: row; justifycontent: center; align-items: center">
		<label for="varks"> Variable Key Size: </label>
		<input type="checkbox" name="varks" value="true" <%
			if(request.getParameter("varks") != null && request.getParameter("varks").equals("true")){
				out.print("checked");
			}
		%>>
	</div>
	</div>
	</div>
	<br>
	<br>
   
	<h3 id="textWrapper" style="text-align:center">
		<%
			String jspPath = session.getServletContext().getRealPath("/WEB-INF");
			String txtFilePath = jspPath+ "/allProverbs.txt";
			int keySize = 2;
			boolean varks = false;
			if(request.getParameter("keySize")!=null)
			{
				keySize = Integer.parseInt(request.getParameter("keySize"));
			}
			if(request.getParameter("varks")!=null && request.getParameter("varks").equals("true"))
			{
				varks = true;
			}
			MarkovChain mc;
			if(session.getAttribute("gen")==null)
			{
				mc = new MarkovChain();
				mc.init(txtFilePath);
				session.setAttribute("gen", mc);
			}
			else
			{
				mc = (MarkovChain)session.getAttribute("gen");
			}
			out.print(mc.markov(keySize,varks));
		%>
	</h3>
	<div id="buttonWrapper">
		<button class="btn btn-primary btnlg" type="submit">Generate!</button>
	</div>
	</form>
</body>
