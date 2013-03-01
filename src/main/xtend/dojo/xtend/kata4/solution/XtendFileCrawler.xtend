package dojo.xtend.kata4.solution

import dojo.xtend.kata4.FileCrawler$DirectoryTree
import dojo.xtend.kata4.FileCrawler$ItemInfo
import dojo.xtend.kata4.FileCrawler$DirectoryInfo
import dojo.xtend.kata4.FileCrawler$FileInfo
import java.util.List
import dojo.xtend.kata4.FileCrawler
import java.io.IOException
import java.io.FileFilter
import java.io.File
import java.util.ArrayList

class XtendFileCrawler implements FileCrawler {
    override getDirectoryTree(String path) throws IOException {
        getDirectoryTree(path, null);
    }

    override getDirectoryTree(String path, FileFilter filter) throws IOException {
        new XtendDirectoryTree(buildInfo(new File(path).canonicalFile, filter))
    }

    def private buildInfo(File file, FileFilter filter) {
        if (file.isFile) {
            new XtendFileInfo(file.name, file.length)
        } else {
            val File[] files = if(file.isFile) file.listFiles() else file.listFiles(filter)
            val result = new ArrayList<ItemInfo>
            files.forEach [
                result += buildInfo(it, filter)
            ]
            new XtendDirectoryInfo(file.name, result)
        }
    }
}

@Data
class XtendDirectoryTree implements DirectoryTree {
    val ItemInfo root
    
    override getView() {
        buildView(new StringBuilder, root, "").toString
    }
    
    def buildView(StringBuilder sb, ItemInfo item, String indent) {
        sb.append(indent)
        switch item {
            XtendFileInfo:
                sb.append('+ ').append(item.name).append('  (').append(item.size).append(')\n')
                
            XtendDirectoryInfo: {
                sb.append(item.name).append('\n')
                for (ItemInfo subItem : item.contents) {
                    buildView(sb, subItem, indent + "  ");
                }
                sb
            }
        }
    }
}

@Data
class XtendAbstractFileInfo implements ItemInfo {
    val String name
    
    override toString() {
        name
    }
}

@Data
class XtendDirectoryInfo extends XtendAbstractFileInfo implements DirectoryInfo {
    val List<ItemInfo> contents
    
    new(String name, List<ItemInfo> contents) {
        super(name)
        this._contents = contents
        contents.sort [o1, o2 |
            if (o1.^class == typeof(XtendDirectoryInfo) && o2.^class == typeof(XtendFileInfo)) {
                -1
            } else if (o1.^class == typeof(XtendFileInfo) && o2.^class == typeof(XtendDirectoryInfo)) {
                1
            } else {
                o1.getName.compareTo(o2.getName)
            }
        ]
    }
}

@Data
class XtendFileInfo extends XtendAbstractFileInfo implements FileInfo {
    val long size;
}