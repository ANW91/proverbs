package HelloLucene;

import java.io.*;
import java.util.*;
import java.net.URL;
import java.net.URI;
import java.net.URLDecoder;

public class allProverbs{
	public String[][] getAllProverbs(String path) throws FileNotFoundException, UnsupportedEncodingException, IOException 
	{
		path = URLDecoder.decode(path,"UTF-8");
		path = path.replaceAll("file:/", "");
		path = path.replaceAll("\\u0020", "\\ ");
		
		String path1 = path+"\\africanproverbs.txt";
		String path2 = path+"\\chineseproverbs.txt";
		String path3 = path+"\\englishproverbs.txt";
		String path4 = path+"\\jewishproverbs.txt";
		String path5 = path+"\\latinproverbs.txt";
		String path6 = path+"\\norseproverbs.txt";
		String path7 = path+"\\russianproverbs.txt";
		String path8 = path+"\\yiddishproverbs.txt";
		
		String [][] tables = new String[8][];
		
		String[] result = readProverbs(path1);      
		tables[0] = result;
		
		result = readProverbs(path2);      
		tables[1] = result;
		
		result = readProverbs(path3);      
		tables[2] = result;
		
		result = readProverbs(path4);      
		tables[3] = result;
		
		result = readProverbs(path5);      
		tables[4] = result;
		
		result = readProverbs(path6);      
		tables[5] = result;
		
		result = readProverbs(path7);      
		tables[6] = result;
		
		result = readProverbs(path8);      
		tables[7] = result;
		
		return tables;
	}
	
	private String[] readProverbs(String path) throws FileNotFoundException, IOException
	{
		File filename = new File(path);
		
		ArrayList<String> result = new ArrayList<>();
 
		try (FileReader f = new FileReader(filename)) {
			StringBuffer sb = new StringBuffer();
			while (f.ready()) {
				char c = (char) f.read();
				if (c == '\n') {
					result.add(sb.toString());
					sb = new StringBuffer();
				} else {
					sb.append(c);
				}
			}
			if (sb.length() > 0) {
				result.add(sb.toString());
			}
		}
		return result.toArray(new String[result.size()]);
	}
}