package dojo.xtend.kata4;

import java.io.FileFilter;
import java.io.IOException;
import java.util.List;

/**
 * Crawls the file system and create data structures.
 */
public interface FileCrawler {
    /**
     * Builds a representation of the file system at the given path.
     * 
     * @param path
     *            The path to start crawling from.
     * @return The representation.
     * @throws IOException
     *             If something goes wrong.
     */
    DirectoryTree getDirectoryTree(String path) throws IOException;

    /**
     * Builds a representation of the file system at the given path. Only includes the items
     * matching the given filter.
     * 
     * @param path
     *            The path to start crawling from.
     * @param filter
     *            The filter to run every item by.
     * @return The representation.
     * @throws IOException
     *             If something goes wrong.
     */
    DirectoryTree getDirectoryTree(String path, FileFilter filter) throws IOException;

    /**
     * A structure representing the file system for a given root path.
     */
    public interface DirectoryTree {
        /**
         * Gets the root element for the structure.
         * 
         * @return The root element.
         */
        ItemInfo getRoot();

        /**
         * Gets a textual representation of the structure.
         * 
         * <ul>
         * <li>If {@link #getRoot()} is a {@link FileInfo}, prints '+ ' followed by its name, two
         * spaces, and the size within parenthesis.</li>
         * <li>If <code>getRoot()</code> is a {@link DirectoryInfo}, prints each child using the
         * same algorithm, but adding a 2-space indentation.</li>
         * </ul>
         * <p>
         * Example:
         * </p>
         * 
         * <pre>
         * materials
         *   dir1
         *     + file-1-1.java  (13)
         *     + file-1-2.xtend  (94)
         *   dir2
         *     + file-2-1  (80)
         *   + file-1.txt  (10)
         *   + file-2.java  (76)
         * </pre>
         * 
         * @return The String representation of the structure.
         */
        String getView();
    }

    /**
     * A file system item.
     */
    public interface ItemInfo {
        /**
         * Gets the item name.
         * 
         * @return The name.
         */
        String getName();
    }

    /**
     * A file system directory item.
     */
    public interface DirectoryInfo extends ItemInfo {
        /**
         * Gets a sorted list of the directory contents.
         * <ol>
         * <li>First sort criteria is the type: directories first, files second.</li>
         * <li>Second sort criteria is name: alphabetical, ascending.</li>
         * </ol>
         * 
         * @return
         */
        List<ItemInfo> getContents();
    }

    /**
     * A file system file item.
     */
    public interface FileInfo extends ItemInfo {
        /**
         * Gets the size of the file.
         * 
         * @return The size of the file in bytes.
         */
        long getSize();
    }
}
