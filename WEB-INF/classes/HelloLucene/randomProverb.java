package HelloLucene;

import java.io.*;
import java.util.*;
import java.net.URL;
import java.net.URI;
import java.net.URLDecoder;

public class randomProverb{
	
	public static String choose(String path) throws FileNotFoundException, UnsupportedEncodingException
	  {
		path = URLDecoder.decode(path,"UTF-8");
		path = path.replaceAll("file:/", "");
		path = path.replaceAll("\\u0020", "\\ ");
		File f = new File(path);
		 String result = null;
		 Random rand = new Random();
		 int n = 0;
		 for(Scanner sc = new Scanner(f); sc.hasNext(); )
		 {
			++n;
			String line = sc.nextLine();
			if(rand.nextInt(n) == 0)
			   result = line;         
		 }

		 return result.trim();      
	  }
	  
}