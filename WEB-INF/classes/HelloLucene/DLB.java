// from: https://github.com/erichunzeker/Dictionary-Autocomplete
// I did the same project in college, but his code was easier to work with.

package HelloLucene;

import java.io.*;
import java.util.ArrayList;
import java.util.Map;

public class DLB {
    private DLBNode root;
    private DLBNode suggestionRoot;


    public DLB() {
        root = new DLBNode();
        suggestionRoot = new DLBNode();
    }

    public void setTrie(String filename) throws IOException {
        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(filename));

            String word;

            while ((word = bufferedReader.readLine()) != null) {
                word += "$";
                if (filename.substring(filename.length()-14).equals("dictionary.txt"))
                    insert(word, root);
                else{ insert(word, suggestionRoot);}
            }
        } catch (FileNotFoundException f) {
            System.out.println("File not Found");
        }

    }

    public void insert(String word, DLBNode root) {
        DLBNode curr = root;

        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);

            if (i > 0)
                while (curr.rightSib != null && curr.value != word.charAt(i - 1))
                    curr = curr.rightSib;

            if (curr.child == null)
                addChild(curr, c);

            else if (curr.child.value != c && !searchSibling(curr.child, c))
                addSibling(curr.child, c);

            curr = curr.child; //go to next character in word
        }
    }


    public void addSibling(DLBNode curr, char c) {
        while (curr.rightSib != null)
            curr = curr.rightSib;

        curr.rightSib = new DLBNode(c);
    }

    public void addChild(DLBNode parent, char c) {
        parent.child = new DLBNode(c);
    }


    public boolean searchSibling(DLBNode currLevel, char target) {

        while (currLevel != null) {
            if (currLevel.value == target)
                return true;
            currLevel = currLevel.rightSib;
        }
        return false;
    }

    public DLBNode search(String word, DLBNode root) {
        DLBNode curr = root;

        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);

            if (curr.child == null)
                return null;
            else if (curr.child.value == c)
                curr = curr.child;

            else if (!searchSibling(curr.child, c))
                return null;

            else if (curr.child.value != c && searchSibling(curr.child, c))
            {
                curr = curr.child;
                while (curr.rightSib != null && curr.value != word.charAt(i))
                    curr = curr.rightSib;
            }
        }
        return curr;
    }

    public ArrayList<String> getSuggestions(ArrayList<String> suggestions, String word, boolean type) {
        if (suggestions == null)
            suggestions = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        sb.append(word);
        DLBNode curr;
        if (type)
            curr = search(word, root);
        else
            curr = search(word, suggestionRoot);

        if (findSuggestions(suggestions, curr, sb, 1))
            return suggestions;
        else
            return suggestions;
    }

    public boolean findSuggestions(ArrayList<String> arrayList, DLBNode curr, StringBuilder sb, int direction) {

        boolean done = false;
        while (arrayList.size() <= 5) {
            if (direction != 5) {
                if (arrayList.size() == 5)
                    return true;
                if (curr.value == '$')
                {
                    sb.deleteCharAt(sb.length() - 1);
                    if (!arrayList.contains(sb.toString()))
                        arrayList.add(sb.toString());
                } else {
                    if (direction != 2)
                        done = findSuggestions(arrayList, curr = curr.child, sb.append(curr.value), 3);

                    if (curr.rightSib != null)
                        direction = 2;
                    else
                        direction = 1;

                    if (!done && direction != 1)
                        done = findSuggestions(arrayList, curr = curr.rightSib, sb.append(curr.value), 1);

                    while (!done && curr.rightSib != null)
                        done = findSuggestions(arrayList, curr = curr.rightSib, sb.append(curr.value), 1);
                }

            }

            if (sb.length() > 0 && direction == 1 || sb.length() > 0 && direction == 2)
                sb.deleteCharAt(sb.length() - 1);

            return done;
        }
        return false;
    }

    public void addToHistory(String word, String path) throws IOException {
        try {
            FileWriter fileWriter = new FileWriter(path, true);
            BufferedWriter fbw = new BufferedWriter(fileWriter);
            fbw.write(word);
            insert(word + "$", suggestionRoot);
            fbw.newLine();
            fbw.close();

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public void setMap(Map<String, Integer> history, String path) throws IOException {
        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(path));

            String word;

            while ((word = bufferedReader.readLine()) != null)
            {
                if (history.containsKey(word))
                    history.replace(word, history.get(word), (history.get(word) + 1));
                else
                    history.put(word, 1);

            }
        } catch (FileNotFoundException f) {
            System.out.println("File not Found");
        }
    }
	
}