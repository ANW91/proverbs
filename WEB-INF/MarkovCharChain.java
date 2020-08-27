import java.io.IOException;
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
 
public class MarkovCharChain {
    private static Random r = new Random();
 
    private static String markov(String filePath, int keySize, int outputSize) throws IOException {
        if (keySize < 1) throw new IllegalArgumentException("Key size can't be less than 1");
        Path path = Paths.get(filePath);
        byte[] bytes = Files.readAllBytes(path);
        String text = new String(bytes).replaceAll("[\n\r]", " ").trim();
		char[] words = text.toCharArray();
        if (outputSize < keySize || outputSize >= words.length) {
            throw new IllegalArgumentException("Output size is out of range");
        }
        Map<String, List<Character>> dict = new HashMap<>();
 
        for (int i = 0; i < (words.length - keySize); ++i) {
            StringBuilder key = new StringBuilder(words[i]);
            for (int j = i + 1; j < i + keySize; ++j) {
                key.append(words[j]);
            }
            char value = '.'; 
			if (i + keySize < words.length)
				value = words[i + keySize];
			else
				System.out.println("didn't");
            if (!dict.containsKey(key.toString())) {
                ArrayList<Character> list = new ArrayList<Character>();
                list.add(value);
                dict.put(key.toString(), list);
            } else {
                dict.get(key.toString()).add(value);
            }
        }
 
        int n = 0;
        int rn = r.nextInt(dict.size());
        String prefix = (String) dict.keySet().toArray()[rn];
        List<String> output = new ArrayList<>(Arrays.asList(prefix.split(" ")));
		
		/*for(Map.Entry<String, List<Character>> e : dict.entrySet()){
			for(Character e1 : e.getValue()){
				if(e1 == null){
					e.getValue().remove(e1);
				}
					
				System.out.println(e.getKey() + " = "+ e1);
			}
		}*/
		
        while (true) {
			System.out.println(prefix);
			for(Map.Entry<String, List<Character>> e : dict.entrySet()){
				if(prefix == e.getKey()){
					for(Character e1 : e.getValue()){
						System.out.println(e.getKey() + " = "+ e1);
					}
				}
		}
            List<Character> suffix = dict.get(prefix);
			if(suffix == null)
			{
				if (output.size() >= outputSize) return output.stream().limit(outputSize).reduce("", (a, b) -> a + "" + b);
				rn = r.nextInt(dict.size());
				prefix = (String) dict.keySet().toArray()[rn];
				continue;
				
			}	
            if (suffix.size() == 1) {
                if (Objects.equals(String.valueOf(suffix.get(0)), "")) return output.stream().reduce("", (a, b) -> a + "" + b);
                output.add(String.valueOf(suffix.get(0)));
            } else {
                rn = r.nextInt(suffix.size());
				System.out.println(rn);
                output.add(String.valueOf(suffix.get(rn)));
            }
            if (output.size() >= outputSize) return output.stream().limit(outputSize).reduce("", (a, b) -> a + "" + b);
            n++;
            prefix = output.stream().skip(n).limit(keySize).reduce("", (a, b) -> a + " " + b).trim();
        }
    }
 
    public static void main(String[] args) throws IOException {
        System.out.println(markov("allProverbs.txt", 10, 50));
    }
}