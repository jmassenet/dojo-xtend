package dojo.xtend.kata4.solution;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import dojo.xtend.kata4.FileCrawler;

public class JavaFileCrawler implements FileCrawler {

    @Override
    public DirectoryTree getDirectoryTree(String path) throws IOException {
        return getDirectoryTree(path, null);
    }

    @Override
    public DirectoryTree getDirectoryTree(String path, FileFilter filter) throws IOException {
        return new JavaDirectoryTree(buildInfo(new File(path).getCanonicalFile(), filter));
    }

    private ItemInfo buildInfo(File file, FileFilter filter) {
        if (file.isFile()) {
            return new JavaFileInfo(file.getName(), file.length());
        }

        File[] files;
        if (filter == null) {
            files = file.listFiles();
        } else {
            files = file.listFiles(filter);
        }

        List<ItemInfo> result = new ArrayList<FileCrawler.ItemInfo>(files.length);
        for (File subFile : files) {
            result.add(buildInfo(subFile, filter));
        }

        return new JavaDirectoryInfo(file.getName(), result);
    }

    private static class JavaDirectoryTree implements DirectoryTree {
        private final ItemInfo root;

        private JavaDirectoryTree(ItemInfo root) {
            super();
            this.root = root;
        }

        @Override
        public ItemInfo getRoot() {
            return root;
        }

        @Override
        public String getView() {
            return buildView(new StringBuilder(), root, "").toString();
        }

        private StringBuilder buildView(StringBuilder sb, ItemInfo item, String indent) {
            sb.append(indent);
            if (item instanceof JavaFileInfo) {
                sb.append("+ ").append(item.getName()).append("  (").append(((JavaFileInfo) item).getSize()).append(")\n");
            } else {
                sb.append(item.getName()).append("\n");
                for (ItemInfo subItem : ((JavaDirectoryInfo) item).getContents()) {
                    buildView(sb, subItem, indent + "  ");
                }
            }
            return sb;
        }
    }

    private static class JavaAbstractFileInfo implements ItemInfo {
        private final String name;

        JavaAbstractFileInfo(String name) {
            super();
            this.name = name;
        }

        @Override
        public String getName() {
            return name;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    private static final class JavaDirectoryInfo extends JavaAbstractFileInfo implements DirectoryInfo {
        private final List<ItemInfo> contents;

        JavaDirectoryInfo(String name, List<ItemInfo> contents) {
            super(name);
            this.contents = contents;
            Collections.sort(contents, new Comparator<ItemInfo>() {
                @Override
                public int compare(ItemInfo o1, ItemInfo o2) {
                    if (o1 instanceof JavaDirectoryInfo && o2 instanceof JavaFileInfo) {
                        return -1;
                    } else if (o1 instanceof JavaFileInfo && o2 instanceof JavaDirectoryInfo) {
                        return 1;
                    }

                    return o1.getName().compareTo(o2.getName());
                }
            });
        }

        @Override
        public List<ItemInfo> getContents() {
            return contents;
        }
    }

    private static final class JavaFileInfo extends JavaAbstractFileInfo implements FileInfo {
        private long size;

        JavaFileInfo(String name, long size) {
            super(name);
            this.size = size;
        }

        @Override
        public long getSize() {
            return size;
        }
    }
}
