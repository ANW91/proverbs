// from: https://github.com/erichunzeker/Dictionary-Autocomplete
// I did the same project in college, but his code was easier to work with.

package HelloLucene;

public class DLBNode
{
    public char value;
    public DLBNode rightSib;
    public DLBNode child;

    public DLBNode()
    {

    }

    public DLBNode(char value)
    {
        this(value, null, null);
    }

    public DLBNode(char value, DLBNode rightSib, DLBNode child)
    {
        this.value = value;
        this.rightSib = rightSib;
        this.child = child;
    }
}