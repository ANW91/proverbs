package HelloLucene;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Random;
 
public class MarkovChain {
	
    private static Random r = new Random();
	
	private static Map<String, List<String>> dict1 = new HashMap<>();
	private static Map<String, List<String>> dict2 = new HashMap<>();
	private static Map<String, List<String>> dict3 = new HashMap<>();
	
	public static void init(String filePath) throws IOException {
		BufferedReader file = new BufferedReader(new FileReader(filePath));
		String line;
		while ((line = file.readLine())!= null){
			String[] words = line.toLowerCase().trim().split(" ");
			for (int i = 0; i < (words.length - 2); ++i) {
				StringBuilder key = new StringBuilder(words[i]);
				for (int j = i + 1; j < i + 2; ++j) {
					key.append(' ').append(words[j]);
				}
				String value = (i + 2 < words.length) ? words[i + 2] : ".";
				if (!dict2.containsKey(key.toString())) {
					ArrayList<String> list = new ArrayList<>();
					list.add(value);
					dict2.put(key.toString(), list);
				} else {
					dict2.get(key.toString()).add(value);
				}
			}
		}
		file = new BufferedReader(new FileReader(filePath));
		while ((line = file.readLine())!= null){
			String[] words = line.toLowerCase().trim().split(" ");
			for (int i = 0; i < (words.length - 3); ++i) {
				StringBuilder key = new StringBuilder(words[i]);
				for (int j = i + 1; j < i + 3; ++j) {
					key.append(' ').append(words[j]);
				}
				String value = (i + 3 < words.length) ? words[i + 3] : ".";
				if (!dict3.containsKey(key.toString())) {
					ArrayList<String> list = new ArrayList<>();
					list.add(value);
					dict3.put(key.toString(), list);
				} else {
					dict3.get(key.toString()).add(value);
				}
			}
		}
		file = new BufferedReader(new FileReader(filePath));
		while ((line = file.readLine())!= null){
			String[] words = line.toLowerCase().trim().split(" ");
			for (int i = 0; i < (words.length - 1); ++i) {
				StringBuilder key = new StringBuilder(words[i]);
				for (int j = i + 1; j < i + 1; ++j) {
					key.append(' ').append(words[j]);
				}
				String value = (i + 1 < words.length) ? words[i + 1] : ".";
				if (!dict1.containsKey(key.toString())) {
					ArrayList<String> list = new ArrayList<>();
					list.add(value);
					dict1.put(key.toString(), list);
				} else {
					dict1.get(key.toString()).add(value);
				}
			}
		}
	}
 
    public static String markov(int keySize, boolean variablekey) {
		boolean d1=false, d2=false;
		Map<String, List<String>> dict = new HashMap<>();
		if (keySize == 1)
		{
			dict = dict1;
			d1=true;
			d2=true;
		}else if (keySize == 3)
		{
			dict = dict3;
		}
		else
		{
			dict = dict2;
			d2=true;
		}
        int n = 0;
        int rn = r.nextInt(dict.size());
        String prefix = (String) dict.keySet().toArray()[rn];
        List<String> output = new ArrayList<>(Arrays.asList(prefix.split(" ")));
 
        while (true) {
			List<String> suffix = dict.get(prefix);
			if(suffix == null){
				if(variablekey){
					if(!d2){
						dict = dict2;
						keySize = 2;
						prefix = output.stream().skip(++n).limit(keySize).reduce("", (a, b) -> a + " " + b).trim();
						d2 = true;

					}
					else if(!d1){
						dict = dict1;
						keySize = 1;
						prefix = output.stream().skip(++n).limit(keySize).reduce("", (a, b) -> a + " " + b).trim();
						d1 = true;
					}
					else{
						return output.stream().reduce("", (a, b) -> a + " " + b);
					}
				}
				else{
					return output.stream().reduce("", (a, b) -> a + " " + b);
				}
				continue;
			}

            if (suffix.size() == 1) {
                if (Objects.equals(suffix.get(0), "")){
					rn = r.nextInt(dict.size());
					prefix = (String) dict.keySet().toArray()[rn];
					continue;
				}
                output.add(suffix.get(0));
            } else {
                rn = r.nextInt(suffix.size());
                output.add(suffix.get(rn));
            }
            n++;
            prefix = output.stream().skip(n).limit(keySize).reduce("", (a, b) -> a + " " + b).trim();
        }
    }
 
}