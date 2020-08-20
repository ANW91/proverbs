package HelloLucene;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.File;
import java.io.IOException;
import java.util.*;


public class autoComp
{
	private final static boolean DEBUG = false;
	private static DLB dlb;
	private static Map <String, Integer> history = new HashMap<>();
	private static String usr;
	
	public static void init(String path) throws IOException {
		String dic = path+"dictionary.txt";
		usr = path+"user_history.txt";
		
		dlb = new DLB();
		
		File file = new File(usr);

        if(!file.exists())
            file.createNewFile();

        dlb.setTrie(dic);
        dlb.setMap(history, usr);
        dlb.setTrie(usr);		
		
		if(DEBUG)
			System.out.println("init complete");
	}
	
    public static ArrayList<String> auto(String arg, boolean add) throws IOException
    {
        ArrayList<String> suggestions = null;
        ArrayList<String> suggestionsHistory;


        final char EXIT = '!';
        char input;
        int count = 0;
        String word = "";
		

        for(char c : arg.toCharArray()){
            input = c;

            if(add)
            {
                dlb.addToHistory(arg, usr);

                if(history.containsKey(arg))
                    history.replace(arg, history.get(arg),
                            (history.get(arg)+1));
                else
                    history.put(arg, 1);
				if(DEBUG)
					System.out.println("added "+arg);
                word = "";
				break;
            }

            else
            {
                if(suggestions != null)
                    suggestions.clear();
                word += input;

                try{
                    suggestionsHistory = dlb.getSuggestions(suggestions, word, false);

                    for(int i = 1; i < suggestionsHistory.size(); i++)
                    {
                        Integer first = history.get(suggestionsHistory.get(i));
                        Integer second = history.get(suggestionsHistory.get(i - 1));

                        if(first > second)
                        {
                            String temp = suggestionsHistory.get(i);
                            suggestionsHistory.remove(i);
                            suggestionsHistory.add(i - 1, temp);
                        }
                    }

                    suggestions = suggestionsHistory;
                }
                catch (NullPointerException e) {
                }

                try{
                    suggestions = dlb.getSuggestions(suggestions, word, true);
                }
                catch (NullPointerException e) {
                }

                count++;
            }
        }
		return suggestions;
    }
}