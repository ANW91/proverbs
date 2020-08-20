$(document).on("keypress", "input", function(e){
		var x = document.getElementById("loading");
        if(e.which == 13){
            x.style.display = "block";
        }
    });